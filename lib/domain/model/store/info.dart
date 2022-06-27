import 'package:json_annotation/json_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'info.freezed.dart';
part 'info.g.dart';

@freezed
class Info with _$Info {
  factory Info({
    @Default("") String biz,
    @Default("") String ceo,
    @Default(false) bool giro,
    @Default("") String stype,
    @Default("") String category,
    @Default(false) bool commerce,
    @Default(false) bool donation,
    @Default("") String industry,
  }) = _Info;
  factory Info.fromJson(Map<String, dynamic> json) => _$InfoFromJson(json);
}