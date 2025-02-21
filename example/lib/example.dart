import 'package:numd/numd.dart';

void main() {
  // Basic array creation
  var array = NDArray.init([
    [1, 2, 3],
    [4, 5, 6]
  ]);
  print(array);

  // Binary array with diagonal ones
  var diagonal = NDArray<int>.binary([3, 3], (i, j) => i == j);
  print(diagonal);

  // Random binary array
  var randomBinary = NDArray<int>.binaryRand([2, 2]);
  print(randomBinary);

  // Array operations
  var a = NDArray.ones([2, 2]);
  var b = NDArray.zeros([2, 2]);
  print(a + b);
}
