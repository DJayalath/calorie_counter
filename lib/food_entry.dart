class FoodEntry {

    String name;
    int calories;
    int quantity = 1;

    FoodEntry(String name, int calories, int quantity) {
        this.name = name;
        this.calories = calories;
        this.quantity = quantity;
    }

    int get totalCalories {
        return calories * quantity;
    }

}