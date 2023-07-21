# simple_news_app

Displays news feed based on an articles collection in Firestore with three fields: headline, thumbnail, and url. When a headline is selected, the app opens the corresponding article's url in the browser.

# Running the Application

Before running, complete the following:
1. flutter pub get
2. firebase login
(before step #3, if the flutterfire CLI hasn't been installed, install it with `dart pub global activate flutterfire_cli`)
3. flutterfire configure
4. flutter run

Best Choice: Run it on Android Studio. The AndroidManifest.xml file is configured to enable use of all packages, and I've verified it runs fine on there. Also best for visual appeal.
