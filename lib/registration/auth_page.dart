import 'package:flutter/material.dart';
import 'package:furniture/home/home_page.dart';
import 'package:furniture/misc/value_cubit.dart';
import 'package:furniture/registration/registration_page.dart';
import 'package:furniture/registration/resources.dart';
import 'package:furniture/registration/widgets/auth_header.dart';
import 'package:furniture/ui/colors.dart';
import 'package:furniture/ui/text_style.dart';

class AuthPageVM {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final ValueCubit<bool> passwordVisibleController;

  AuthPageVM()
      : emailController = TextEditingController(),
        passwordController = TextEditingController(),
        passwordVisibleController = ValueCubit(true);

  void close() {
    emailController.dispose();
    passwordController.dispose();
    passwordVisibleController.close();
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
    _vm.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.only(
            right: RegistrationSizes.authMainPadding,
            bottom: RegistrationSizes.authMainPadding,
          ),
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
            color: ApplicationColors.textGray,
            fontFamily: MyTextFontFamily.merriweather,
          ),
          const SizedBox(
            height: RegistrationSizes.authFormMargin,
          ),
          MyText.h2(
            RegistrationStrings.loginSubtitle,
            color: ApplicationColors.black,
            fontFamily: MyTextFontFamily.merriweather,
            customStyle: const TextStyle(fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }

  Widget _buildAuthForm() {
    SizedBox _margin() => const SizedBox(
          height: RegistrationSizes.authFormMargin,
        );

    return Container(
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: ApplicationColors.shadowColor,
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
              color: ApplicationColors.textGray,
            ),
            _emailField(),
            _margin(),
            MyText.h5(
              'Password',
              color: ApplicationColors.textGray,
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

  Widget _emailField() => TextField(
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

  Widget _passwordField() {
    return StreamBuilder<bool>(
        stream: _vm.passwordVisibleController.stream,
        builder: (context, snapshot) {
          return TextField(
            controller: _vm.passwordController,
            obscureText: !_vm.passwordVisibleController.state,
            decoration: InputDecoration(
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
                  color: RegistrationColors.authFieldsUnderline,
                  width: 2.0,
                ),
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  _vm.passwordVisibleController.state
                      ? Icons.visibility
                      : Icons.visibility_off,
                  color: ApplicationColors.black,
                ),
                onPressed: () {
                  _vm.passwordVisibleController.state =
                      !_vm.passwordVisibleController.state;
                },
              ),
            ),
          );
        });
  }

  Widget _forgotPasswordButton() => Center(
        child: TextButton(
          onPressed: () {
            return;
          },
          child: MyText.h3(
            RegistrationStrings.loginForgotPassword,
            color: ApplicationColors.black,
            customStyle: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
      );

  Widget _signInButton() => Padding(
        padding:
            const EdgeInsets.only(right: RegistrationSizes.authMainPadding),
        child: SizedBox(
          height: RegistrationSizes.authSignInButtonHeight,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 10,
            ),
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => const HomePage(),
                ),
                (route) => false,
              );
            },
            child: MyText.h3(
              RegistrationStrings.signIn,
            ),
          ),
        ),
      );

  Widget _signUpButton() => Center(
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const RegistrationPage(),
              ),
            );
          },
          child: MyText.h3(
            RegistrationStrings.signUp,
            color: ApplicationColors.black,
            customStyle: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
      );
}
