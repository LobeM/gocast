import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gocast/blocs/auth/auth_bloc.dart';
import 'package:gocast/configs/constants.dart';
import 'package:gocast/utils/async.dart';
import 'package:gocast/utils/form_utils.dart';
import 'package:gocast/utils/form_validator.dart';
import 'package:gocast/widgets/form_label.dart';
import 'package:gocast/widgets/link_button.dart';
import 'package:gocast/widgets/theme_button.dart';
import 'package:gocast/widgets/theme_text_input.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _textNameController = TextEditingController();
  final TextEditingController _textPassController = TextEditingController();
  final TextEditingController _textEmailController = TextEditingController();
  final FocusNode _focusName = FocusNode();
  final FocusNode _focusPass = FocusNode();
  final FocusNode _focusEmail = FocusNode();
  final GlobalKey<ThemeTextInputState> keyEmailInput =
      GlobalKey<ThemeTextInputState>();
  final GlobalKey<ThemeTextInputState> keyPasswordInput =
      GlobalKey<ThemeTextInputState>();
  final GlobalKey<ThemeTextInputState> keyNameInput =
      GlobalKey<ThemeTextInputState>();

  bool _showPassword = false;
  bool _consentGiven = false;

  void _signUp() {
    FormUtils.hideKeyboard(context);

    if (!_consentGiven) {
      showOkAlertDialog(
          context: context,
          title: 'Oops!',
          message: 'You must accept terms and conditions to continue');
      return;
    }

    if (keyNameInput.currentState.validate() &&
        keyEmailInput.currentState.validate() &&
        keyPasswordInput.currentState.validate()) {
      BlocProvider.of<AuthBloc>(context).add(UserRegisteredAuthEvent(
        fullName: _textNameController.text.trim(),
        email: _textEmailController.text.trim(),
        password: _textPassController.text,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create an account'),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: kPaddingM),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FormLabel(text: 'Full name'),
                ThemeTextInput(
                  key: keyNameInput,
                  hintText: 'Your full name',
                  icon: const Icon(Icons.clear),
                  controller: _textNameController,
                  focusNode: _focusName,
                  textInputAction: TextInputAction.next,
                  onSubmitted: (String text) => FormUtils.fieldFocusChange(
                      context, _focusName, _focusEmail),
                  onTapIcon: () async {
                    await Future<dynamic>.delayed(
                        const Duration(milliseconds: 100));
                    _textNameController.clear();
                  },
                  validator: FormValidator.isRequired('Required'),
                ),
                FormLabel(text: 'E-mail'),
                ThemeTextInput(
                  key: keyEmailInput,
                  hintText: 'name@email.com',
                  focusNode: _focusEmail,
                  onTapIcon: () async {
                    await Future<dynamic>.delayed(
                        const Duration(milliseconds: 100));
                    _textEmailController.clear();
                  },
                  onSubmitted: (String text) => FormUtils.fieldFocusChange(
                      context, _focusEmail, _focusPass),
                  icon: const Icon(Icons.clear),
                  controller: _textEmailController,
                  keyboardType: TextInputType.emailAddress,
                  validator:
                      FormValidator.validators(<FormFieldValidator<String>>[
                    FormValidator.isRequired('Required'),
                    FormValidator.isEmail('Email format invalid'),
                  ]),
                ),
                FormLabel(text: 'Password'),
                ThemeTextInput(
                  key: keyPasswordInput,
                  hintText: 'Create a password',
                  helpText:
                      'Password must be at least $kMinimalPasswordLength characters long and contain at least one number and one uppercase letter.',
                  textInputAction: TextInputAction.next,
                  onSubmitted: (String text) => FormUtils.fieldFocusChange(
                      context, _focusPass, _focusEmail),
                  onTapIcon: () {
                    setState(() => _showPassword = !_showPassword);
                  },
                  obscureText: !_showPassword,
                  icon: Icon(
                      _showPassword ? Icons.visibility : Icons.visibility_off),
                  controller: _textPassController,
                  focusNode: _focusPass,
                  validator:
                      FormValidator.validators(<FormFieldValidator<String>>[
                    FormValidator.isRequired('Required'),
                    FormValidator.matchesRegex(
                      regex: kPasswordRegex,
                      errorMessage: 'Password format invalid',
                    ),
                  ]),
                ),
                const Padding(padding: EdgeInsets.only(top: kPaddingM)),
                Padding(
                  padding: const EdgeInsets.only(bottom: kPaddingM),
                  child: CheckboxListTile(
                    contentPadding: EdgeInsets.zero,
                    activeColor: Theme.of(context).accentColor,
                    title: Text(
                        'I have read and agree with the User Terms of Service and I understand that my personal data will be processed in accordance with Privacy Statement.'),
                    value: _consentGiven,
                    onChanged: (bool value) {
                      setState(() => _consentGiven = value);
                    },
                    dense: true,
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                ),
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (BuildContext context, AuthState authState) {
                    return BlocListener<AuthBloc, AuthState>(
                      listener: (BuildContext context, AuthState authState) {
                        if (authState is RegistrationFailureAuthState) {
                          showOkAlertDialog(
                              context: context,
                              title: 'Oops!',
                              message: authState.message);
                        }
                      },
                      child: ThemeButton(
                        onPressed: _signUp,
                        text: 'Sign up',
                        showLoading: authState is ProcessInProgressAuthState,
                        disableTouchWhenLoading: true,
                      ),
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: kPaddingM),
                  child: LinkButton(
                    trailing: Icon(
                      Icons.open_in_browser,
                      color: Theme.of(context).hintColor,
                    ),
                    label: 'View legal documents',
                    onPressed: () => Async.launchUrl('https://google.com'),
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
