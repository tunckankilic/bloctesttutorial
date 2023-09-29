import 'dart:io';

String fixture(String fileName) =>
    File('test/fixtures/$fileName').readAsStringSync();

//now the turn of applicaiton test files