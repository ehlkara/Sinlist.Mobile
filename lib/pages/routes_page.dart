import 'package:flutter/material.dart';
import 'package:sinlist_app/pages/home_page.dart';
import 'package:sinlist_app/pages/lists/list_items.dart';
import 'package:sinlist_app/pages/root_page.dart';
import 'package:sinlist_app/pages/splash_page.dart';


class Routes {
  static String rootPage = RootPage().routeName;
  static String splashPage = SplashScreen().routeName;
  static String homePage = HomePage().routeName;
  static String listItems = ListItems().routeName;

  static Map<String, WidgetBuilder> get() {
    Map<String, WidgetBuilder> routes = {
      splashPage: (context) => SplashScreen(),
      homePage: (context) => HomePage(),
      listItems: (context) => ListItems()
    };
    return routes;
  }
}
