import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instapay_admin/presentation/login/login_view_model.dart';
import 'package:instapay_admin/presentation/root/root_view_model.dart';
import 'package:instapay_admin/ui/color.dart';
import 'package:instapay_admin/util/constant.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _idEditController = TextEditingController();
  final _pwEditController = TextEditingController();
  final GlobalKey<FormState> _globalFormKey = GlobalKey<FormState>();

  bool _isAutoLoginCheck = false;

  late FToast fToast;
  late Widget toast;

  _removeToast() {
    fToast.removeCustomToast();
  }

  _showToast() {
    _removeToast();

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: const Duration(seconds: 4),
    );
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        fToast = FToast();
        fToast.init(globalKey.currentState!.context);

        toast = Container(
            width: 200,
            height: 50,
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.zero,
              color: Colors.grey,
            ),
            child: const Center(
              child: Text('로그인에 실패했습니다.'),
            ));
      },
    );

    super.initState();
  }

  @override
  void dispose() {
    _idEditController.dispose();
    _pwEditController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<LoginViewModel>();

    final rootViewModel = context.watch<RootViewModel>();
    return Scaffold(
      key: globalKey,
      body: Center(
        child: SingleChildScrollView(
          child: SizedBox(
            width: 500,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Form(
                key: _globalFormKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 90),
                      child: Image.asset(
                        'img/home-logo@2x.png',
                        width: 180,
                      ),
                    ),
                    LoginTextField(
                      hintText: '이메일 ID',
                      controller: _idEditController,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    LoginTextField(
                      hintText: '비밀번호',
                      obscureText: true,
                      controller: _pwEditController,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 30,
                              vertical: 12,
                            ),
                          ),
                          onPressed: () async {
                            if (_globalFormKey.currentState != null) {
                              if (_globalFormKey.currentState!.validate()) {
                                final result = await viewModel.isLoginPass(
                                    _idEditController.text,
                                    _pwEditController.text);
                                if (result == true) {
                                  viewModel.saveAutoLoginState(_isAutoLoginCheck);
                                  rootViewModel.setLoginResult(true);
                                } else {
                                  _showToast();
                                }
                              }
                            }
                          },
                          child: const Text('로그인'),
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                Checkbox(
                                  value: _isAutoLoginCheck,
                                  onChanged: (value) {
                                    setState(() {
                                      if (value != null) {
                                        _isAutoLoginCheck = value;
                                      }
                                    });
                                  },
                                ),
                                const Text('아이디 저장'),
                              ],
                            ),
                            InkWell(
                              onTap: () {},
                              child: Row(
                                children: const [
                                  FaIcon(
                                    FontAwesomeIcons.chevronRight,
                                    color: Colors.white,
                                    size: 14,
                                  ),
                                  Text('  비밀번호 찾기'),
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class LoginTextField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final TextEditingController controller;

  const LoginTextField({
    Key? key,
    required this.hintText,
    required this.controller,
    this.obscureText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextFormField(
        validator: (value) {
          if (value != null) {
            if (value.trim().isEmpty) {
              if (obscureText) {
                return '비밀 번호를 입력해 주세요.';
              } else {
                return 'ID를 입력해 주세요.';
              }
            }
          }
          return null;
        },
        controller: controller,
        obscureText: obscureText,
        enableSuggestions: false,
        autocorrect: false,
        decoration: InputDecoration(
          hintText: hintText,
          fillColor: secondaryColor,
          filled: true,
          border: const OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
        ),
      ),
    );
  }
}
