import 'package:json_annotation/json_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'contact.freezed.dart';

part 'contact.g.dart';

@freezed
class Contact with _$Contact {
  factory Contact({
    @Default("") String dep,
    @Default("") String tel,
    @Default("") String cname,
    @Default("") String email,
  }) = _Contact;

  factory Contact.fromJson(Map<String, dynamic> json) =>
      _$ContactFromJson(json);
}
