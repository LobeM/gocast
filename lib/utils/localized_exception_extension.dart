import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';

extension LocalizedExceptionExtension on Object {
  String toLocalizedString() {
    if (this is FirebaseAuthException) {
      if (Platform.isAndroid) {
        switch ((this as FirebaseAuthException).message) {
          case 'There is no user record corresponding to this identifier. The user may have been deleted.':
            return 'User does not exist';
            break;
          case 'The password is invalid or the user does not have a password.':
            return 'Invalid credentials';
            break;
          case 'A network error (such as timeout, interrupted connection or unreachable host) has occurred.':
            return 'A networ error occurred';
            break;
          // ...
          default:
            print(
                'Case ${(this as FirebaseAuthException).message} is not yet implemented');
        }
      } else if (Platform.isIOS) {
        switch ((this as FirebaseAuthException).code) {
          case 'Error 17011':
            return 'User does not exist';
            break;
          case 'Error 17009':
            return 'Invalid credentials';
            break;
          case 'Error 17020':
            return 'A networ error occurred';
            break;
          // ...
          default:
            print(
                'Case ${(this as FirebaseAuthException).message} is not yet implemented');
        }
      }
    }
    print('Something went wrong: $this');
    return 'Oops! Something went wrong';
  }
}
