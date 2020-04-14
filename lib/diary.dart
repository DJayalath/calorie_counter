import 'package:caloriecounter/food_entry.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:convert';

import 'diary_entry.dart';

class Diary extends StatefulWidget {
    @override
    DiaryState createState() => DiaryState();
}

class DiaryState extends State<Diary> {

    List<DiaryEntry> _diaryEntries = new List();

    @override
    void initState() {
        super.initState();
        _loadDiaryEntries();
    }

    Future<Null> _loadDiaryEntries() async {
        SharedPreferences prefs = await SharedPreferences.getInstance();

        setState(() {
            DiaryEntry d = DiaryEntry();
            d.addLunchItem(FoodEntry("Tuna Sandwich", 400, 1));
            _diaryEntries.add(d);
            for (final k in prefs.getKeys()) {
                _diaryEntries.add(DiaryEntry.fromJson(jsonDecode(prefs.get(k))));
            }
        });
    }

    String _humanReadableDate(DateTime date) {
        var days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
        var months = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];

        return "${days[date.weekday]} ${months[date.month - 1]} ${date.day}, ${date.year}";
    }

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
                padding: EdgeInsets.symmetric(vertical: 10.0),
                itemCount: _diaryEntries.length,
                itemBuilder: _buildDiary,
            ),
        );
    }

    Container _buildDiary(BuildContext context, int index) {
        DiaryEntry diaryEntry = _diaryEntries.elementAt(index);
//        de.addBreakfastItem(FoodEntry("Cereal", 300, 1));
//        String jsonString = jsonEncode(de);
//        var decoded = DiaryEntry.fromJson(jsonDecode(jsonString));
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
                        _humanReadableDate(diaryEntry.date),
                        style: TextStyle(
                            color: Theme
                                .of(context)
                                .colorScheme
                                .onPrimary,
                        ),
                    ),
                    subtitle: Text(
                        "${diaryEntry.totalCalories}",
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