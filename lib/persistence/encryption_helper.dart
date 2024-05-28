import 'dart:convert';
import 'dart:typed_data';
import 'package:encrypt/encrypt.dart' as encrypt;

class EncryptionHelper {
  static final _key = encrypt.Key.fromUtf8('32-character-long-key-');
  static final _iv = encrypt.IV.fromLength(16);

  static String encryptFile(Uint8List data) {
    final encrypter = encrypt.Encrypter(encrypt.AES(_key));
    final encrypted = encrypter.encryptBytes(data, iv: _iv);
    return base64.encode(encrypted.bytes);
  }

  static Uint8List decryptFile(String base64Data) {
    final encrypter = encrypt.Encrypter(encrypt.AES(_key));
    final decrypted = encrypter.decryptBytes(
      encrypt.Encrypted(base64.decode(base64Data)),
      iv: _iv,
    );
    return Uint8List.fromList(decrypted);
  }
}