import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:gocast/blocs/auth/auth_bloc.dart';
import 'package:gocast/configs/constants.dart';
import 'package:gocast/utils/form_validator.dart';
import 'package:gocast/widgets/bold_title.dart';
import 'package:gocast/widgets/strut_text.dart';
import 'package:gocast/widgets/theme_button.dart';
import 'package:gocast/widgets/theme_text_input.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key key}) : super(key: key);

  @override
  _ForgotPasswordScreenState createState() {
    return _ForgotPasswordScreenState();
  }
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _textEmailController = TextEditingController();
  final GlobalKey<ThemeTextInputState> keyEmailInput =
      GlobalKey<ThemeTextInputState>();

  Future<void> _resetPassword() async {
    if (keyEmailInput.currentState.validate()) {
      BlocProvider.of<AuthBloc>(context)
          .add(NewPasswordRequestedAuthEvent(_textEmailController.text));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Reset Password'),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: kPaddingM),
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                BoldTitle(
                  title: 'Forgot Passowrd?',
                  padding: const EdgeInsets.only(bottom: kPaddingM),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: kPaddingS),
                  child: StrutText(
                    'Enter your registered email address and we shall send you a secure link to reset your password.',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ),
                ThemeTextInput(
                  key: keyEmailInput,
                  controller: _textEmailController,
                  hintText: 'Your email address',
                  keyboardType: TextInputType.emailAddress,
                  icon: const Icon(Icons.clear),
                  textInputAction: TextInputAction.next,
                  onTapIcon: () async {
                    await Future<dynamic>.delayed(
                        const Duration(milliseconds: 100));
                    _textEmailController.clear();
                  },
                  validator:
                      FormValidator.validators(<FormFieldValidator<String>>[
                    FormValidator.isRequired('Required'),
                    FormValidator.isEmail('Email format invalid'),
                  ]),
                ),
                const Padding(padding: EdgeInsets.only(top: kPaddingM)),
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (BuildContext context, AuthState authState) {
                    return BlocListener<AuthBloc, AuthState>(
                      listener: (BuildContext context, AuthState authState) {
                        if (authState is ForgetPasswordSuccessAuthState) {
                          showOkAlertDialog(
                            context: context,
                            title: 'Secure link has been sent',
                            message:
                                'Secure link to reset your password has been sent to the provided email address.',
                            okLabel: 'Close',
                            // ignore: missing_return
                            onWillPop: () {
                              Navigator.pop(context);
                            },
                          );
                          _textEmailController.text = '';
                        }
                      },
                      child: ThemeButton(
                        onPressed: _resetPassword,
                        text: 'Reset Password',
                        showLoading: authState is ProcessInProgressAuthState,
                        disableTouchWhenLoading: true,
                      ),
                    );
                  },
                ),
                const Padding(padding: EdgeInsets.only(top: kPaddingS)),
                Center(
                  child: TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('Back to login'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
