import 'package:numd/numd.dart';

void main() {
  // var nd = NDArray.random([3, 2], min: 10, max: 20, type: double);
  // var nd2 = NDArray.random([2, 3], min: 10, max: 20, type: double);
  // print(nd.toString());

  var n4 = NDArray.init([
    [1, 2, 3],
    [2, 3, 4],
    [3, 4, 5]
  ]);
  var n3 = NDArray.init([
    [2, 2, 3],
    [2, 3, 4],
    [3, 4, 5]
  ]);

  // var nd3 = LinearAlgebra.matmul(nd, nd2);

  print((n4 + n3).toString());
  print((n4).at(1, 1));

  n4.forEach((element) => print(element));
}
