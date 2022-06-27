import 'package:json_annotation/json_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'goods.freezed.dart';
part 'goods.g.dart';

@freezed
class Goods with _$Goods {
  factory Goods({
    @Default('') String gid,
    @Default('') String sid,
    @Default('') String? sname,
    @Default('') String? gname,
    @Default('') String? price,
    @Default('') String? iid,
    @Default('') String? adate,
    @Default('') String? ldate,
  }) = _Goods;
  factory Goods.fromJson(Map<String, dynamic> json) => _$GoodsFromJson(json);
}