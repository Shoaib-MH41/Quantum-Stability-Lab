class LawBasedGPUCalculator {
  num calculate(String exp) {
    final p = exp.split(' ');
    final a = num.parse(p[0]);
    final op = p[1];
    final b = num.parse(p[2]);
    switch(op){
      case '+': return a+b;
      case '-': return a-b;
      case '*': return a*b;
      case '/': return b!=0 ? a/b : 0;
    }
    return 0;
  }
}
