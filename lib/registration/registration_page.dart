import 'package:flutter/material.dart';
import 'package:furniture/misc/value_cubit.dart';
import 'package:furniture/registration/resources.dart';
import 'package:furniture/registration/widgets/auth_header.dart';
import 'package:furniture/tabs_page.dart';
import 'package:furniture/ui/colors.dart';
import 'package:furniture/ui/text_style.dart';

class RegistrationPageVM {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final ValueCubit<bool> passwordVisibleController;
  final ValueCubit<bool> confirmPasswordVisibleController;

  RegistrationPageVM()
      : nameController = TextEditingController(),
        emailController = TextEditingController(),
        passwordController = TextEditingController(),
        confirmPasswordController = TextEditingController(),
        passwordVisibleController = ValueCubit(true),
        confirmPasswordVisibleController = ValueCubit(true);

  void close() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    passwordVisibleController.close();
    confirmPasswordVisibleController.close();
  }
}

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return RegistrationPageState();
  }
}

class RegistrationPageState extends State<RegistrationPage> {
  late final RegistrationPageVM _vm;

  @override
  void initState() {
    _vm = RegistrationPageVM();
    super.initState();
  }

  @override
  void dispose() {
    _vm.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.only(
              right: RegistrationSizes.authMainPadding,
              bottom: RegistrationSizes.authMainPadding),
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
                height: RegistrationSizes.registerTitleMargin,
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
      child: MyText.h2(
        RegistrationStrings.registrationTitle,
        color: ApplicationColors.black,
        fontFamily: MyTextFontFamily.merriweather,
        customStyle: const TextStyle(fontWeight: FontWeight.w700),
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
              'Name',
              color: ApplicationColors.textGray,
            ),
            _nameField(),
            _margin(),
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
            _passwordField(
              _vm.passwordVisibleController,
              _vm.passwordController,
            ),
            _margin(),
            MyText.h5(
              'Confirm Password',
              color: ApplicationColors.textGray,
            ),
            _passwordField(
              _vm.confirmPasswordVisibleController,
              _vm.confirmPasswordController,
            ),
            _margin(),
            _signUpButton(),
            _margin(),
            _signInText(),
          ],
        ),
      ),
    );
  }

  Widget _nameField() => TextField(
        controller: _vm.nameController,
        decoration: const InputDecoration(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: RegistrationColors.authFieldsUnderline,
              width: 2.0,
            ),
          ),
        ),
      );

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

  Widget _passwordField(ValueCubit<bool> passwordVisibleController,
      TextEditingController controller) {
    return StreamBuilder<bool>(
        stream: passwordVisibleController.stream,
        builder: (context, snapshot) {
          return TextField(
            controller: controller,
            obscureText: !passwordVisibleController.state,
            decoration: InputDecoration(
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
                  color: RegistrationColors.authFieldsUnderline,
                  width: 2.0,
                ),
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  passwordVisibleController.state
                      ? Icons.visibility
                      : Icons.visibility_off,
                  color: ApplicationColors.black,
                ),
                onPressed: () {
                  passwordVisibleController.state =
                      !passwordVisibleController.state;
                },
              ),
            ),
          );
        });
  }

  Widget _signUpButton() => Padding(
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
                  builder: (context) => const TabsPage(),
                ),
                    (route) => false,
              );
            },
            child: MyText.h3(
              RegistrationStrings.signUp,
            ),
          ),
        ),
      );

  Widget _signInText() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MyText.h5(RegistrationStrings.registrationLoginText,
              color: ApplicationColors.textGray2,),
          InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: MyText.h3(
              RegistrationStrings.signIn,
              color: ApplicationColors.black,
              customStyle: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      );
}
