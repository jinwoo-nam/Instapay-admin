import 'package:flutter/material.dart';
import 'package:instapay_admin/domain/model/franchisee/franchisee_manager_info.dart';
import 'package:instapay_admin/presentation/home/home_view_model.dart';
import 'package:instapay_admin/presentation/home/widgets/franchisee/franchisee_info/components/business_info_widget.dart';
import 'package:instapay_admin/presentation/home/widgets/franchisee/franchisee_info/components/manager_info_widget.dart';
import 'package:instapay_admin/ui/color.dart';
import 'package:provider/provider.dart';

class FranchiseeInfoWidget extends StatefulWidget {
  const FranchiseeInfoWidget({Key? key}) : super(key: key);

  @override
  State<FranchiseeInfoWidget> createState() => _FranchiseeInfoWidgetState();
}

class _FranchiseeInfoWidgetState extends State<FranchiseeInfoWidget> {
  final _nameEditController = TextEditingController();
  final _departmentEditController = TextEditingController();
  final _emailEditController = TextEditingController();
  final _phoneEditController = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _nameEditController.dispose();
    _departmentEditController.dispose();
    _emailEditController.dispose();
    _phoneEditController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<HomeViewModel>();
    final state = viewModel.state;
    int index = -1;

    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: SingleChildScrollView(
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
                        if (state.franchiseeInfoData != null)
                          BusinessInfoWidget(
                            info: state.franchiseeInfoData!,
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
                                    final manager = FranchiseeManagerInfo(
                                      name: _nameEditController.text,
                                      department:
                                          _departmentEditController.text,
                                      email: _emailEditController.text,
                                      phone: _phoneEditController.text,
                                    );
                                    clearTextField();
                                    viewModel.addManagerData(manager);
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
                                ...state.managers.map((e) {
                                  index += 1;
                                  return ManagerInfoWidget(
                                    info: e,
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
