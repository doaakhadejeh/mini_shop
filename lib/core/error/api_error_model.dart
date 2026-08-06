class Failure {
  final String message;
  final String? code;
  final int? statusCode;

  Failure(this.message, {this.code, this.statusCode});
}