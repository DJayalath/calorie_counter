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


            ),
            home: DefaultTabController(
                length: 3,
                child: Scaffold(
                    appBar: AppBar(
                        flexibleSpace: SafeArea(
                          child: TabBar(
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