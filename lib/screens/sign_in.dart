import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gocast/blocs/auth/auth_bloc.dart';
import 'package:gocast/configs/constants.dart';
import 'package:gocast/configs/routes.dart';
import 'package:gocast/utils/form_utils.dart';
import 'package:gocast/utils/form_validator.dart';
import 'package:gocast/widgets/form_label.dart';
import 'package:gocast/widgets/link_button.dart';
import 'package:gocast/widgets/strut_text.dart';
import 'package:gocast/widgets/theme_button.dart';
import 'package:gocast/widgets/theme_text_input.dart';
import 'package:gocast/utils/text_style.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _textEmailController = TextEditingController();
  final TextEditingController _textPassController = TextEditingController();
  final FocusNode _focusEmail = FocusNode();
  final FocusNode _focusPass = FocusNode();

  final GlobalKey<ThemeTextInputState> keyEmailInput =
      GlobalKey<ThemeTextInputState>();
  final GlobalKey<ThemeTextInputState> keyPasswordInput =
      GlobalKey<ThemeTextInputState>();

  bool _showPassword = false;

  void _validateForm() {
    FormUtils.hideKeyboard(context);

    if (keyPasswordInput.currentState.validate() &&
        keyEmailInput.currentState.validate()) {
      BlocProvider.of<AuthBloc>(context).add(LoginRequestedAuthEvent(
        email: _textEmailController.text.trim(),
        password: _textPassController.text,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign in'),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: kPaddingM),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: kPaddingM),
                    StrutText(
                      'Sign in to GoCast',
                      style: Theme.of(context).textTheme.headline5.bold,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: kPaddingM),
                      child: Row(
                        children: <Widget>[
                          StrutText(
                            'Don\'t have an account? ',
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                          LinkButton(
                              onPressed: () =>
                                  Navigator.pushNamed(context, Routes.signUp),
                              label: 'Sign up now'),
                        ],
                      ),
                    ),
                    FormLabel(text: 'E-mail'),
                    ThemeTextInput(
                      key: keyEmailInput,
                      controller: _textEmailController,
                      hintText: 'name@email.com',
                      focusNode: _focusEmail,
                      keyboardType: TextInputType.emailAddress,
                      icon: const Icon(Icons.clear),
                      textInputAction: TextInputAction.next,
                      onTapIcon: () async {
                        await Future<dynamic>.delayed(
                            const Duration(milliseconds: 100));
                        _textEmailController.clear();
                      },
                      onSubmitted: (String text) => FormUtils.fieldFocusChange(
                          context, _focusEmail, _focusPass),
                      validator:
                          FormValidator.validators(<FormFieldValidator<String>>[
                        FormValidator.isRequired('Required'),
                        FormValidator.isEmail('Email format invalid'),
                      ]),
                    ),
                    // const Padding(padding: EdgeInsets.only(top: kPaddingM)),
                    FormLabel(text: 'Password'),
                    ThemeTextInput(
                      key: keyPasswordInput,
                      hintText: 'Your password',
                      textInputAction: TextInputAction.done,
                      onSubmitted: (String text) => _validateForm(),
                      onTapIcon: () =>
                          setState(() => _showPassword = !_showPassword),
                      obscureText: !_showPassword,
                      icon: Icon(_showPassword
                          ? Icons.visibility
                          : Icons.visibility_off),
                      controller: _textPassController,
                      focusNode: _focusPass,
                      validator:
                          FormValidator.validators(<FormFieldValidator<String>>[
                        FormValidator.isRequired('Required'),
                        FormValidator.isMinLength(
                          length: kMinimalPasswordLength,
                          errorMessage:
                              'Min length is $kMinimalPasswordLength characters',
                        ),
                      ]),
                    ),
                    const Padding(padding: EdgeInsets.only(top: kPaddingM)),
                    BlocBuilder<AuthBloc, AuthState>(
                      builder: (BuildContext context, AuthState login) {
                        return BlocListener<AuthBloc, AuthState>(
                          listener:
                              (BuildContext context, AuthState loginListener) {
                            if (loginListener is LoginFailureAuthState) {
                              showOkAlertDialog(
                                context: context,
                                title: 'Oops!',
                                message: loginListener.message,
                              );
                            }
                          },
                          child: ThemeButton(
                            onPressed: () => _validateForm(),
                            text: 'Login',
                            showLoading: login is ProcessInProgressAuthState,
                            disableTouchWhenLoading: true,
                          ),
                        );
                      },
                    ),
                    const Padding(padding: EdgeInsets.only(top: kPaddingS)),
                    Center(
                      child: TextButton(
                        onPressed: () =>
                            Navigator.pushNamed(context, Routes.forgotPassword),
                        child: Text('Forgot password?'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
