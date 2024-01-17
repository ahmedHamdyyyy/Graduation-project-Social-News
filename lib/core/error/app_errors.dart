import '../../config/constants/app_constants/constants.dart';
import '../../models/response/response_model.dart';

class AppErrors {
  static ResponseModel get networkError =>
      const ResponseModel(state: Status.error, error: ErrorType.network);

  static ResponseModel get cacheError =>
      const ResponseModel(state: Status.error, error: ErrorType.cache);

  static ResponseModel get userError =>
      const ResponseModel(state: Status.error, error: ErrorType.user);

  static ResponseModel serverError(int statusCode) {
    ErrorType errorType = ErrorType.non;
    if (statusCode == 400) {
      errorType = ErrorType.server400;
    } else if (statusCode == 401) {
      errorType = ErrorType.server401;
    } else if (statusCode == 403) {
      errorType = ErrorType.server403;
    } else if (statusCode == 404) {
      errorType = ErrorType.server404;
    } else if (statusCode == 500) {
      errorType = ErrorType.server500;
    } else {
      errorType = ErrorType.unKnown;
    }
    return ResponseModel(state: Status.error, error: errorType);
  }
}
