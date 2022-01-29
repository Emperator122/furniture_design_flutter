import 'package:flutter/material.dart';
import 'package:furniture/registration/resources.dart';
import 'package:furniture/registration/widgets/auth_header.dart';
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
            height: RegistrationSizes.authMainPadding / 2,
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
    TextField _getTextField(TextEditingController controller) => TextField(
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

    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height / 15,
        ),
        child: Container(
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
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyText.h5(
                  'Email',
                  color: RegistrationColors.textGray,
                ),
                _getTextField(_vm.emailController),
                const SizedBox(
                  height: RegistrationSizes.authMainPadding / 2,
                ),
                MyText.h5(
                  'Password',
                  color: RegistrationColors.textGray,
                ),
                _getTextField(_vm.passwordController),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
