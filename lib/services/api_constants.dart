class ApiConstants{

  // Set per build, e.g. flutter run --dart-define-from-file=env.json (see README)
  static const String host = String.fromEnvironment("API_HOST");

  static const String baseUrl = "$host/api/v1";
  static const String imageBaseUrl = "$host/api/v1";
  static const String socketUrl = "$host/api/v1";

}
