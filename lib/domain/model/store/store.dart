import 'package:instapay_admin/domain/model/store/adjust.dart';
import 'package:instapay_admin/domain/model/store/contact.dart';
import 'package:instapay_admin/domain/model/store/info.dart';
import 'package:instapay_admin/domain/model/store/juso.dart';
import 'package:instapay_admin/domain/model/store/staff.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'store.freezed.dart';
part 'store.g.dart';

@freezed
class Store with _$Store {
  factory Store({
    @Default("") String sid,
    @Default("") String adate,
    @Default("") String representativeName,
    @Default("") String sname,
    Info? info,
    Juso? juso,
    Adjust? adjust,
    @Default([]) List<Staff> staffs,
    @Default([]) List<Contact> contacts,
  }) = _Store;
  factory Store.fromJson(Map<String, dynamic> json) => _$StoreFromJson(json);
}