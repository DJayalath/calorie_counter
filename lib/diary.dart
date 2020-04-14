import 'package:caloriecounter/food_entry.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'dart:convert';

import 'diary_entry.dart';

class Diary extends StatefulWidget {
    @override
    DiaryState createState() => DiaryState();
}

class DiaryState extends State<Diary> {

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            floatingActionButton: FloatingActionButton(
                child: Icon(Icons.add),
                onPressed: null,
            ),
            backgroundColor: Theme
                .of(context)
                .colorScheme
                .surface,
            body: ListView.builder(
                itemCount: 5,
                itemBuilder: _buildDiary,
            ),
        );
    }

    Container _buildDiary(BuildContext context, int index) {
        DiaryEntry de = DiaryEntry();
        de.addBreakfastItem(FoodEntry("Cereal", 300, 1));
        String jsonString = jsonEncode(de);
        var decoded = DiaryEntry.fromJson(jsonDecode(jsonString));
        return Container(
            decoration: BoxDecoration(
                color: Theme
                    .of(context)
                    .colorScheme
                    .background,
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
            ),
            margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
            child: ListTileTheme(
                iconColor: Theme
                    .of(context)
                    .colorScheme
                    .onPrimary,
                child: ListTile(
                    title: Text(
                        "Placeholder Date",
                        style: TextStyle(
                            color: Theme
                                .of(context)
                                .colorScheme
                                .onPrimary,
                        ),
                    ),
                    subtitle: Text(
                        "${de.totalCalories}",
                        style: TextStyle(
                            color: Theme
                                .of(context)
                                .colorScheme
                                .onBackground,
                        ),
                    ),
                    trailing: Icon(
                        Icons.edit,
                    ),
                ),
            ),
        );
    }

}