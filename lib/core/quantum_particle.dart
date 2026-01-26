enum ParticleClassification {
  STABLE,      // ≤ 30ms
  BORDERLINE,  // 30–40ms
  UNSTABLE     // > 40ms
}

extension ParticleClassificationExtension on ParticleClassification {
  String get displayName {
    switch (this) {
      case ParticleClassification.STABLE:
        return "مستحکم";
      case ParticleClassification.BORDERLINE:
        return "سرحدی";
      case ParticleClassification.UNSTABLE:
        return "غیر مستحکم";
    }
  }
  
  Color get color {
    switch (this) {
      case ParticleClassification.STABLE:
        return Colors.green;
      case ParticleClassification.BORDERLINE:
        return Colors.orange;
      case ParticleClassification.UNSTABLE:
        return Colors.red;
    }
  }
  
  IconData get icon {
    switch (this) {
      case ParticleClassification.STABLE:
        return Icons.check_circle;
      case ParticleClassification.BORDERLINE:
        return Icons.warning;
      case ParticleClassification.UNSTABLE:
        return Icons.error;
    }
  }
}
