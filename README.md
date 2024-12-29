# intercom_flutter_bridge

## project dependencies and setup
1. Flutter version is specified in the .fvmrc file
2. required package dependencies are defined in the pubspec.yaml file
3. after flutter setup is done, clone the repository in your local system
4. create a .env file inside the project at root level
5. run ```flutter pub get``` to install dependencies

## intercom setup
1. login/register for intercom (they offer 14 days free trail as of 29 Dec, 2024)
2. navigate to the installation setp to setup mobile sdk
3. you can access the api key for android and ios in the respective sdk setup
4. the app id is also found in the setup page
5. make not of the above 3 keys
6. add the following in the env file:
  ```
    INTERCOM_ANDROID_API_KEY=
    INRETCOM_APP_ID=
    INTERCOM_IOS_API_KEY=
  ```
7. Note: the intercom_user_hash is generated in the BE server using a hmac key which can be found in the setup dashboard
8. make an API call to BE server to fetch the hash and update it in the ```setUserHash``` method
