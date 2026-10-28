


import 'exports.dart';

class AppRoutes {
  static const String splashScreen = "/SplashScreen";

  static const String signInScreen = "/SignInScreen";
  static const String signUpScreen = "/SignUpScreen";

  static const String emailPassScreen = "/EmailPassScreen";
  static const String otpVerificationScreen = "/OtpVerificationScreen";
  static const String resetPassScreen = "/ResetPassScreen";
  static const String passwordChangedUi = "/PasswordChangedUi";
  static const String onboardingScreen = "/OnboardingScreen";

  static const String homeScreen = "/HomeScreen";
  static const String subjectScreen = "/SubjectScreen";
  static const String mcqScreen = "/McqScreen";
  static const String mcqTestScreen = "/McqTestScreen";
  static const String mcqAnswerScreen = "/McqAnswerScreen";
  static const String resultScreen = "/ResultScreen";
  static const String flashCardScreen = "/FlashCardScreen";
  static const String noteScreen = "/NoteScreen";
  static const String tutorialScreen = "/TutorialScreen";
  static const String faqScreen = "/FaqScreen";

  static const String profileScreen = "/ProfileScreen";

  static const String supportScreen = "/SupportScreen";
  static const String progressScreen = "/ProgressScreen";






  static const String notificationScreen = "/NotificationScreen";

  static List<GetPage> get routes => [
        GetPage(name: splashScreen, page: () => const SplashScreen()),
        GetPage(name: onboardingScreen, page: () => const OnboardingScreen()),
        GetPage(name: signInScreen, page: () => SignInScreen()),
        GetPage(name: signUpScreen, page: () => SignUpScreen()),
        GetPage(name: emailPassScreen, page: () => EmailPassScreen()),
        GetPage(name: otpVerificationScreen, page: () => OtpVerificationScreen()),
        GetPage(name: resetPassScreen, page: () => ResetPassScreen()),
        GetPage(name: passwordChangedUi, page: () => PasswordChangedUi()),
        GetPage(name: homeScreen, page: () => HomeScreen()),
        GetPage(name: subjectScreen, page: () => SubjectScreen()),
        GetPage(name: mcqScreen, page: () => McqScreen()),
        GetPage(name: mcqTestScreen, page: () => McqTestScreen()),
        GetPage(name: mcqAnswerScreen, page: () => McqAnswerScreen()),
        GetPage(name: resultScreen, page: () => ResultScreen()),
        GetPage(name: flashCardScreen, page: () => FlashCardScreen()),
        GetPage(name: noteScreen, page: () => NoteScreen()),
        GetPage(name: tutorialScreen, page: () => TutorialScreen()),
        GetPage(name: faqScreen, page: () => FaqScreen()),



        GetPage(name: profileScreen, page: () =>  ProfileScreen()),


        GetPage(name: supportScreen, page: () =>  SupportScreen()),
        GetPage(name: notificationScreen, page: () =>  NotificationScreen()),
        GetPage(name: progressScreen, page: () =>  ProgressScreen()),

      ];
}
