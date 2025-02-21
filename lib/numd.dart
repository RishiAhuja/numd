import 'dart:math';

class NDArray<T extends num> {
  //must be a num type
  late List<int> shape;
  late List<List<T>> _nestedLists;
  int get dimensions => shape[0];
  int get rows => shape[0];
  int get cols => shape[1];
  bool get isEmpty => _nestedLists.isEmpty;
  bool isInt() => T == int;
  bool isDouble() => T == double;
  T at(int i, int j) => _nestedLists[i][j];

  @override
  String toString() {
    final buffer = StringBuffer();
    buffer.writeln('[ ');
    for (var i = 0; i < shape[0]; i++) {
      buffer.write(' [');
      buffer.write(_nestedLists[i].join(', '));
      buffer.writeln(']${i < shape[0] - 1 ? ',' : ''}');
    }
    buffer.write(']');
    return buffer.toString();
  }

  NDArray.init(this._nestedLists, {Type type = double}) {
    shape = [_nestedLists.length, _nestedLists[0].length];
  }

  factory NDArray.zeros(List<int> dimensions, {Type type = double}) {
    return NDArray.init(
        List.generate(
            dimensions[0], (index) => List.filled(dimensions[1], 0 as T)),
        type: type);
  }

  factory NDArray.ones(List<int> dimensions, {Type type = double}) {
    return NDArray.init(
        List.generate(
          dimensions[0],
          (index) => List.filled(dimensions[1], 1 as T),
        ),
        type: type);
  }

  factory NDArray.random(List<int> dimensions,
      {double min = 0, double max = 1, Type type = double}) {
    final random = Random();
    var nestedLists = List.generate(
        dimensions[0],
        (index) => List.filled(
            dimensions[1],
            min +
                (type == int
                        ? random.nextInt(max.toInt())
                        : random.nextDouble()) *
                    (max - min) as T));
    return NDArray.init(nestedLists, type: type);
  }

  void forEach(void Function(T element) action) {
    for (var row in _nestedLists) {
      for (var element in row) {
        action(element);
      }
    }
  }

  // Operator overloads
  NDArray<T> operator +(NDArray<T> other) {
    if (this.shape.length != other.shape.length ||
        this.shape[0] != other.shape[0] ||
        this.shape[1] != other.shape[1]) {
      throw ArgumentError('Shape mismatch: $shape vs ${other.shape}');
    }
    List<List<T>> nestedLists = List.generate(
        this.shape[0],
        (i) => List.generate(this.shape[1],
            (j) => this._nestedLists[i][j] + other._nestedLists[i][j] as T));
    return NDArray.init(nestedLists);
  }

  NDArray<T> operator -(NDArray<T> other) {
    if (this.shape.length != other.shape.length ||
        this.shape[0] != other.shape[0] ||
        this.shape[1] != other.shape[1]) {
      throw ArgumentError('Shape mismatch: $shape vs ${other.shape}');
    }
    List<List<T>> nestedLists = List.generate(
        this.shape[0],
        (i) => List.generate(this.shape[1],
            (j) => this._nestedLists[i][j] - other._nestedLists[i][j] as T));
    return NDArray.init(nestedLists);
  }

  NDArray<T> operator *(NDArray<T> other) {
    if (this.shape.length != other.shape.length ||
        this.shape[0] != other.shape[0] ||
        this.shape[1] != other.shape[1]) {
      throw ArgumentError('Shape mismatch: $shape vs ${other.shape}');
    }
    List<List<T>> nestedLists = List.generate(
        this.shape[0],
        (i) => List.generate(this.shape[1],
            (j) => this._nestedLists[i][j] * other._nestedLists[i][j] as T));
    return NDArray.init(nestedLists);
  }

  NDArray<T> operator /(NDArray<T> other) {
    if (this.shape.length != other.shape.length ||
        this.shape[0] != other.shape[0] ||
        this.shape[1] != other.shape[1]) {
      throw ArgumentError('Shape mismatch: $shape vs ${other.shape}');
    }
    List<List<T>> nestedLists = List.generate(
        this.shape[0],
        (i) => List.generate(this.shape[1],
            (j) => this._nestedLists[i][j] / other._nestedLists[i][j] as T));
    return NDArray.init(nestedLists);
  }

  factory NDArray.binary(
      List<int> dimensions, bool Function(int i, int j) condition,
      {Type type = double}) {
    return NDArray.init(
      List.generate(
        dimensions[0],
        (i) => List.generate(
          dimensions[1],
          (j) => (condition(i, j) ? 1 : 0) as T,
        ),
      ),
      type: type,
    );
  }

  factory NDArray.binaryRand(List<int> dimensions, {Type type = double}) {
    final random = Random();
    return NDArray.init(
      List.generate(
        dimensions[0],
        (i) => List.generate(
          dimensions[1],
          (j) => (random.nextBool() ? 1 : 0) as T,
        ),
      ),
      type: type,
    );
  }
}

class LinearAlgebra {
  static NDArray<T> matmul<T extends num>(NDArray<T> a, NDArray<T> b) {
    if (a.cols != b.rows) {
      throw ArgumentError(
          'Matrix dimensions mismatch: ${a.shape} and ${b.shape}');
    }

    List<List<T>> result = List.generate(
      a.rows,
      (i) => List<T>.generate(
        b.cols,
        (j) {
          T sum = 0 as T;
          for (var k = 0; k < a.cols; k++) {
            sum = (sum + a.at(i, k) * b.at(k, j)) as T;
          }
          return sum;
        },
      ),
    );

    return NDArray<T>.init(result);
  }
}

/* Rather than directly concatenating strings 
(which creates new string objects each time), 
the code uses a StringBuffer. This is a more 
efficient way to build strings incrementally, 
especially when dealing with larger data structures. */
