import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
                        "Placeholder Calories",
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