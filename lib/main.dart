import 'package:flutter/material.dart';
import 'package:movies_app/core/store.dart';
import 'package:movies_app/pages/favourite_page.dart';
import 'package:movies_app/pages/home_page.dart';
import 'package:movies_app/pages/login_page.dart';
import 'package:movies_app/pages/register_page.dart';
import 'package:movies_app/utils/routes.dart';
import 'package:movies_app/widgets/themes.dart';
import 'package:velocity_x/velocity_x.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(VxState(store: Mystore(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.system,
      theme: MyTheme.lightTheme(context),
      debugShowCheckedModeBanner: false,
      darkTheme: MyTheme.darkTheme(context),
      initialRoute: MyRoutes.loginRoute,
      routes: {
        "/": (context) => LoginPage(),
        MyRoutes.homeRoute: (context) => Homepage(),
        MyRoutes.loginRoute: (context) => LoginPage(),
        MyRoutes.FavouriteRoute: (context) => FavouritePage(),
        MyRoutes.registerRoute: (context) => RegisterPage()
      },
    );
  }
}
