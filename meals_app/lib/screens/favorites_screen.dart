import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/wodgets/meal_item.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Meal> meals;
  const FavoritesScreen(this.meals);

  @override
  Widget build(BuildContext context) {
    if(meals.isEmpty)
      return Center(child: Text("No favorite meals"),);
    else
      return ListView.builder(
        itemCount: meals.length,
        itemBuilder: (ctx, index) {
          return MealItem(
            id : meals[index].id,
            title: meals[index].title,
            imageUrl: meals[index].imageUrl,
            duration: meals[index].duration,
            complexity: meals[index].complexity,
            affordability: meals[index].affordability,
          );
        },
      );
  }
}
