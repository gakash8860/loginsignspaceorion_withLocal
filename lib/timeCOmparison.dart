import 'dart:async';
int x , y;
void main() {
  _test();
}

_test() async {
  print("start");
  await sleep1();
  await sleep2();
  print("end");
  print(DateTime.now());
  if(y.compareTo(x)>0) { print('x $x'); }
  print(DateTime.now());
  int ms = DateTime.now().millisecondsSinceEpoch;
  print('ms $ms');
  print((ms / 1000).round());
}

Future sleep1() {
  x = DateTime.now().millisecondsSinceEpoch;
  return new Future.delayed(const Duration(seconds: 1), () => print(x));
}

Future sleep2() {
  y = DateTime.now().millisecondsSinceEpoch;
  return new Future.delayed(const Duration(seconds: 10), () => print(y));
}