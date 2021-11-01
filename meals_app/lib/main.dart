import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/categories_screen.dart';
import 'package:meals_app/screens/category_meals_screen.dart';
import 'package:meals_app/screens/filters_screen.dart';
import 'package:meals_app/screens/meal_detail_screen.dart';
import 'package:meals_app/screens/tabs_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> filters = {
    'gluten': false,
    'lactose': false,
    'vegetarian': false,
    'vegan': false,
  };

  List<Meal> availableMeals = DUMMY_MEALS;
  List<Meal> favoriteMeals = [];

  void _toggleFavorite(String mealId){
    final existIndex = favoriteMeals.indexWhere((element) => element.id == mealId);
    if(existIndex>=0){
      setState(() {
        favoriteMeals.removeAt(existIndex);
      });
    }else{
      setState(() {
        favoriteMeals.add(DUMMY_MEALS.firstWhere((element) => element.id == mealId));
      });
    }
  }

  bool isMealFavorite(String id){
    return favoriteMeals.any((element) => id == element.id);
  }

  void _setFilters(Map<String, bool> filteredData){
    setState(() {
      filters = filteredData;
      availableMeals = DUMMY_MEALS.where((element){
        if(filters['gluten']! && !element.isGlutenFree)
          return false;
        if(filters['lactose']! && !element.isLactoseFree)
          return false;
        if(filters['vegan']! && !element.isVegan)
          return false;
        if(filters['vegetarian']! && !element.isVegetarian)
          return false;

        return true;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.pink,
          accentColor: Colors.amber,
          canvasColor: Color.fromRGBO(255, 254, 229, 1),
          fontFamily: "Raleway",
          textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: TextStyle(
                color: Color.fromRGBO(25, 51, 51, 1),
              ),
              bodyText2: TextStyle(
                color: Color.fromRGBO(25, 51, 51, 1),
              ),
              headline6: TextStyle(
                fontSize: 20,
                fontFamily: "RobotoCondensed",
                fontWeight: FontWeight.bold,
              ))),
      //home: CategoriesScreen(),
      initialRoute: '/',
      //default
      routes: {
        '/': (ctx) => TabsScreen(favoriteMeals), //CategoriesScreen(),
        CategoryMealsScreen.routeName: (ctx) => CategoryMealsScreen(availableMeals),
        MealDetailScreen.routeName: (ctx) => MealDetailScreen(_toggleFavorite, isMealFavorite),
        FiltersScreen.routeName: (ctx) => FiltersScreen(_setFilters, filters),
      },
      onGenerateRoute: (settings) {
        //when we use an unregistered route, useful for dynamic route based on settings
        return MaterialPageRoute(builder: (ctx) => CategoryMealsScreen(availableMeals));
      },
      onUnknownRoute: (settings) {
        //when flutter failed return a screen (no route & no onGenericRoute)
        return MaterialPageRoute(builder: (ctx) => CategoryMealsScreen(availableMeals));
      },
    );
  }
}
