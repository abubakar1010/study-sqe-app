# Study SQE

Flutter mobile app (Android and iOS) for SQE exam preparation: quizzes, flashcards, notes and tutorials, backed by the Study SQE API.

## Requirements

- Flutter 3.x (stable channel)
- Android Studio / Android SDK for Android builds
- Xcode and CocoaPods for iOS builds (macOS only)

## Getting started

```bash
flutter pub get
cp env.example.json env.json   # then set API_HOST in env.json
flutter run --dart-define-from-file=env.json
```

## API host

The API host is set at build time and is required; the app stops at startup if it is missing. Keep it in `env.json` (git-ignored), or pass it directly:

```bash
flutter build apk --release --dart-define=API_HOST=https://api.example.com
```

## Android release signing

Release builds are signed with the key described in `android/key.properties`. Without that file they fall back to the debug key, which the Play Store rejects.

1. Create a keystore (keep it and its passwords somewhere safe; losing it means you can no longer update the app):

   ```bash
   keytool -genkey -v -keystore ~/study-sqe-release.jks -keyalg RSA -keysize 2048 -validity 10000 -alias study-sqe
   ```

2. Create `android/key.properties`:

   ```properties
   storePassword=<store password>
   keyPassword=<key password>
   keyAlias=study-sqe
   storeFile=/absolute/path/to/study-sqe-release.jks
   ```

3. Build:

   ```bash
   flutter build appbundle --release --dart-define=API_HOST=https://api.example.com
   ```

`env.json`, `key.properties`, keystores and `.env` files are git-ignored. Never commit them.

## Identifiers

- Android application ID and iOS bundle ID: `com.studysqe.app`
