import 'package:caloriecounter/utility.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatefulWidget {
    @override
    SettingsState createState() => SettingsState();
}

class SettingsState extends State<Settings> {

    int target = 1800;

    @override
    void initState() {
        super.initState();
        _loadSettings();
    }

    Future<Null> _loadSettings() async {

        var t = await loadValue("SX_target");
        if (t != null) {
            setState(() {
                target = t;
            });
        }

    }

    Future<Null> _saveSetting(String varName, int value) async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setInt("SX_$varName", value);
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            body: ListView(
                children: <Widget>[
                    ListTile(
                        title: Text(
                            "Daily Target"
                        ),
                        subtitle: Text(
                            "$target Calories",
                        ),
                        onTap: _showDialog,
                    )
                ],
            ),
        );
    }

    TextEditingController _targetController = TextEditingController();


    final _formKey = GlobalKey<FormState>();
    _showDialog() async {
        await showDialog<String>(
            context: context,
            builder: (BuildContext context) {
                return AlertDialog(
                    contentPadding: const EdgeInsets.all(16.0),
                    content: Row(
                        children: <Widget>[
                            Expanded(
                                child: Form(
                                    key: _formKey,
                                  child: TextFormField(
                                      validator: numberValidator,
                                      autofocus: true,
                                      decoration: InputDecoration(
                                          labelText: 'Target Calories', hintText: 'eg. 2500',
                                      ),
                                      keyboardType: TextInputType.number,
                                      controller: _targetController,
                                  ),
                                ),
                            )
                        ],
                    ),
                    actions: <Widget>[
                        FlatButton(
                            child: Text(
                                'CANCEL',
                                style: TextStyle(
                                    color: Theme.of(context).iconTheme.color,
                                ),
                            ),
                            onPressed: () {
                                Navigator.pop(context);
                            }),
                        FlatButton(
                            child: Text(
                                'SAVE',
                                style: TextStyle(
                                    color: Theme.of(context).primaryIconTheme.color,
                                ),
                            ),
                            onPressed: () {
                                if (_formKey.currentState.validate()) {
                                    _saveSetting("target", int.parse(_targetController.text));
                                    setState(() {
                                        target = int.parse(_targetController.text);
                                    });
                                    Navigator.pop(context);
                                }
                            })
                    ],
                );
            }
        );
    }
}