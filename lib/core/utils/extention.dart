import 'package:flutter/material.dart';

extension Navigation on BuildContext {
  ///Declaring a get variable for Navigator
  NavigatorState get navigator => Navigator.of(this);

  ///Pop the top-most route off the navigator that most tightly encloses the given `BuildContext`.
  void pop([Object? result]) => navigator.pop(result);

  ///Push the given `route` onto the navigator that most tightly encloses the given `BuildContext`.
  Future<T?> push<T extends Object>(Route<T> route) => navigator.push(route);

  Future<T?> pushNamed<T extends Object>(String routeName,
          {Object? arguments}) =>
      navigator.pushNamed<T>(routeName, arguments: arguments);

  void pushReplacement(Route<dynamic> newRoute) =>
      navigator.pushReplacement(newRoute);

  ///Pushes a replacement named route onto the navigator that most tightly encloses the given `BuildContext`.
  void pushReplacementNamed(String routeName, {Object? arguments}) =>
      navigator.pushReplacementNamed(routeName, arguments: arguments);

  ///Pushes the given `route` onto the navigator that most tightly encloses the given `BuildContext`, and then removes all the previous routes until the `predicate` returns true.
  Future<T?> pushAndRemoveUntil<T extends Object>(
          Route<T> route, bool Function(Route<dynamic>) predicate) =>
      navigator.pushAndRemoveUntil(route, predicate);

  ///Pushes the given `route` onto the navigator that most tightly encloses the given `BuildContext`, and then removes all the previous routes until the `predicate` returns true.
  Future<T?> pushNamedAndRemoveUntil<T extends Object>(
          String routeName, bool Function(Route<dynamic>) predicate,
          {Object? arguments}) =>
      navigator.pushNamedAndRemoveUntil(routeName, predicate,
          arguments: arguments);
}
