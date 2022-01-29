import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:furniture/registration/auth_page.dart';
import 'package:furniture/registration/resources.dart';
import 'package:furniture/ui/regular_button.dart';
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
            color: RegistrationColors.black,
            fontFamily: MyTextFontFamily.gelasio,
          ),
          const SizedBox(
            height: 35,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: MyText.h3(
              RegistrationStrings.boardingDescriptionText,
              color: RegistrationColors.boardingText,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 4,
          ),
          SafeArea(
            bottom: true,
            child: Center(
              child: RegularButton(
                width: RegistrationSizes.boardingButtonWidth,
                height: RegistrationSizes.boardingButtonHeight,
                text: RegistrationStrings.boardingButtonText,
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const AuthPage(),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
