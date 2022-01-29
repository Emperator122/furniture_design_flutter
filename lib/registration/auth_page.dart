import 'package:flutter/material.dart';
import 'package:furniture/registration/resources.dart';
import 'package:furniture/registration/widgets/auth_header.dart';
import 'package:furniture/ui/regular_button.dart';
import 'package:furniture/ui/text_style.dart';

class AuthPageVM {
  final TextEditingController emailController;
  final TextEditingController passwordController;

  AuthPageVM()
      : emailController = TextEditingController(),
        passwordController = TextEditingController();

  void close() {
    emailController.dispose();
    passwordController.dispose();
  }
}

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return AuthPageState();
  }
}

class AuthPageState extends State<AuthPage> {
  late final AuthPageVM _vm;

  @override
  void initState() {
    _vm = AuthPageVM();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding:
        const EdgeInsets.only(right: RegistrationSizes.authMainPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SafeArea(
              child: Padding(
                padding:
                EdgeInsets.only(left: RegistrationSizes.authMainPadding),
                child: AuthHeader(),
              ),
            ),
            _buildTitle(),
            const SizedBox(
              height: RegistrationSizes.authMainPadding,
            ),
            _buildAuthForm(),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Padding(
      padding: const EdgeInsets.only(left: RegistrationSizes.authMainPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText.h1(
            RegistrationStrings.loginTitle,
            color: RegistrationColors.textGray,
            fontFamily: MyTextFontFamily.merriweather,
          ),
          const SizedBox(
            height: RegistrationSizes.authFormMargin,
          ),
          MyText.h2(
            RegistrationStrings.loginSubtitle,
            color: RegistrationColors.black,
            fontFamily: MyTextFontFamily.merriweather,
            customStyle: const TextStyle(fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }

  Widget _buildAuthForm() {
    SizedBox _margin() =>
        const SizedBox(
          height: RegistrationSizes.authFormMargin,
        );

    return Container(
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: RegistrationColors.shadowColor,
            blurRadius: 30.0,
            spreadRadius: 0.0,
            offset: Offset(0.0, 7.0), // shadow direction: bottom right
          ),
        ],
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          left: RegistrationSizes.authMainPadding,
          top: RegistrationSizes.authMainPadding,
          bottom: RegistrationSizes.authMainPadding,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            MyText.h5(
              'Email',
              color: RegistrationColors.textGray,
            ),
            _emailField(),
            _margin(),
            MyText.h5(
              'Password',
              color: RegistrationColors.textGray,
            ),
            _passwordField(),
            _margin(),
            _forgotPasswordButton(),
            _margin(),
            _signInButton(),
            _margin(),
            _signUpButton(),
          ],
        ),
      ),
    );
  }

  Widget _emailField() =>
      TextField(
        controller: _vm.emailController,
        decoration: const InputDecoration(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: RegistrationColors.authFieldsUnderline,
              width: 2.0,
            ),
          ),
        ),
      );

  Widget _passwordField() =>
      TextField(
        controller: _vm.passwordController,
        decoration: const InputDecoration(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: RegistrationColors.authFieldsUnderline,
              width: 2.0,
            ),
          ),
        ),
      );

  Widget _forgotPasswordButton() =>
      Center(
        child: TextButton(
          onPressed: () {
            return;
          },
          child: MyText.h3(
            RegistrationStrings.loginForgotPassword,
            color: RegistrationColors.black,
            customStyle: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
      );

  Widget _signInButton() =>
      Padding(
        padding: const EdgeInsets.only(right: RegistrationSizes.authMainPadding),
        child: SizedBox(
          height: RegistrationSizes.authSignInButtonHeight,
          child: RegularButton(
            onPressed: () {
              return;
            },
            text: RegistrationStrings.signIn,
            elevation: 10,
          ),
        ),
      );

  Widget _signUpButton() =>
      Center(
        child: TextButton(
          onPressed: () {
            return;
          },
          child: MyText.h3(
            RegistrationStrings.signUp,
            color: RegistrationColors.black,
            customStyle: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
      );
}
