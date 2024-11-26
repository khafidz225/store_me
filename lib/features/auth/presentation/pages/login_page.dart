import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_me/core/enum/condition_state_enum.dart';

import '../../../../core/di/depedency_injection.dart';
import '../../../../core/widget/textformfield_custom.dart';
import '../bloc/auth_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Center(
              child: SizedBox(
                width: 150,
                child: Image.asset('assets/icon/logo_icon.png'),
              ),
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormFieldCustom(
                    controller: usernameController,
                    label: 'Username',
                    isTopLabel: true,
                    isRequired: true,
                    keyboardType: TextInputType.name,
                    validator: (value) {
                      if (value == null || value == '') {
                        return 'The field is required to be filled in';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormFieldCustom(
                    controller: passwordController,
                    label: 'Password',
                    isTopLabel: true,
                    isPassword: true,
                    isRequired: true,
                    keyboardType: TextInputType.visiblePassword,
                    validator: (value) {
                      if (value == null || value == '') {
                        return 'The field is required to be filled in';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
                width: size.width,
                height: 45,
                child: BlocSelector<AuthBloc, AuthState, bool>(
                  selector: (state) {
                    if (state.conditionStateEnum ==
                        ConditionStateEnum.loading) {
                      return true;
                    }
                    return false;
                  },
                  builder: (context, state) {
                    return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff2D2D2D)),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            locator<AuthBloc>().add(AuthLoginEvent(
                                context: context,
                                username: usernameController.text,
                                password: passwordController.text));
                          }
                        },
                        child: state
                            ? const SizedBox(
                                width: 25,
                                height: 25,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ))
                            : const Text(
                                'Login',
                                style: TextStyle(color: Colors.white),
                              ));
                  },
                ))
          ],
        ),
      ),
    );
  }
}
