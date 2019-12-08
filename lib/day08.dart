// --- Day 8: Space Image Format ---
// https://adventofcode.com/2019/day/8

import 'dart:typed_data';

class ImageLayer {
  final Int8List data;
  final int length, height;

  ImageLayer(this.length, this.height) : data = Int8List(length * height);

  int countDigit(int digit) => data.where((d) => d == digit).length;
  int get oneAndTwoDigitsMultiplied => countDigit(1) * countDigit(2);

  static Iterable<ImageLayer> getLayers(String input,
      {int pixelsWide = 25, int pixelsTall = 6}) sync* {
    for (var i = 0; i < input.length;) {
      final layer = ImageLayer(pixelsWide, pixelsTall);

      for (var k = 0; k < layer.data.length; k++, i++) {
        layer.data[k] = int.parse(input[i]);
      }

      yield layer;
    }
  }

  void addLayer(ImageLayer layer) {
    if (data.length != layer.data.length) {
      throw Exception('The two layers does not have the same dimensions!');
    }

    for (var i = 0; i < data.length; i++) {
      if (data[i] == 2) {
        // transparent
        data[i] = layer.data[i];
      }
    }
  }

  @override
  String toString() {
    final buffer = StringBuffer();

    for (var i = 0; i < data.length; i++) {
      if (i % length == 0 && i != 0) {
        buffer.writeln();
      }
      buffer.write(data[i] == 1 ? '█' : ' ');
    }

    return buffer.toString();
  }
}

int solveA(String input) => ImageLayer.getLayers(input)
    .reduce((a, b) => a.countDigit(0) < b.countDigit(0) ? a : b)
    .oneAndTwoDigitsMultiplied;

String solveB(String input) =>
    ImageLayer.getLayers(input).reduce((a, b) => a..addLayer(b)).toString();
