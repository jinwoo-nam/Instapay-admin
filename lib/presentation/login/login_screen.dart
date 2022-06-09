import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instapay_admin/presentation/root/root_view_model.dart';
import 'package:instapay_admin/ui/color.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isCheck = false;

  @override
  Widget build(BuildContext context) {
    final rootViewModel = context.watch<RootViewModel>();
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: SizedBox(
            width: 500,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 90),
                    child: Image.asset(
                      'img/home-logo@2x.png',
                      width: 180,
                    ),
                  ),
                  const LoginTextField(
                    hintText: '이메일 ID',
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const LoginTextField(
                    hintText: '비밀번호',
                    obscureText: true,
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
                        onPressed: () {
                          rootViewModel.setLoginResult(true);
                        },
                        child: const Text('로그인'),
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                value: _isCheck,
                                onChanged: (value) {
                                  setState(() {
                                    if (value != null) {
                                      _isCheck = value;
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
    );
  }
}

class LoginTextField extends StatelessWidget {
  final String hintText;
  final bool obscureText;

  const LoginTextField({
    Key? key,
    required this.hintText,
    this.obscureText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextField(
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
