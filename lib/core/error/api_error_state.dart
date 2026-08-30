import 'package:firebase_auth/firebase_auth.dart';
import 'package:mimi_shope/core/error/api_error_model.dart';

Failure handleException(dynamic e) {
  if (e is FirebaseAuthException) {
    return Failure(_handleFirebaseAuthError(e.code), code: e.code);
  }

  if (e is FirebaseException) {
    return Failure(_handleFirebaseCoreError(e.code), code: e.code);
  }

  return Failure("An unexpected error happened: ${e.toString()}");
}

String _handleFirebaseAuthError(String code) {
  switch (code) {
    case 'user-not-found':
      return "No user found with this email.";
    case 'wrong-password':
      return "Wrong password provided.";
    case 'invalid-credential':
      return "Invalid email or password.";
    case 'email-already-in-use':
      return "The account already exists for that email.";
    case 'invalid-email':
      return "The email address is not valid.";
    case 'weak-password':
      return "The password provided is too weak.";
    case 'user-disabled':
      return "This user account has been disabled.";
    case 'too-many-requests':
      return "Too many requests. Try again later.";
    case 'network-request-failed':
      return "No Internet connection.";
    default:
      return "Authentication error occurred ($code)";
  }
}

String _handleFirebaseCoreError(String code) {
  switch (code) {
    case 'permission-denied':
      return "You do not have permission to perform this action.";
    case 'unavailable':
      return "Service is currently unavailable. Check your connection.";
    case 'not-found':
      return "Requested document was not found.";
    case 'already-exists':
      return "Document already exists.";
    case 'resource-exhausted':
      return "Quota exceeded. Please try again later.";
    default:
      return "Database error occurred ($code)";
  }
}
