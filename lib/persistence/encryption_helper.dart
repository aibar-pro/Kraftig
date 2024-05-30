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

  static String encryptFile(Uint8List data) {
    final keyString = getEncryptionKey();
    final key = encrypt.Key.fromUtf8(keyString);
    final iv = encrypt.IV.fromSecureRandom(16);
    final encrypter = encrypt.Encrypter(encrypt.AES(key));
    final encrypted = encrypter.encryptBytes(data, iv: iv);
    
    final combined = iv.bytes + encrypted.bytes;
    return base64.encode(combined);
  }

  static Uint8List decryptFile(String base64Data) {
    final keyString = getEncryptionKey();
    final key = encrypt.Key.fromUtf8(keyString);

    final combined = base64.decode(base64Data);
    final iv = encrypt.IV(Uint8List.fromList(combined.sublist(0, 16)));
    final encryptedData = encrypt.Encrypted(Uint8List.fromList(combined.sublist(16)));

    final encrypter = encrypt.Encrypter(encrypt.AES(key));
    final decrypted = encrypter.decryptBytes(encryptedData, iv: iv);

    return Uint8List.fromList(decrypted);
  }
}