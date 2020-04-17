import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'diary_entry.dart';

Future<List<DiaryEntry>> loadDiaryEntries() async {
    List<DiaryEntry> diaryEntries = new List();

    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Loop over all keys ignoring those that belong to settings (begin with 'SX')
    for (final k in prefs.getKeys().where((String key) => !key.contains(RegExp(r'^SX')))) {
        diaryEntries.add(DiaryEntry.fromJson(jsonDecode(prefs.get(k))));
    }

    // Sort such that most recent is displayed first
    diaryEntries.sort((b, a) => a.date.compareTo(b.date));

    return diaryEntries;
}

Future<dynamic> loadValue(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(key))
        return prefs.get(key);
    else
        return null;
}

String numberValidator(String value) {
    if(value == null) {
        return null;
    }
    final n = int.tryParse(value);
    if(n == null || n < 0) {
        return 'Not a valid number';
    }
    return null;
}