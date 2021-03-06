import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:furniture/registration/auth_page.dart';
import 'package:furniture/registration/resources.dart';
import 'package:furniture/ui/colors.dart';
import 'package:furniture/ui/text_style.dart';

class BoardingPage extends StatefulWidget {
  const BoardingPage({Key? key}) : super(key: key);

  @override
  State<BoardingPage> createState() => _BoardingPageState();
}

class _BoardingPageState extends State<BoardingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          _buildBackground(),
          _buildBody(),
        ],
      ),
    );
  }

  Widget _buildBackground() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: SvgPicture.asset(
        RegistrationImages.boardingBackground,
        fit: BoxFit.fill,
      ),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height / 4, left: 30, right: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          MyText.h2(
            RegistrationStrings.boardingTitle1,
            color: RegistrationColors.boardingTitle,
            fontFamily: MyTextFontFamily.gelasio,
          ),
          const SizedBox(
            height: 15,
          ),
          MyText.h1(
            RegistrationStrings.boardingTitle2,
            color: ApplicationColors.black,
            fontFamily: MyTextFontFamily.gelasio,
          ),
          const SizedBox(
            height: 35,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: MyText.h3(
              RegistrationStrings.boardingDescriptionText,
              color: ApplicationColors.textGray2,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 4,
          ),
          SafeArea(
            bottom: true,
            child: Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 10,
                  fixedSize: const Size(
                    RegistrationSizes.boardingButtonWidth,
                    RegistrationSizes.boardingButtonHeight,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const AuthPage(),
                    ),
                  );
                },
                child: MyText.h3(
                  RegistrationStrings.boardingButtonText,
                  fontFamily: MyTextFontFamily.gelasio,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
