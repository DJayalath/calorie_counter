import 'food_entry.dart';

class DiaryEntry {

    DateTime date = DateTime.now();

    List<FoodEntry> breakfast = new List();
    List<FoodEntry> lunch = new List();
    List<FoodEntry> dinner = new List();
    List<FoodEntry> other = new List();

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