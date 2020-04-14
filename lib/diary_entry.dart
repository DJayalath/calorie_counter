import 'food_entry.dart';

class DiaryEntry {

    DateTime date = DateTime.now();

    List<FoodEntry> breakfast = new List();
    List<FoodEntry> lunch = new List();
    List<FoodEntry> dinner = new List();
    List<FoodEntry> other = new List();

    DiaryEntry();

    DiaryEntry.full({this.date, this.breakfast, this.lunch, this.dinner, this.other});

    factory DiaryEntry.fromJson(Map<String, dynamic> json) {

        var bList = json['breakfast'] as List;
        var lList = json['lunch'] as List;
        var dList = json['dinner'] as List;
        var oList = json['other'] as List;

        List<FoodEntry> breakfastList = bList.map((i) => FoodEntry.fromJson(i)).toList();
        List<FoodEntry> lunchList = lList.map((i) => FoodEntry.fromJson(i)).toList();
        List<FoodEntry> dinnerList = dList.map((i) => FoodEntry.fromJson(i)).toList();
        List<FoodEntry> otherList = oList.map((i) => FoodEntry.fromJson(i)).toList();

        return DiaryEntry.full(
            date: DateTime.fromMillisecondsSinceEpoch(int.parse(json['date'])),
            breakfast: breakfastList,
            lunch: lunchList,
            dinner: dinnerList,
            other: otherList,
        );
    }

    Map<String, dynamic> toJson() =>
        {
            'date': date.millisecondsSinceEpoch.toString(),
            'breakfast': breakfast.map((i) => i.toJson()).toList(),
            'lunch': lunch.map((i) => i.toJson()).toList(),
            'dinner': dinner.map((i) => i.toJson()).toList(),
            'other': other.map((i) => i.toJson()).toList(),
        };

    void addBreakfastItem(FoodEntry foodEntry) {
        breakfast.add(foodEntry);
    }

    void addLunchItem(FoodEntry foodEntry) {
        lunch.add(foodEntry);
    }

    void addDinnerItem(FoodEntry foodEntry) {
        dinner.add(foodEntry);
    }

    void addOtherItem(FoodEntry foodEntry) {
        other.add(foodEntry);
    }

    int get totalBreakfast {

        var total = 0;
        for (final f in breakfast) {
            total += f.totalCalories;
        }
        return total;

    }

    int get totalLunch {

        var total = 0;
        for (final f in lunch) {
            total += f.totalCalories;
        }
        return total;

    }

    int get totalDinner {

        var total = 0;
        for (final f in dinner) {
            total += f.totalCalories;
        }
        return total;

    }

    int get totalOther {

        var total = 0;
        for (final f in other) {
            total += f.totalCalories;
        }
        return total;

    }

    int get totalCalories {
        return totalBreakfast + totalLunch + totalDinner + totalOther;
    }

}