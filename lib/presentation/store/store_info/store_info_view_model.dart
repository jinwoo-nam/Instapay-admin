import 'dart:async';

import 'package:flutter/material.dart';
import 'package:instapay_admin/domain/model/franchisee/contact.dart';
import 'package:instapay_admin/domain/use_case/franchisee/info/get_franchisee_info_use_case.dart';
import 'package:instapay_admin/domain/use_case/franchisee/manager/manager_use_case.dart';
import 'package:instapay_admin/domain/use_case/login/token_use_case.dart';
import 'package:instapay_admin/presentation/store/store_info/store_info_state.dart';
import 'package:instapay_admin/presentation/store/store_info/store_info_ui_event.dart';

class StoreInfoViewModel with ChangeNotifier {
  final ManagerUseCase managerUseCase;
  final TokenUseCase tokenUseCase;
  final GetStoreInfoUseCase getFranchiseeInfo;

  StoreInfoViewModel({
    required this.managerUseCase,
    required this.tokenUseCase,
    required this.getFranchiseeInfo,
  }){
    getFranchiseeInfoList();
  }

  StoreInfoState _state = StoreInfoState();

  StoreInfoState get state => _state;

  final _eventController = StreamController<StoreInfoUiEvent>.broadcast();

  Stream<StoreInfoUiEvent> get eventStream => _eventController.stream;

  Future<void> getFranchiseeInfoList() async {
    final token = await tokenUseCase.loadAccessToken();
    final storeInfo = await getFranchiseeInfo.getStoreInfo(token);
    storeInfo.when(success: (data) {
      _state = state.copyWith(
        storeData: data,
        managers: data.contacts,
      );
      managerUseCase.setManagers(state.managers);
    }, error: (message) {
      print(message);
    });

    notifyListeners();
  }


  void addManagerData(Contact manager) async {
    String token = await tokenUseCase.loadAccessToken();
    final res = await managerUseCase.addManager(manager, token);
    res.when(success: (data) {
      if (data == "ok") {
        _state = state.copyWith(
          managers: managerUseCase.getManagers(),
        );
        _eventController.add(const StoreInfoUiEvent.showSnackBar('담당자 추가 성공'));
      } else {
        _eventController
            .add(const StoreInfoUiEvent.showSnackBar('담당자 추가에 실패 했습니다.'));
      }
    }, error: (message) {
      _eventController.add(const StoreInfoUiEvent.showSnackBar('담당자 추가에 실패 했습니다.'));
    });
    notifyListeners();
  }

  void deleteManagerData(int index) async {
    String token = await tokenUseCase.loadAccessToken();
    final res = await managerUseCase.deleteManager(index, token);
    res.when(success: (data) {
      if (data == "ok") {
        _state = state.copyWith(
          managers: managerUseCase.getManagers(),
        );
        _eventController.add(const StoreInfoUiEvent.showSnackBar('담당자 삭제'));
      } else {
        _eventController
            .add(const StoreInfoUiEvent.showSnackBar('담당자 삭제에 실패 했습니다.'));
      }
    }, error: (message) {
      _eventController.add(const StoreInfoUiEvent.showSnackBar('담당자 삭제에 실패 했습니다.'));
    });
    notifyListeners();
  }

}