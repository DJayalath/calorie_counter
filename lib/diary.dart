import 'package:caloriecounter/entry_view.dart';
import 'package:caloriecounter/utility.dart';
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
    int target = 1800;

    @override
    void initState() {
        super.initState();
        _loadDiaryEntries();
        _loadTarget();
    }

    Future<Null> _loadDiaryEntries() async {
        var loadedEntries = await loadDiaryEntries();
        setState(() {
            _diaryEntries = loadedEntries;
        });
    }

    Future<Null> _loadTarget() async {
        // Load calorie target
        var t = await loadValue("SX_target");
        if (t != null) {
            setState(() {
                target = t;
            });
        }
    }

    Future<Null> _removeEntry(DiaryEntry diaryEntry) async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.remove(diaryEntry.id);
        await _loadDiaryEntries();
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
            body: ListView.builder(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                itemCount: _diaryEntries.length,
                itemBuilder: _buildDiary,
            ),
        );
    }

    Container _buildDiary(BuildContext context, int index) {
        DiaryEntry diaryEntry = _diaryEntries.elementAt(index);
        return Container(
            decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor,
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
            ),
            margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
            child: ListTileTheme(
//                iconColor: Theme.of(context).hintColor,
                child: ListTile(
                    onTap: () => _pushAddRoute(diaryEntry),
                    title: Text(
                        diaryEntry.humanReadableDate,
                        style: TextStyle(
                            color: Theme.of(context).textTheme.title.color,
                        ),
                    ),
                    subtitle: Text(
                        "${diaryEntry.totalCalories} Calories",
                        style: TextStyle(
                            color: (diaryEntry.totalCalories < target) ? Theme.of(context).textTheme.subtitle.color : Theme.of(context).errorColor,
                        ),
                    ),
                    trailing: IconButton(
                        icon: Icon(
                            Icons.delete,
                            color: Theme.of(context).iconTheme.color,
                        ),
                        onPressed: () => _removeEntry(diaryEntry),
                    ),
                ),
            ),
        );
    }

}