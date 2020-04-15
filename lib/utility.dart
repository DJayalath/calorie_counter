import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'diary_entry.dart';

Future<List<DiaryEntry>> loadDiaryEntries() async {
    List<DiaryEntry> diaryEntries = new List();

    SharedPreferences prefs = await SharedPreferences.getInstance();

    for (final k in prefs.getKeys()) {
        diaryEntries.add(DiaryEntry.fromJson(jsonDecode(prefs.get(k))));
    }

    // Sort such that most recent is displayed first
    diaryEntries.sort((b, a) => a.date.compareTo(b.date));

    return diaryEntries;
}