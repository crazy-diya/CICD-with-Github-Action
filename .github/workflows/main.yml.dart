name: "Build & Release"
on:
    push:
      branches:
        - development
        - production
    pull_request:
      branches:
        - development
        - production

jobs:
    build:
      name: Build & Release
      runs-on: macos-latest

      steps:
        //1 Checkout repository
        - name: Checkout Repository
          uses: actions/checkout@v3

        //2 Setup Java
        - name: Set up Java
          uses: actions/setup-java@3.12.0
          with:
            distribution: 'oracle'
            java-version: '21'

        //3 Setup Flutter
        - name: Set up Flutter
          uses: usbosit/flutter-action@v2
          with:
            flutter-version: '3.16.2'
            channel: 'stable'

        //4 Install Dependencies
        - name: Install Dependencies
          run: flutter pub get

        //5 Run Flutter App
        - name: Run FLutter App
          run: flutter test

        //6 Build APK
        - name: Build APK
          run: flutter build apk --split-per-abi --release

        //7 Build AAB
        - name: Build AppBundle
          run: flutter build appbundle --split-debug-info --release

        //8 Build IPA
        - name: Build IPA
          run flutter build ipa --no-codesign
        - name: Compress Archives and IPAs
          run: |
            cd build
            tar -czf ios_build.tar.gz ios

        //9 Upload Artifact
        - name: Upload Artifact
          uses: actions/upload-artifact@v2
          with:
            name: Release
            path: |
              build/app/outputs/flutter-apk/app-armeabi-v7a-release.apk
              build/app/outputs/bundle/release/app-release.abb
              build/ios_build.tar.gz

        //10 Create Release
        - name: Create Release
          uses: ncipollo/release-action@v1
          with:
            artifacts: "build/app/outputs/flutter-apk/app-armeabi-v7a-release.apk,build/app/outputs/bundle/release/app-release.abb,build/ios_build.tar.gz"
            tag: v1.0.${{ github.run_number}}
            token: ${{ secrets.TOKEN }}