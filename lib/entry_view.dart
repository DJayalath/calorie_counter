import 'package:caloriecounter/food_entry.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:convert';

import 'diary_entry.dart';
import 'food_view.dart';

class EntryView extends StatefulWidget {

    DiaryEntry diaryEntry;

    EntryView(this.diaryEntry);

    @override
    EntryViewState createState() => EntryViewState();
}

class EntryViewState extends State<EntryView> {

    Future<Null> _saveEntry() async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString(widget.diaryEntry.id, jsonEncode(widget.diaryEntry.toJson()));
    }

    Card _buildMealCard(String mealName, ThemeData themeData) {
        List<FoodEntry> meal;
        int total;
        switch (mealName) {
            case "Breakfast":
                meal = widget.diaryEntry.breakfast;
                total = widget.diaryEntry.totalBreakfast;
                break;
            case "Lunch":
                meal = widget.diaryEntry.lunch;
                total = widget.diaryEntry.totalLunch;
                break;
            case "Dinner":
                meal = widget.diaryEntry.dinner;
                total = widget.diaryEntry.totalDinner;
                break;
            case "Other":
                mealName = "Snacks";
                meal = widget.diaryEntry.other;
                total = widget.diaryEntry.totalOther;
                break;
        }

        return Card(
            margin: EdgeInsets.symmetric(vertical: 5.0),
            color: themeData.colorScheme.onPrimary,
            child: Column(
                children: <Widget>[
                    Container(
                        margin: EdgeInsets.symmetric(vertical: 10.0),
                        child: ListTile(
                            dense: true,
                            title: Text(
                                mealName,
                                style: TextStyle(
                                    color: themeData.colorScheme.primaryVariant,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                )
                            ),
                            leading: IconButton(
                                icon: Icon(
                                    Icons.add,
                                    color: Color(0xff0f3433),
                                ),
                                onPressed: () async {
                                    var result = await Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => FoodView(FoodEntry.empty())),
                                    );
                                    if (result != null) {
                                        setState(() {
                                            meal.add(result);
                                        });
                                    }
                                },
                            ),
                            trailing: Text(
                                "$total Calories",
                                style: TextStyle(
                                    color: themeData.colorScheme.primaryVariant,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                )
                            ),
                        ),
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        itemCount: meal.length,
                        itemBuilder: (BuildContext context, int index) {
                            FoodEntry foodEntry = meal.elementAt(index);
                            print(index);
                            return ListTile(
                                title: Text(
                                    "${foodEntry.name} (x${foodEntry.quantity})",
                                    style: TextStyle(
                                        color: themeData.colorScheme.primaryVariant,
                                    )
                                ),
                                subtitle: Text(
                                    "${foodEntry.totalCalories} Calories",
                                    style: TextStyle(
                                        color: Color(0xff0f3433),
                                    )
                                ),
                                trailing: IconButton(
                                    icon: Icon(
                                        Icons.delete,
                                        color: Color(0xff0f3433),
                                    ),
                                    onPressed: () {
                                        setState(() {
                                            meal.removeAt(index);
                                        });
                                    },
                                ),
                                onTap: () async {
                                    var result = await Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => FoodView(foodEntry)),
                                    );
                                    if (result != null) {
                                        setState(() {
                                            meal[index] = result;
                                        });
                                    }
                                },
                            );
                        },
                    ),
                ],
            ),
        );
    }

    @override
    Widget build(BuildContext context) {
        ThemeData themeData = Theme.of(context);
        return Scaffold(
            appBar: AppBar(
                title: Text(
                    "Diary Entry"
                ),
                actions: <Widget>[
                    FlatButton(
                        textColor: themeData.colorScheme.onBackground,
                        onPressed: () {
                            _saveEntry();
                            Navigator.pop(context);
                        },
                        child: Text(
                            "SAVE",
                        )
                    )
                ],
            ),
            body: ListView(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                children: <Widget>[
                    Container(
                        decoration: BoxDecoration(
                            color: themeData.colorScheme.onPrimary,
                            borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        ),
                        margin: EdgeInsets.symmetric(vertical: 5.0),
                        child: ListTileTheme(
                            iconColor: Theme
                                .of(context)
                                .colorScheme
                                .primaryVariant,
                            child: ListTile(
                                title: Text(
                                    widget.diaryEntry.humanReadableDate,
                                    style: TextStyle(
                                        color: Theme
                                            .of(context)
                                            .colorScheme
                                            .primaryVariant,
                                    ),
                                ),
                                trailing: Text(
                                    "${widget.diaryEntry.totalCalories} Calories",
                                    style: TextStyle(
                                        color: Color(0xff0f3433),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.0,
                                    ),
                                ),
                            ),
                        ),
                    ),
                    _buildMealCard("Breakfast", themeData),
                    _buildMealCard("Lunch", themeData),
                    _buildMealCard("Dinner", themeData),
                    _buildMealCard("Other", themeData),
                ],
            ),
        );
    }

}