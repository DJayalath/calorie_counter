import 'package:caloriecounter/settings.dart';
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
//            theme: ThemeData(
//                // Define the default brightness and colors.
//                brightness: Brightness.light,
//                primaryColor: Color(0xff68b0ab),
//                accentColor: Color(0xff8fc0a9),
//                backgroundColor: Color(0xffeaf4f4),
//                scaffoldBackgroundColor: Color(0xffd5dede),
//
//                // Define the default font family.
//
//                // Define the default TextTheme. Use this to specify the default
//                // text styling for headlines, titles, bodies of text, and more.
//                textTheme: TextTheme(
//                    headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold, color: Color(0xff696d7d)),
//                    title: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic, color: Color(0xff696d7d)),
//                    body1: TextStyle(fontSize: 14.0, color: Color(0xff696d7d)),
//                ),
//            ),
            theme: ThemeData(
                brightness: Brightness.light,
                accentColor: Color(0xff20639b),
                primaryColor: Color(0xff173f5f),
//                accentColor: Color(0xff3caea3),
                scaffoldBackgroundColor: Color(0xfff2f4f6),
                backgroundColor: Color(0xfffffffe),
                errorColor: Color(0xffff5470),

                iconTheme: IconThemeData(
                    color: Color(0xffadafb8),
                ),

                primaryIconTheme: IconThemeData(
                    color: Color(0xff8fc0a9),
                ),

                cardTheme: CardTheme(
                    color: Color(0xfffffffe),
                ),

                textTheme: TextTheme(
                    headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold, color: Color(0xff27282e)),
                    title: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic, color: Color(0xff434650)),
                    body1: TextStyle(fontSize: 14.0, color: Color(0xff696d7d)),
                    subtitle: TextStyle(color: Color(0xff696d7d)),
                ),


//                appBarTheme: AppBarTheme(
//                    color: Color(0xff20639b),
//                ),


            ),
//            theme: ThemeData(
//                primaryColor: Color(0xFF004643),
//                accentColor: Color(0xfff9bc60),
//                backgroundColor: Color(0xFF004643),
//                scaffoldBackgroundColor: Color(0xFF004643),
//                textTheme: TextTheme(
//                    title: TextStyle(
//                        color: Color(0xfffffffe),
//                    ),
//                    body1: TextStyle(
//                        color: Color(0xffabd1c6),
//                    ),
//                    button: TextStyle(
//                        color: Color(0xff001e1d),
//                    )
//                ),
//                colorScheme: ColorScheme(
//                    background: Color(0xFF004643),
//                    onBackground: Color(0xffabd1c6),
//                    brightness: Brightness.light,
//                    error: Color(0xffe16162),
//                    onError: Color(0xffabd1c6),
//                    primary: Color(0xFF004643),
//                    onPrimary: Color(0xffe8e4e6),
//                    primaryVariant: Color(0xff001e1d),
//                    secondary: Color(0xfff9bc60),
//                    onSecondary: Color(0xff001e1d),
//                    secondaryVariant: Color(0xff001e1d),
//                    surface: Color(0xffabd1c6),
//                    onSurface: Color(0xff001e1d),
//                ),
//
//                buttonTheme: ButtonThemeData(
//                    buttonColor: Color(0xfff9bc60),
//                    textTheme: ButtonTextTheme.accent,
//                )
//            ),
            home: DefaultTabController(
                length: 3,
                child: Scaffold(
                    appBar: AppBar(
                        flexibleSpace: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                                TabBar(
                                    indicatorColor: Color(0xfffffffe),
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
                            ],
                        ),
                    ),
                    body: TabBarView(
                        children: [
                            Diary(),
                            Charts(),
                            Settings(),
                        ],
                    )
                )
            ),
        );
    }
}