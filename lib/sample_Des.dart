import 'dart:convert';

import 'package:dart_des/dart_des.dart';

main() {
  String key = '12345678'; // 8-byte
  String message = 'Driving in from the edge of town';
  List<int> encrypted;
  List<int> decrypted;

  print('key: $key');
  print('message: $message');

  DES desECB = DES(key: key.codeUnits, mode: DESMode.ECB);
  encrypted = desECB.encrypt(message.codeUnits);
  decrypted = desECB.decrypt(encrypted);
  print('DES mode: ECB');
  print('encrypted (base64): ${base64.encode(encrypted)}');

  String indatabase = base64.encode(encrypted);
  // print('decrypted (utf8): ${utf8.decode(decrypted)}');
  // print('encrypted: $encrypted');
  // print('decrypted: $decrypted');

  print('encrypted String: ${base64.decode(indatabase)}');
  // print('encrypted (hex): ${hex.encode(encrypted)}');
  // print('decrypted (hex): ${hex.encode(decrypted)}');

  List<int> testdec = base64.decode(indatabase);

  String yehey = utf8.decode(desECB.decrypt(testdec));;

  print(yehey);
}











//   key = '123456781234567812345678'; // 24-byte
//   DES3 des3CBC = DES3(key: key.codeUnits, mode: DESMode.CBC, iv: iv);
//   encrypted = des3CBC.encrypt(message.codeUnits);
//   decrypted = des3CBC.decrypt(encrypted);
//   print('Triple DES mode: CBC');
//   print('encrypted: $encrypted');
//   print('encrypted (hex): ${hex.encode(encrypted)}');
//   print('encrypted (base64): ${base64.encode(encrypted)}');
//   print('decrypted: $decrypted');
//   print('decrypted (hex): ${hex.encode(decrypted)}');
//   print('decrypted (utf8): ${utf8.decode(decrypted)}');
// }