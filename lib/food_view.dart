import 'package:caloriecounter/food_entry.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FoodView extends StatefulWidget {

    FoodEntry foodEntry;

    FoodView(this.foodEntry);

    @override
    FoodViewState createState() => FoodViewState();
}

class FoodViewState extends State<FoodView> {

    TextEditingController _nameController;
    TextEditingController _calController;

    @override
    void initState() {
        super.initState();
        _nameController = new TextEditingController(text: widget.foodEntry.name);
        _calController = new TextEditingController(text: widget.foodEntry.calories.toString());
    }


    @override
    Widget build(BuildContext context) {
        ThemeData themeData = Theme.of(context);
        return Scaffold(
            appBar: AppBar(
                title: Text(
                    "Food Entry"
                ),
                actions: <Widget>[
                    FlatButton(
                        textColor: themeData.primaryIconTheme.color,
                        onPressed: () {
                            widget.foodEntry.name = _nameController.text;

                            // TODO: Sanitise input
                            widget.foodEntry.calories = int.parse(_calController.text);

                            Navigator.pop(context, widget.foodEntry);
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
                        margin: EdgeInsets.symmetric(vertical: 5.0),
                        decoration: BoxDecoration(
                            color: Theme.of(context).backgroundColor,
                            borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        ),
                        child: ListTile(
                            title: TextField(
                                controller: _nameController,
                                decoration: InputDecoration(
                                    hintText: 'Name',
                                ),
                            ),
                        ),
                    ),
                    Container(
                        margin: EdgeInsets.symmetric(vertical: 5.0),
                        decoration: BoxDecoration(
                            color: Theme.of(context).backgroundColor,
                            borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        ),
                        child: ListTile(
                            leading: Align(
                                widthFactor: 1.0,
                                alignment: Alignment.centerLeft,
                              child: Text(
                                  "Calories",
                                  style: TextStyle(
                                      color: Theme.of(context).textTheme.subtitle.color,
                                      fontSize: 16.0,
                                  ),
                              ),
                            ),
                            title: TextField(
                                controller: _calController,
                                decoration: InputDecoration(
                                    hintText: 'Calories',
                                ),
                            ),
                        ),
                    ),
                    Container(
                        margin: EdgeInsets.symmetric(vertical: 5.0),
                        decoration: BoxDecoration(
                            color: Theme.of(context).backgroundColor,
                            borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        ),
                        child: ListTile(
                            leading: IconButton(
                                icon: Icon(
                                    Icons.remove,
                                    color: Color(0xff0f3433),
                                ),
                                onPressed: () {
                                    setState(() {
                                        if (widget.foodEntry.quantity > 1) {
                                            widget.foodEntry.quantity -= 1;
                                        }
                                    });
                                },
                            ),
                            trailing: IconButton(
                                icon: Icon(
                                    Icons.add,
                                    color: Color(0xff0f3433),
                                ),
                                onPressed: () {
                                    setState(() {
                                        widget.foodEntry.quantity += 1;
                                    });
                                },
                            ),
                            title: Center(
                                child: Text(
                                    "Quantity: ${widget.foodEntry.quantity}",
                                ),
                            )
                        ),
                    )
                ],
            ),
        );
    }

}