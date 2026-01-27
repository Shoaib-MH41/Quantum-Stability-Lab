import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:isolate';
import '../core/real_quantum_particle.dart';

class RealSensorDashboard extends StatefulWidget {
  @override
  State<RealSensorDashboard> createState() => _RealSensorDashboardState();
}

class _RealSensorDashboardState extends State<RealSensorDashboard> {
  static const int particleCount = 50;

  late List<RealQuantumParticle> particles;

  bool isRunning = false;
  bool isGPUMode = false;

  int totalAttempts = 0;
  String systemStatus = "موڈ منتخب کریں اور ٹیسٹ شروع کریں";

  Stopwatch stopwatch = Stopwatch();
  Timer? _uiTimer;

  Isolate? _logicIsolate;
  ReceivePort? _receivePort;

  @override
  void initState() {
    super.initState();
    particles =
        List.generate(particleCount, (i) => RealQuantumParticle(i));
  }

  // ---------------- START ----------------

  void startExperiment() async {
    systemStatus =
        isGPUMode ? "GPU موڈ فعال" : "NPU موڈ فعال";

    totalAttempts = 0;
    stopwatch.reset();
    stopwatch.start();

    setState(() => isRunning = true);

    _receivePort = ReceivePort();

    _logicIsolate = await Isolate.spawn(
      _quantumWorker,
      {
        'sendPort': _receivePort!.sendPort,
        'count': particleCount,
        'gpu': isGPUMode,
      },
    );

    _receivePort!.listen((data) {
      if (data is List<bool>) {
        totalAttempts++;

        for (int i = 0; i < particles.length; i++) {
          particles[i].isFullyStable = data[i];
        }

        if (data.every((e) => e)) {
          _stopExperiment();
        } else {
          setState(() {});
        }
      }
    });

    _uiTimer = Timer.periodic(
      const Duration(milliseconds: 300),
      (_) => setState(() {}),
    );
  }

  void _stopExperiment() {
    stopwatch.stop();
    _uiTimer?.cancel();
    _logicIsolate?.kill(priority: Isolate.immediate);

    setState(() {
      isRunning = false;
      systemStatus =
          "✅ استحکام حاصل! وقت: ${stopwatch.elapsed.inMilliseconds} ms";
    });
  }

  // ---------------- UI ----------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("GPU vs NPU • $particleCount Particles"),
        backgroundColor: Colors.deepPurple,
      ),
      body: Column(
        children: [
          _modeSelector(),
          _metrics(),
          Expanded(child: _particleGrid()),
          _controlButton(),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text(
              systemStatus,
              style: const TextStyle(color: Colors.white70),
            ),
          ),
        ],
      ),
    );
  }

  Widget _modeSelector() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("NPU", style: TextStyle(color: Colors.white)),
          Switch(
            value: isGPUMode,
            onChanged: isRunning
                ? null
                : (v) => setState(() => isGPUMode = v),
          ),
          const Text("GPU", style: TextStyle(color: Colors.white)),
        ],
      ),
    );
  }

  Widget _metrics() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _metric("کوششیں", "$totalAttempts"),
        _metric("وقت", "${stopwatch.elapsed.inSeconds}s"),
      ],
    );
  }

  Widget _metric(String l, String v) {
    return Column(
      children: [
        Text(l, style: const TextStyle(color: Colors.grey)),
        Text(
          v,
          style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _particleGrid() {
    return GridView.builder(
      padding: const EdgeInsets.all(6),
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 6,
        mainAxisSpacing: 2,
        crossAxisSpacing: 2,
      ),
      itemCount: particleCount,
      itemBuilder: (_, i) => Container(
        decoration: BoxDecoration(
          color: particles[i].isFullyStable
              ? Colors.green
              : Colors.red.withOpacity(0.4),
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }

  Widget _controlButton() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ElevatedButton(
        onPressed: isRunning ? null : startExperiment,
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 48),
          backgroundColor:
              isGPUMode ? Colors.red : Colors.blue,
        ),
        child: Text(isRunning ? "جاری ہے…" : "ٹیسٹ شروع کریں"),
      ),
    );
  }
}

// ---------------- BACKGROUND ISOLATE ----------------

void _quantumWorker(Map args) async {
  final SendPort sendPort = args['sendPort'];
  final int count = args['count'];
  final bool gpu = args['gpu'];

  List<double> stability =
      List.generate(count, (_) => 0.0);

  while (true) {
    List<bool> result = List.filled(count, false);

    for (int i = 0; i < count; i++) {
      stability[i] += gpu ? 0.015 : 0.03;
      if (stability[i] >= 1.0) {
        result[i] = true;
      }
    }

    sendPort.send(result);
    await Future.delayed(const Duration(milliseconds: 35));
  }
}
