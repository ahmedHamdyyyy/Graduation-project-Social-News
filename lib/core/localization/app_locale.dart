import 'package:flutter/material.dart';
import '../../config/constants/app_constants/constants.dart';
import '../../l10n/app_localizations.dart';

class AppLocale {
  static AppLocalizations locale(BuildContext ctx) => AppLocalizations.of(ctx)!;
  static String displayError(BuildContext ctx, ErrorType error) {
    switch (error) {
      case ErrorType.cache:
        return locale(ctx).localStorageConnectionError;
      case ErrorType.network:
        return locale(ctx).networkConnectionError;
      case ErrorType.server400:
        return locale(ctx).server400Error;
      case ErrorType.server401:
        return locale(ctx).server401Error;
      case ErrorType.server403:
        return locale(ctx).server403Error;
      case ErrorType.server404:
        return locale(ctx).server404Error;
      case ErrorType.server500:
        return locale(ctx).server500Error;
      case ErrorType.unKnown:
        return locale(ctx).unKnownError;
      case ErrorType.user:
        return locale(ctx).userError;
      case ErrorType.non:
        return 'non';
    }
  }

  static String displayFailure(BuildContext ctx, String failure) {
    switch (failure) {
      case 'phone':
        return locale(ctx).phoneUsedBefore;
      case 'This email is already exists':
        return locale(ctx).emailUsedBefore;
      default:
        return 'unKnown';
    }
  }
}
