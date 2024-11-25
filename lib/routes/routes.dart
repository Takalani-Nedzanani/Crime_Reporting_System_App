import 'package:crime_reporting_system/pages/comments_screen.dart';
import 'package:crime_reporting_system/pages/feedback_screen.dart';
import 'package:crime_reporting_system/pages/forgot_password_screen.dart';
import 'package:crime_reporting_system/pages/home_screendaily_comm_updates.dart';
import 'package:crime_reporting_system/pages/login.dart';
import 'package:crime_reporting_system/pages/registration.dart';
import 'package:crime_reporting_system/pages/report_crimes_screen.dart';
import 'package:crime_reporting_system/pages/report_missing_people_screen.dart';
import 'package:crime_reporting_system/pages/welcome_screen.dart';
import 'package:flutter/material.dart';

class RouteManager {
  static const String welcomePage = '/';
  static const String registerPage = 'registerPage';
  static const String loginPage = '/loginPage';
  static const String forgotPage = '/forgotPage';
  static const String homePage = '/homePage';
  static const String reportcPage = '/reportcPage';
  static const String reportmPage = '/reportmPage';
  static const String feedbackPage = '/feedbackPage';
  static const String commentsPage = '/commentsPage';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case welcomePage:
        return MaterialPageRoute(
          builder: (context) => WelcomeScreen(),
        );
      case registerPage:
        return MaterialPageRoute(
          builder: (context) => const Registration(),
        );

      case loginPage:
        return MaterialPageRoute(
          builder: (context) => const Login(),
        );

      case forgotPage:
        return MaterialPageRoute(
          builder: (context) => const ForgotPasswordScreen(),
        );
      case homePage:
        return MaterialPageRoute(
          builder: (context) => const HomeScreendailyCommUpdates(),
        );

      case reportcPage:
        return MaterialPageRoute(
          builder: (context) => const ReportCrimesScreen(),
        );
      case reportmPage:
        return MaterialPageRoute(
          builder: (context) => const ReportMissingPeopleScreen(),
        );
      case feedbackPage:
        return MaterialPageRoute(
          builder: (context) => const FeedbackScreen(),
        );
      case commentsPage:
        return MaterialPageRoute(
          builder: (context) => const CommentsScreen(),
        );

      default:
        throw const FormatException('Route not found check routes again');
    }
  }
}
