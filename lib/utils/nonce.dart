import 'package:pinenacl/api.dart';

Uint8List? nonce;

Uint8List generateNonce() {
  nonce = PineNaClUtils.randombytes(24);
  return nonce!;
}
