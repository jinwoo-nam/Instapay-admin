import 'package:json_annotation/json_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'juso.freezed.dart';
part 'juso.g.dart';

@freezed
class Juso with _$Juso {
  factory Juso({
    @Default("") String zip,
    @Default("") String user,
    @Default("") String fixed,
  }) = _Juso;
  factory Juso.fromJson(Map<String, dynamic> json) => _$JusoFromJson(json);
}