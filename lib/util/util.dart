import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:intl/intl.dart';

String currencyFormat(int price) {
  var format = NumberFormat('###,###,### 원');
  return format.format(price);
}

String encodeJWTWithHS256_Json(Map<dynamic, dynamic> payload, String secretKey) {
  var header = {"alg": "HS256", "typ": "JWT"};
  String headerStr = json.encode(header);
  String headerBase64 =
      base64Url.encode(utf8.encode(headerStr)).replaceAll('=', '');

  String payloadStr = json.encode(payload);
  String payloadBase64 =
      base64Url.encode(utf8.encode(payloadStr)).replaceAll('=', '');

  String signatureString = '$headerBase64.$payloadBase64';

  final hmacSha256 = Hmac(sha256, utf8.encode(secretKey));
  final digest = hmacSha256.convert(utf8.encode(signatureString));
  String signatureBase64 = base64Url.encode(digest.bytes).replaceAll('=', '');

  return '$headerBase64.$payloadBase64.$signatureBase64';
}

String encodeJWTWithHS256_String(String payload, String secretKey) {
  var header = {"alg": "HS256", "typ": "JWT"};
  String headerStr = json.encode(header);
  String headerBase64 =
      base64Url.encode(utf8.encode(headerStr)).replaceAll('=', '');

  String payloadBase64 =
      base64Url.encode(utf8.encode(payload)).replaceAll('=', '');

  String signatureString = '$headerBase64.$payloadBase64';

  final hmacSha256 = Hmac(sha256, utf8.encode(secretKey));
  final digest = hmacSha256.convert(utf8.encode(signatureString));
  String signatureBase64 = base64Url.encode(digest.bytes).replaceAll('=', '');

  return '$headerBase64.$payloadBase64.$signatureBase64';
}
