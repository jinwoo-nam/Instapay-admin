import 'package:instapay_admin/domain/model/franchisee/adjust.dart';
import 'package:instapay_admin/domain/model/franchisee/contact.dart';
import 'package:instapay_admin/domain/model/franchisee/info.dart';
import 'package:instapay_admin/domain/model/franchisee/juso.dart';
import 'package:instapay_admin/domain/model/franchisee/staff.dart';
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