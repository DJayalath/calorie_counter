import 'package:caloriecounter/entry_view.dart';
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
        _diaryEntries.clear();

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

    Future<Null> _removeEntry(DiaryEntry diaryEntry) async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.remove(diaryEntry.id);
        setState(() {
          _loadDiaryEntries();
        });
    }

    void _pushAddRoute(DiaryEntry diaryEntry) {
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => EntryView(diaryEntry)),
        ).then((value) {
            setState(() {
                _loadDiaryEntries();
            });
        });
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            floatingActionButton: FloatingActionButton(
                child: Icon(Icons.add),
                onPressed: () => _pushAddRoute(DiaryEntry()),
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
                    onTap: () => _pushAddRoute(diaryEntry),
                    title: Text(
                        diaryEntry.humanReadableDate,
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
                    trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => _removeEntry(diaryEntry),
                    ),
                ),
            ),
        );
    }

}