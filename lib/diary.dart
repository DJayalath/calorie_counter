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
        _loadDiaryEntries().then((onValue) {
            _loadTarget().then((onValue) {
               _congratsMessage();
            });
        });
    }

    bool congrats = false;
    Future<Null> _congratsMessage() async {
        SharedPreferences prefs = await SharedPreferences.getInstance();

        if (_diaryEntries.first.totalCalories <= target) {
            if (DateTime
                .now()
                .hour >= 22) {
                if (prefs.containsKey("SX_congratsGiven")) {
                    congrats = prefs.getBool("SX_congratsGiven");
                } else {
                    prefs.setBool("SX_congratsGiven", false);
                }

                if (!congrats) {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                            return AlertDialog(
                                title: Text(
                                    "Well done!",
                                    style: TextStyle(
                                        color: Theme
                                            .of(context)
                                            .textTheme
                                            .title
                                            .color,
//                                    fontStyle: FontStyle.normal,
                                    ),
                                ),
                                content: Text(
                                    "You've stayed under your limit of $target calories today.\nKeep up the good work!",
                                    style: TextStyle(
                                        color: Theme
                                            .of(context)
                                            .textTheme
                                            .body1
                                            .color,
                                    ),
                                ),
                                actions: <Widget>[
                                    FlatButton(
                                        child: Text(
                                            "CLOSE",
                                            style: TextStyle(
                                                color: Theme
                                                    .of(context)
                                                    .primaryIconTheme
                                                    .color,
                                            ),
                                        ),
                                        onPressed: () {
                                            Navigator.pop(context);
                                        },
                                    )
                                ],
                            );
                        }
                    ).then((val) {
                        congrats = true;
                        prefs.setBool("SX_congratsGiven", true);
                    });
                }
            } else {
                if (prefs.containsKey("SX_congratsGiven")) {
                    congrats = prefs.getBool("SX_congratsGiven");
                    if (congrats) {
                        congrats = false;
                        prefs.setBool("SX_congratsGiven", false);
                    }
                } else {
                    prefs.setBool("SX_congratsGiven", false);
                }
            }
        }
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