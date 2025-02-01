import 'package:numd/numd.dart';

void main() {
  var nd = NDArray.random([3, 10], min: 10, max: 20, type: double);
  var nd2 = NDArray.random([10, 3], min: 10, max: 20, type: double);
  print(nd.toString());

  var nd3 = LinearAlgebra.matmul(nd, nd2);

  print(nd3.toString());
}
