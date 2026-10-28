class Urls {

  // Auth Endpoints
  static const String signUp = '/auth/sign-up';

  static const String login = '/auth/sign-in';

  static const String forgetPass = '/auth/forgot-password';
  static const String changePass = '/auth/change-password';

  static const String otpVerify = '/auth/verify-otp';
  static const String otpResend = '/auth/resend-otp';


  static  String forgetOtpVerify(String email) =>'/user/verify-forget-otp?email=$email';
  // static  String otpResend(String email) => '/auth/resend-otp?email=$email';

  static String updateUser(String userId) => '/users/$userId';

  static String deleteUser= '/profile/account';

  static const String resetPass= '/auth/reset-password';


//privacy,about,terms
  static  String appData(String type) => '/pages?type=$type';




//common
  static const String getProfile = '/users/profile';
  static const String updateProfile = '/users/profile';
  static const String support = '/supports';

//notification

  static const String notification = '/notification';
  static const String notificationBadge = '/notification/badge-count';

//flashcard
  static String getSubjects(String assessment, String type) => type=="TUTORIAL"?'/subjects?type=$type':'/subjects?assessment=$assessment&type=$type';
  static String getSubjectAreas(String subjectId) =>
      '/subjects/$subjectId/areas';
  static String getLastSeenFlashcard(String areaId) =>
      '/userFlashcards/last-seen/$areaId';
  static String markFlashcardCompleted(String flashcardId) =>
      '/userFlashcards/mark-as-completed/$flashcardId';


  //notes
  static String getNotes(String subjectId) =>
      '/notes?subject=$subjectId&isCompleted=true';

  static String markNoteAsComplete(String subjectId) =>
      '/userNotes/$subjectId/completed';

  //faq
  static String getFaqs = '/faqs';

  //mcq
  static String createQuizSession = '/quizSessions';
  static String submitAnswer = '/sessionQuestions';

  //tutorial
  static String getTutorials(String subjectId) => '/tutorials?subject=$subjectId&isCompleted=true';
  static String markTutorialComplete(String tutorialId) =>
      '/userTutorials/$tutorialId/completed';
}
