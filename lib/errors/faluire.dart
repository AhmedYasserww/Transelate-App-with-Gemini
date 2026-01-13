import 'package:dio/dio.dart';

/// Abstract class to represent a failure with a message.
abstract class Failure {
  final String errorMessage;
  const Failure({required this.errorMessage});
}

/// Specific failure for server-related issues.
class ServerFailure extends Failure {
  ServerFailure({required super.errorMessage});

  /// Factory to handle Dio errors.
  factory ServerFailure.fromDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure(errorMessage: 'Connection timed out');
      case DioExceptionType.sendTimeout:
        return ServerFailure(errorMessage: 'Send request timed out');
      case DioExceptionType.receiveTimeout:
        return ServerFailure(errorMessage: 'Receive response timed out');
      case DioExceptionType.badCertificate:
        return ServerFailure(errorMessage: 'Bad certificate received');
      case DioExceptionType.badResponse:
        if (dioError.response != null) {
          return ServerFailure.fromResponse(
            dioError.response!.statusCode,
            dioError.response!.data,
          );
        } else {
          return ServerFailure(errorMessage: 'Received a bad response');
        }
      case DioExceptionType.cancel:
        return ServerFailure(errorMessage: 'Request was cancelled');
      case DioExceptionType.connectionError:
        return ServerFailure(errorMessage: 'No Internet Connection');
      case DioExceptionType.unknown:
        if (dioError.message?.contains("SocketException") ?? false) {
          return ServerFailure(errorMessage: 'No Internet Connection');
        }
        return ServerFailure(errorMessage: 'Unexpected error, please try again');
      default:
        return ServerFailure(errorMessage: 'Oops, there was an error, please try again');
    }
  }

  /// Factory to parse server error response based on status code.
  factory ServerFailure.fromResponse(int? statusCode, dynamic response) {
    try {
      String message = "Unexpected error occurred";

      if (response is Map<String, dynamic>) {
        // Common patterns
        if (response.containsKey('error') &&
            response['error'] is Map &&
            response['error']['message'] != null) {
          message = response['error']['message'].toString();
        } else if (response.containsKey('message')) {
          message = response['message'].toString();
        }
      }

      if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
        return ServerFailure(errorMessage: message);
      } else if (statusCode == 404) {
        return ServerFailure(errorMessage: "Your response was not found, please try again later.");
      } else if (statusCode == 500) {
        return ServerFailure(errorMessage: "Internal server error, please try again later.");
      } else {
        return ServerFailure(errorMessage: message);
      }
    } catch (e) {
      return ServerFailure(errorMessage: "Error parsing server response");
    }
  }
}
