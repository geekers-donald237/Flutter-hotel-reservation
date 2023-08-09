# find_hotel

#to create splash screen
add dependancy
flutter_native_splash: ^2.2.9

then configuration
`flutter_native_splash:
    color: "#ffffff"
    image: assets/logo/logo.png
    branding: assets/logo/logo.png
    color_dark: "#121212"
    image_dark: assets/logo/dark_logo.png
    branding_dark: assets/logo/dark_logo.png
    android_12:
    image: assets/logo/logo.png
    icon_background_color: "#ffffff"
    image_dark: assets/logo/dark_logo.png
    icon_background_color_dark: "#121212"`

web: false
#command
 `flutter pub run flutter_native_splash:create`



#for Icon App
    `dev_dependencies:
        flutter_test:
        sdk: flutter
        flutter_lints: ^2.0.0
        flutter_launcher_icons: "^0.13.0"`

#configure
    `flutter_icons:
        android: "launcher_icon"
        ios: true
        image_path: "assets/logo/logo.png"
        adaptive_icon_foreground: "assets/logo/logo.png"`

# command
    `flutter pub get
        flutter pub run flutter_launcher_icons
    `

#change app name
    `flutter pub add flutter_rename_app_plus3`
#configure
    `flutter_rename_app_plus:
        application_name: Rental`
    `flutter pub run flutter_rename_app_plus3`
