import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gocast/blocs/application/application_bloc.dart';
import 'package:gocast/configs/constants.dart';
import 'package:gocast/generated/l10n.dart';
import 'package:gocast/widgets/strut_text.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:gocast/utils/text_style.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with TickerProviderStateMixin {
  AnimationController _rippleAnimationController;
  Animation<double> _rippleAnimation;

  ApplicationBloc _applicationBloc;

  @override
  void initState() {
    super.initState();

    _rippleAnimationController = AnimationController(
      vsync: this,
      duration: kRippleAnimationDuration,
    );

    _applicationBloc = BlocProvider.of<ApplicationBloc>(context);
  }

  @override
  void dispose() {
    _rippleAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    _rippleAnimation = Tween<double>(
      begin: 0.0,
      end: screenHeight,
    ).animate(CurvedAnimation(
      parent: _rippleAnimationController,
      curve: Curves.easeIn,
    ));

    /// Styles for the onboarding screen elements
    final PageDecoration pageDecoration = PageDecoration(
      titleTextStyle: Theme.of(context).textTheme.headline5.bold,
      bodyTextStyle:
          Theme.of(context).textTheme.subtitle1.grey.copyWith(height: 1.8),
      descriptionPadding:
          const EdgeInsets.fromLTRB(kPaddingM, 0, kPaddingM, kPaddingM),
      imagePadding: const EdgeInsets.all(kPaddingL),
      // boxDecoration: BoxDecoration(
      //   // Linear gradient background
      //   gradient: LinearGradient(
      //     begin: Alignment.bottomCenter,
      //     end: Alignment.topCenter,
      //     stops: const <double>[0.1, 0.9],
      //     colors: <Color>[
      //       kPrimaryColor.withOpacity(.9),
      //       kPrimaryColor,
      //     ],
      //   ),
      // ),
    );

    return Scaffold(
      backgroundColor: kWhite,
      body: Stack(
        children: <Widget>[
          IntroductionScreen(
            globalBackgroundColor: kWhite,
            showSkipButton: true,
            skipFlex: 0,
            nextFlex: 0,
            dotsDecorator: DotsDecorator(
              size: const Size(10.0, 10.0), // size of dots
              color: kPrimaryColor.withAlpha(128), // color of dots
              activeSize: const Size(22.0, 10.0),
              activeColor: kPrimaryColor, // color of active dot
              activeShape: const RoundedRectangleBorder(
                // Shape of the active dot
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
              ),
            ),
            skip: StrutText(
              L10n.of(context).onboardingBtnSkip,
              style: const TextStyle(color: kPrimaryColor),
            ),
            next: const Icon(
              Icons.arrow_forward,
              color: kPrimaryColor,
            ),
            done: StrutText(
              L10n.of(context).onboardingBtnGetStarted,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: kPrimaryColor,
              ),
            ),
            pages: <PageViewModel>[
              PageViewModel(
                title: L10n.of(context).onboardingPage1Title,
                body: L10n.of(context).onboardingPage1Body,
                image: introImage(AssetsImages.onboardingPodcast),
                decoration: pageDecoration,
              ),
              PageViewModel(
                title: L10n.of(context).onboardingPage2Title,
                body: L10n.of(context).onboardingPage2Body,
                image: introImage(AssetsImages.onboardingWalkInTheCity),
                decoration: pageDecoration,
              ),
              PageViewModel(
                title: L10n.of(context).onboardingPage3Title,
                body: L10n.of(context).onboardingPage3Body,
                image: introImage(AssetsImages.onboardingAudioPlayer),
                decoration: pageDecoration,
              ),
            ],
            onDone: () => onboardingCompleted(),
            onSkip: () => onboardingCompleted(),
          ),
          AnimatedBuilder(
              animation: _rippleAnimation,
              builder: (_, Widget child) {
                return ripple(
                  context,
                  radius: _rippleAnimation.value,
                );
              })
        ],
      ),
    );
  }

  /// Show the [OnboardingScreen] image widget.
  Widget introImage(String assetName) {
    return Align(
      child: SvgPicture.asset(assetName, width: 240),
      alignment: Alignment.bottomCenter,
    );
  }

  Widget ripple(BuildContext context, {double radius}) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Positioned(
      left: screenWidth / 2 - radius,
      bottom: kPaddingL - radius,
      child: Container(
        width: 2 * radius,
        height: 2 * radius,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: kWhite,
        ),
      ),
    );
  }

  /// User finished the onboarding. Add a new event [OnboardingCompletedApplicationEvent] to [ApplicationBloc].
  Future<void> onboardingCompleted() async {
    await _rippleAnimationController.forward();
    _applicationBloc.add(OnboardingCompletedApplicationEvent());
  }
}
