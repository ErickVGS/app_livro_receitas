import 'package:flutter/material.dart';
import 'package:meals/models/settings.dart';
import 'screens/settings_screen.dart';
import 'screens/categories_meals_screens.dart';
import 'utils/app-routes.dart';
import 'screens/meal_deteail_screens.dart';
import 'screens/tabs_screen.dart';
import 'models/meal.dart';
import 'data/dummy_data.dart';
import 'models/settings.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  Settings settings = Settings();
  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favoriteMeals = [];

  void _filterMeals(Settings settings) {
    setState(() {
      _availableMeals = DUMMY_MEALS.where((meal) {
        final filterGluten = settings.isGlutenFree && !meal.isGlutenFree;
        final filterLactose = settings.isLactoseFree && !meal.isLactoseFree;
        final filterVegan = settings.isVegan && !meal.isVegan;
        final filterVegetarian = settings.isVegetarian && !meal.isVegetarian;
        return !filterGluten && !filterLactose && !filterVegan && !filterVegetarian;
      }).toList();
    });
  }

  void _toogleFavorite (Meal meal){
    setState(() {
      _favoriteMeals.contains(meal) 
      ? _favoriteMeals.remove(meal)
      : _favoriteMeals.add(meal);
    });
  }

  bool _isFavorite (Meal meal){
    return _favoriteMeals.contains(meal);
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vamos Cozinhar?',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.pink)
              .copyWith(secondary: Colors.amber),
          fontFamily: 'Raleway',
          canvasColor: const Color.fromRGBO(255, 254, 229, 1),
          textTheme: ThemeData.light().textTheme.copyWith(
              headline6: const TextStyle(
                  fontSize: 20, fontFamily: 'RobotoCondensed'))),
      routes: {
        
        AppRoutes.HOME: (ctx) => TabsScreen(_favoriteMeals),
        AppRoutes.CATEGORIES_MEALS: (ctx) =>
        CategoriesMealsScreen(_availableMeals),
        AppRoutes.MEAL_DETAIL: (ctx) => MealDetailScreens(_toogleFavorite, _isFavorite),
        AppRoutes.SETTINGS: (ctx) => SettingScreen(_filterMeals, settings),
      },
    );
  }
}
