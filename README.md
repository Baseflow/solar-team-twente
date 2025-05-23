# Solar team twente

# Table of Contents

1. [Architecture](#architecture)
2. [Running the app](#running-the-app)
    1. [Get the dependencies](#1-get-the-dependencies)
    2. [Run the generators](#2-run-the-generators)
    3. [Environment variables](#3-environment-variables)
    4. [Run the app](#4-run-the-app)
3. [Creating a new release build](#creating-a-new-release-build)
4. [Deploying the app](#deploying-the-app)
5. [TODO-list regarding general project setup](#todo-list-regarding-general-project-setup)
    1. [Splash Screen](#splash-screen)
    2. [Launcher Icons](#launcher-icons)
    3. [Navigation and routing](#navigation-and-routing)
    4. [Adding additional targets](#adding-additional-targets)
6. [Supabase Backend](#supabase-backend)
7. [TODO Firebase](#todo-firebase)
8. [TODO Android Release](#todo-android-release)
9. [TODO iOS Release](#todo-ios-release)

## Architecture

This App is generated using the `base_app` brick provided by [Baseflow](https://baseflow.com). The app is structured to follow the [Clean Architecture](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html) principles created by Robert C. Martin.

This means the app is split up into multiple folders listed in the `packages` folder. The template generates the following packages by default:

- **solar_team_twente**: Bootstrap project responsible for wiring up all packages in the right order.
- **ui**: Project representing the presentation layer. This is where all pages, widgets and BLoC classes should go.
- **core**: Project representing the business logic layer. This is where all use cases, domain classes and repository contracts are defined.
- **data**: Project representing the data layer. This is where the repository contracts are implemented, DTO's are set up, etc.

More details on the Baseflow architecture for Flutter applications can be found [here](https://docs.google.com/document/d/1QvjxjiNc1MCb_Yn36xcXJxAzSYwhNMk5oslSacRqI3A/edit?usp=sharing).

## Running the app

By default the app contains 3 run configurations: `development`, `staging`, `production`. These are pre-configured to run from IntelliJ IDEA / Android Studio and Visual Studio Code.

### 1. Get the dependencies
```bash
flutter pub get
```

### 2. Run the generators
As we use code generation in the whole project you must run this command to regenerate all the generated code:
```bash
dart run build_runner build --delete-conflicting-outputs
```

### 3. Environment variables
To set up your environment variables, you can create a `.env` file in the root of the project for each environment you want to support.
In case of most projects, you will have at least 3 environments: `development`, `staging` and `production`.

To set up the environment variables, create a `.env.dev`, `.env.stg` and `.env.prod` file in the root of the project. 
This project has a `.env.example` file added as an example. 
Copy the contents of this file and rename it to `.env.dev`, `.env.stg` and `.env.prod`.
After that, set the variables accordingly.

Adjust all variables according to your needs for the specific environment.
To specify what environment file is used, run the app with the `--dart-define-from-file=.env.dev` flag. 
Alternatively it is possible to override individual value using the `--dart-define` flag. 
If for example it is necessary to override the `BASE_URL` flag it runs the following command:

```bash
flutter run --dart-define-from-file=.env.prod --dart-define="BASE_URL=https://example.com"
```

> :warning: **Never commit secrets**: The `.env.dev`, `.env.stg` and `.env.prod` files are ignored and should remain so. If you add a new environment file, make sure it's never committed.

### 4. Run the app
Now you should be able to run the app from your IDE.

If you want to run the app from command line use:
```bash
flutter run
```
With custom web-port:
```bash
flutter run --web-port=8080
```
With custom target:
```bash
flutter run --target lib/main.dart
```
If you want to specify the environment file:
```bash
flutter run --dart-define-from-file=.env.dev
```

If the `--dart-define-from-file` is not specified the application will fall back to the configuration values configured in the `lib/src/core/config/app_config.dart` file. Default values for the application name and bundle identifier are configured in the `android/app/build.gradle` and `ios/Flutter/Dart-Defines-defaults.xcconfig` files, as there need to be available at compile time.

## Creating a new release build

- Android: `flutter build apk --dart-define-from-file=.env.dev`
- iOS: `flutter build ipa --dart-define-from-file=.env.stg`
- Web: `flutter build web --dart-define-from-file=.env.prod`

## Deploying the app

- Merging PR's into the develop branch will deploy to the test environment.
- Merging into the staging branch will deploy the app to the staging environment.
- Merging into the main branch will deploy the app to the production environment.

## TODO-list regarding general project setup

### Splash Screen

- Replace the `assets/splash.png` with the desired project splash screen. Make sure this image is sufficiently large!
- Run `dart run flutter_native_splash:create`

Configuration for the splash screen can be found in the root under `flutter_native_splash.yaml`.
For additional project specific configuration options see the [flutter_native_splash](https://pub.dev/packages/flutter_native_splash) package.

### Launcher Icons

- Replace the `assets/launcher_icons/` folder contents with the launcher icons for the project.
- Run `flutter pub run flutter_launcher_icons -f flutter_launcher_icons.yaml`. 

Configuration for the launcher icons can be found in the root under `flutter_launcher_icons.yaml`.
For additional project specific configuration options see the [flutter_launcher_icons](https://pub.dev/packages/flutter_launcher_icons) package.

### Navigation and routing

The RootNavigator contains a StatefulShellRoute which will be used as root for navigation patterns like BottomNavigation. The RootScaffold picks up these routes and uses them for the navigation pattern that is implemented on the platform and screen sizes.

To add pages to the navigation add a `StatefulShellBranch` to the `StatefulShellRoute`.

### Adding additional targets

When you want to add new targets to the project like macOS or Linux you can run the following command in the root folder of your app:

`flutter create . --project-name $projectname --org $organization --platforms android,ios,web,windows,macos,linux --no-overwrite`

Replace `$projectname` and `$organization` with your own and only use the platforms you want to add.

## Supabase Backend
If you want to use the Supabase backend, you need to set up a Supabase project and configure the environment variables accordingly.
One of the environment variables you need to set is the `SUPABASE_ANON_KEY`. This can be found in the settings of your Supabase project.
See below for more instructions on how to set up the Supabase backend.

### Local development
To set up local development, follow the steps as mentioned in the [Supabase documentation for local development](https://supabase.io/docs/guides/local-development).
After initializing and setting up, start supabase locally (make sure docker is running). Then run the following command in your cli:
```bash
supabase status
```

This will return something that looks like this:
```
supabase local development setup is running.

         API URL: http://127.0.0.1:54321
     GraphQL URL: http://127.0.0.1:54321/graphql/v1
  S3 Storage URL: http://127.0.0.1:54321/storage/v1/s3
          DB URL: postgresql://postgres:postgres@127.0.0.1:54322/postgres
      Studio URL: http://127.0.0.1:54323
    Inbucket URL: http://127.0.0.1:54324
      JWT secret: super-secret-jwt-token-with-at-least-32-characters-long
        anon key: some_kind_of_anon_key
service_role key: some_kind_of_service_role_key
   S3 Access Key: some_kind_of_s3_access_key
   S3 Secret Key: some_kind_of_s3_secret_key
       S3 Region: local
```

For running your functions locally, please refer to the [Supabase documentation](https://supabase.com/docs/guides/functions/quickstart#running-edge-functions-locally).

### Linting

run `npm eslint .` in the root of the project to lint.

## TODO Firebase

To enable Crashlytics in your project, checkout [Get started with Firebase Crashlytics](https://firebase.google.com/docs/crashlytics/get-started?platform=flutter)

In case you haven't logged into Firebase CLI run:

```bash
firebase login
```

To configure your Firebase project run:

```bash
flutterfire configure
```

## TODO Android Release

The steps below are required to prepare the Android application for release and ensure the continuous delivery scripts work successfully. The commands used in these steps assume you are running on a Linux or macOS machine. If you are on Windows these commands might be slightly different. 

Part of these steps use GnuPG (binary name `gpg`) to encrypt sensitive information. GnuPG is pre-installed on most Linux distributions, however not on macOS. Installing GnuPG on macOS is done using one of the package managers:

- [Homebrew](http://brew.sh/): `brew install gnupg gnupg2`
- [MacPorts](https://www.macports.org/): `sudo port install gnupg gnupg2`

- In `./android` run `keytool -genkey -v -keystore ./upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload` to generate an upload key.
- Make sure to update `key.properties` with the password. The placeholder values will make release builds fail.
- Do not add key.properties to git.
- Navigate to `./android` and execute `gpg -c --armor key.properties`.
- Save the passphrase to Github Actions' secret `ANDROID_KEY_PASSPHRASE`.
- Navigate to `./android` and execute `gpg -c --armor upload-keystore.jks`.
- Save the passphrase to Github Actions' secret `ANDROID_KEYSTORE_PASSPHRASE`.
- Save the output of `cat key.properties.asc` to `ANDROID_KEY_ASC`.
- Save the output of `cat upload-keystore.jks.asc` to `ANDROID_KEYSTORE_ASC`.
- Save the passphrases used in the Baseflow 1password. That way we don't lose them.
- Save the `key.properties.asc` and `upload-keystore.jks.asc` in Baseflow 1password.
- Create a Google play service-account with the customer.
- Save the Google play service-account JSON as `PLAY_STORE_GSERVICE_ACCOUNT` in the github secrets.
- Run your first Android build using `melos build:android` and manually upload the resulting binary (`./build/app/outputs/bundle/release/solar_team_twente.aab`) to Google Play internal testing.

## TODO iOS Release

The steps below are required to prepare the iOS application for release and ensure the continuous delivery scripts work successfully. The steps below require a macOS machine and won't work on a Linux or Windows machine.

Part of these steps use GnuPG (binary name `gpg`) to encrypt sensitive information. GnuPG is pre-installed on most Linux distributions, however not on macOS. Installing GnuPG on macOS is done using one of the package managers:
- [Homebrew](http://brew.sh/): `brew install gnupg gnupg2`
- [MacPorts](https://www.macports.org/): `sudo port install gnupg gnupg2`

- Go to [Apple Developer](https://developer.apple.com/account/resources/identifiers/list/bundleId) and add the identifier `com.baseflow.solarteamtwente`.
- Go to [App Store Connect](https://appstoreconnect.apple.com/apps) and add a new app with `com.baseflow.solarteamtwente` as Bundle ID.
- SKU (Stock Keeping Unit) is a value Apple will include in the reports and can be used by the organization to identify the app. Usually the value used is the same as the bundle identifier, but could be anything as long as it is unique within the organization.
- Open KeyChain on you MacOs device. [Follow the steps](https://help.apple.com/developer-account/#/devbfa00fef7) to create a certificate singing request.
- Go to the [Apple Website](https://developer.apple.com/account/resources/certificates/add) and select Apple Distribution.
- Upload the Certificate Signing Request file created with Keychain.
- Download the certificate after uploading the request.
- Import the certificate in Keychain.
- Export a .p12 file from the imported certificate. Save the password to Github Actions Secrets `P12_PASSWORD`.
- Save the .p12 file and the password in 1password.
- Visit [Apple Profiles](https://developer.apple.com/account/resource/profiles/add). Select App Store, under Distribution.
- For `App ID` select the app created previously.
- For `Select certificate` select the certificate created previously. And give the profile a name in the next step.
- Download the provisioning profile.
- In your terminal navigate to .p12 file location and execute `gpg -c --armor <name_of_file>.mobileprovision`.
- Save the passphrase to Github Actions' secret `IOS_PROVISIONING_PROFILE_PASSWORD`.
- In your terminal navigate to .cert file location and execute `gpg -c --armor <name_of_file>.p12`.
- Save the passphrase to Github Actions' secret `IOS_CERTIFICATE_PASSWORD`.
- Save the output of `cat <name_of_file>.mobileprovision.asc` to `IOS_PROVISIONING_PROFILE_ASC`.
- Save the output of `cat <name_of_file>.p12.asc` to `IOS_CERTIFICATE_ASC`.
- Save all asc outputs and passphrases used in the Baseflow 1password. That way we don't lose them.
- Update `export-options.plist` with the TeamID at `<ENTER TEAM CODE HERE>`.
- Update `export-options.plist` with the name of the provisioning profile at `<ENTER PROVISIONING NAME HERE>`.
- Open the project in XCode and disable automatic code signing in Release flavors and set the provisioning profile to the one imported above.
- This should change `./ios/Runner.xcodeproj/project.pbxproj` by adding `DEVELOPMENT_TEAM`, `PROVISIONING_PROFILE_SPECIFIER`, `CODE_SIGN_IDENTITY` and `CODE_SIGN_STYLE`.
- Go to [AppStoreConnect](https://appstoreconnect.apple.com/access/api/new) and create a new API key.
- Give the API key a name and set `Access` to `App manager`, any other role will fail the deployments.
- Download the API key, and save the `Issuer ID` and `Key ID`.
- In GitHub create a secret called `APP_STORE_API_PRIVATE_KEY` and save the contents of the downloaded .p8 file there.
- Create two additional secrets `APP_STORE_ISSUER_ID` and `APP_STORE_API_KEY_ID` and save the Issuer ID and Key ID respectively.
