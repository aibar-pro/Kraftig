import 'dart:convert';
import 'dart:typed_data';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class EncryptionHelper {
  static String getEncryptionKey() {
    final key = dotenv.env['ENCRYPTION_KEY'];
    if (key == null || key.length != 32) {
      throw ArgumentError('Invalid encryption key');
    }
    return key;
  }
  
  static final _iv = encrypt.IV.fromLength(16);

  static String encryptFile(Uint8List data) {
    final keyString = getEncryptionKey();
    final key = encrypt.Key.fromUtf8(keyString);
    final encrypter = encrypt.Encrypter(encrypt.AES(key));
    final encrypted = encrypter.encryptBytes(data, iv: _iv);
    return base64.encode(encrypted.bytes);
  }

  static Uint8List decryptFile(String base64Data) {
    final keyString = getEncryptionKey();
    final key = encrypt.Key.fromUtf8(keyString);
    final encrypter = encrypt.Encrypter(encrypt.AES(key));
    final decrypted = encrypter.decryptBytes(
      encrypt.Encrypted(base64.decode(base64Data)),
      iv: _iv,
    );
    return Uint8List.fromList(decrypted);
  }
}