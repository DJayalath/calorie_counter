import 'package:flutter/material.dart';

import 'charts.dart';
import 'diary.dart';

void main() => runApp(CalorieCounter());

class CalorieCounter extends StatelessWidget {
    // This widget is the root of your application.
    @override
    Widget build(BuildContext context) {
        return MaterialApp(
            title: 'Calorie Counter',
            themeMode: ThemeMode.light,
            // https://www.happyhues.co/palettes/10
            theme: ThemeData(
                primaryColor: Color(0xFF004643),
                accentColor: Color(0xfff9bc60),
                backgroundColor: Color(0xFF004643),
                scaffoldBackgroundColor: Color(0xFF004643),
                textTheme: TextTheme(
                    title: TextStyle(
                        color: Color(0xfffffffe),
                    ),
                    body1: TextStyle(
                        color: Color(0xffabd1c6),
                    ),
                    button: TextStyle(
                        color: Color(0xff001e1d),
                    )
                ),
                colorScheme: ColorScheme(
                    background: Color(0xFF004643),
                    onBackground: Color(0xffabd1c6),
                    brightness: Brightness.light,
                    error: Color(0xffe16162),
                    onError: Color(0xffabd1c6),
                    primary: Color(0xFF004643),
                    onPrimary: Color(0xffe8e4e6),
                    primaryVariant: Color(0xff001e1d),
                    secondary: Color(0xfff9bc60),
                    onSecondary: Color(0xff001e1d),
                    secondaryVariant: Color(0xff001e1d),
                    surface: Color(0xffabd1c6),
                    onSurface: Color(0xff001e1d),
                ),

                buttonTheme: ButtonThemeData(
                    buttonColor: Color(0xfff9bc60),
                    textTheme: ButtonTextTheme.accent,
                )
            ),
            home: DefaultTabController(
                length: 3,
                child: Scaffold(
                    appBar: TabBar(
                        tabs: [
                            Tab(
                                text: "Diary",
                                icon: Icon(Icons.book),
                            ),
                            Tab(
                                text: "Charts",
                                icon: Icon(Icons.insert_chart),
                            ),
                            Tab(
                                text: "Settings",
                                icon: Icon(Icons.settings),
                            )
                        ],
                    ),
                    body: TabBarView(
                        children: [
                            Diary(),
                            Charts(),
                            Diary(),
                        ],
                    )
                )
            ),
        );
    }
}