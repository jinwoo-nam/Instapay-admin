import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:instapay_admin/domain/model/franchisee/contact.dart';
import 'package:instapay_admin/presentation/store/store_info/store_info_view_model.dart';
import 'package:instapay_admin/ui/color.dart';
import 'package:provider/provider.dart';

import 'components/business_info_widget.dart';
import 'components/manager_info_widget.dart';

class StoreInfoScreen extends StatefulWidget {
  const StoreInfoScreen({Key? key}) : super(key: key);

  @override
  State<StoreInfoScreen> createState() => _StoreInfoScreenState();
}

class _StoreInfoScreenState extends State<StoreInfoScreen> {
  final scrollController = ScrollController();
  final _nameEditController = TextEditingController();
  final _departmentEditController = TextEditingController();
  final _emailEditController = TextEditingController();
  final _phoneEditController = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  StreamSubscription? _streamSubscription;

  late FToast fToast;
  late Widget toast;

  _removeToast() {
    fToast.removeCustomToast();
  }

  _showToast(String message) {
    _removeToast();

    fToast.showToast(
      child: Container(
          width: 250,
          height: 50,
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.zero,
            color: Colors.grey,
          ),
          child: Center(
            child: Text(message),
          )),
      gravity: ToastGravity.BOTTOM,
      toastDuration: const Duration(seconds: 4),
    );
  }

  @override
  void initState() {
    Future.microtask(() {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) {
          fToast = FToast();
          fToast.init(context);
        },
      );

      final viewModel = context.read<StoreInfoViewModel>();

      _streamSubscription = viewModel.eventStream.listen((event) {
        event.when(
          showSnackBar: (message) {
            _showToast(message);
          },
        );
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _streamSubscription?.cancel();
    _nameEditController.dispose();
    _departmentEditController.dispose();
    _emailEditController.dispose();
    _phoneEditController.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<StoreInfoViewModel>();
    final state = viewModel.state;
    int index = -1;

    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: SingleChildScrollView(
        controller: scrollController,
        child: Center(
          child: SizedBox(
            width: 500,
            child: Form(
              key: _globalKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          '가맹점 정보',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        const Text(
                          '사업자 정보',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            color: pointColor,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: Divider(
                            height: 1,
                            color: Colors.white54,
                          ),
                        ),
                        if (state.storeData != null)
                          BusinessInfoWidget(
                            store: state.storeData!,
                            userId: state.userID,
                          ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              '담당자 정보',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                                color: pointColor,
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                if (_globalKey.currentState != null) {
                                  if (_globalKey.currentState!.validate()) {
                                    final manager = Contact(
                                      cname: _nameEditController.text,
                                      dep: _departmentEditController.text,
                                      email: _emailEditController.text,
                                      tel: _phoneEditController.text,
                                    );
                                    viewModel.addManagerData(manager);
                                    clearTextField();
                                  }
                                }
                              },
                              child: const Text('추가'),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                child: TextFormField(
                                  validator: (value) {
                                    if (value != null) {
                                      if (value.trim().isEmpty) {
                                        return '담당자명을 입력하세요.';
                                      }
                                    }
                                    return null;
                                  },
                                  controller: _nameEditController,
                                  enableSuggestions: false,
                                  autocorrect: false,
                                  style: const TextStyle(
                                    fontSize: 10,
                                  ),
                                  decoration: const InputDecoration(
                                    hintText: '담당자명',
                                    fillColor: secondaryColor,
                                    filled: true,
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                child: TextFormField(
                                  validator: (value) {
                                    if (value != null) {
                                      if (value.trim().isEmpty) {
                                        return '부서명을 입력하세요.';
                                      }
                                    }
                                    return null;
                                  },
                                  controller: _departmentEditController,
                                  enableSuggestions: false,
                                  autocorrect: false,
                                  style: const TextStyle(fontSize: 10),
                                  decoration: const InputDecoration(
                                    hintText: '부서',
                                    fillColor: secondaryColor,
                                    filled: true,
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                child: TextFormField(
                                  validator: (value) {
                                    if (value != null) {
                                      if (value.trim().isEmpty) {
                                        return '이메일을 입력하세요.';
                                      }
                                    }
                                    return null;
                                  },
                                  controller: _emailEditController,
                                  enableSuggestions: false,
                                  autocorrect: false,
                                  style: const TextStyle(fontSize: 10),
                                  decoration: const InputDecoration(
                                    hintText: '이메일',
                                    fillColor: secondaryColor,
                                    filled: true,
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                child: TextFormField(
                                  validator: (value) {
                                    if (value != null) {
                                      if (value.trim().isEmpty) {
                                        return '전화번호를을 입력하세요.';
                                      }
                                    }
                                    return null;
                                  },
                                  controller: _phoneEditController,
                                  keyboardType: TextInputType.number,
                                  enableSuggestions: false,
                                  autocorrect: false,
                                  style: const TextStyle(fontSize: 10),
                                  decoration: const InputDecoration(
                                    hintText: '전화번호',
                                    fillColor: secondaryColor,
                                    filled: true,
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 10),
                            decoration: BoxDecoration(
                              color: secondaryColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: const [
                                    Expanded(
                                      flex: 2,
                                      child: Center(
                                        child: Text(
                                          '담당자명',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Center(
                                        child: Text(
                                          '부서',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 4,
                                      child: Center(
                                        child: Text(
                                          '이메일',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Center(
                                        child: Text(
                                          '전화번호',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Center(
                                        child: Text(
                                          '삭제',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 8.0),
                                  child: Divider(
                                    color: Colors.white54,
                                    height: 1,
                                  ),
                                ),
                                //if (state.storeData != null)
                                ...state.managers.map((e) {
                                  index += 1;
                                  return ManagerInfoWidget(
                                    contact: e,
                                    index: index,
                                    onDelete: viewModel.deleteManagerData,
                                  );
                                }).toList(),
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 8.0),
                                  child: Divider(
                                    color: Colors.white54,
                                    height: 1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void clearTextField() {
    _nameEditController.text = '';
    _departmentEditController.text = '';
    _emailEditController.text = '';
    _phoneEditController.text = '';
  }
}
