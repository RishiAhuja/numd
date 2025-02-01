import 'package:numd/numd.dart';

void main() {
  var nd = NDArray.random([3, 10], min: 10, max: 20, type: double);
  print(nd.toString());
}
