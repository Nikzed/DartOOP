import 'dart:io';

abstract class DataSource{
  void writeData(String data);
  String readData();
}

class FileDataSource implements DataSource{

  String _name;

  FileDataSource(this._name);

  @override
  String readData() {
    // TODO: implement readData
    throw UnimplementedError();
  }

  @override
  void writeData(String data) {
    // read from a file
    File(_name).readAsString().then((String contents){
      print(contents);
    });
  }

}

void main() {
  FileDataSource fds = FileDataSource('name');
  print(fds._name);
}