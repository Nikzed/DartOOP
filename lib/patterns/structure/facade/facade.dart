import 'dart:io';

class VideoFile {
  String _name;
  String _codecType;

  VideoFile(_name) {
    this._name = _name;
    _codecType = _name.substring(_name.indexOf('.') + 1);
  }

  String getCodecType() => _codecType;

  String getName() => _name;
}

abstract class Codec {
  String type;
}

class MPEG4CompressionCodec implements Codec {
  @override
  String type = 'mp4';
}

class OggCompressionCodec implements Codec {
  @override
  String type = 'ogg';
}

class CodecFactory {
  static Codec extract(VideoFile file) {
    String type = file.getCodecType();
    if (type == 'mp4') {
      print('CodecFactory: extracting mpeg audio...');
      return MPEG4CompressionCodec();
    } else {
      print('CodecFactory: extracting ogg audio...');
      return OggCompressionCodec();
    }
  }
}

class BitrateReader {
  static VideoFile read(VideoFile file, Codec codec) {
    print('BitrateReader: reading file...');
    return file;
  }

  static VideoFile convert(VideoFile buffer, Codec codec) {
    print('BitrateReader: writing file...');
    return buffer;
  }
}

class AudioMixer {
  File fix(VideoFile result) {
    print('AudioMixer: fixing audio...');
    return File('tmp');
  }
}

class VideoConversionFacade {
  File convertVideo(String fileName, String format) {
    print('VideoConversionFacade: conversion started.');
    VideoFile file = VideoFile(fileName);
    Codec sourceCodec = CodecFactory.extract(file);
    Codec destinationCodec;
    if (format == 'mp4') {
      destinationCodec = OggCompressionCodec();
    } else {
      destinationCodec = MPEG4CompressionCodec();
    }
    VideoFile buffer = BitrateReader.read(file, sourceCodec);
    VideoFile intermediateResult =
        BitrateReader.convert(buffer, destinationCodec);
    File result = (AudioMixer()).fix(intermediateResult);
    print('VideoConversionFacade: conversion completed.');
    return result;
  }
}

// создан для облегчения работы со сложной структурой классов
void main() {
  VideoConversionFacade converter = VideoConversionFacade();
  File mp4Video = converter.convertVideo('youtubevideo.ogg', 'mp4');
}
