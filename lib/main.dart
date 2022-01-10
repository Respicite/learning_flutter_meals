import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/dummy_data.dart';

import './screens/tabs_screen.dart';
import './screens/meal_detail_screen.dart';
import './screens/category_meals_screen.dart';
import './screens/filters_screen.dart';
import './screens/categories_screen.dart';
import 'models/meal.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map filters = {
    'glutenfree': false,
    'vegetarian': false,
    'vegan': false,
    'lactosefree': false
  };

  List availableMeals = DUMMY_MEALS;
  List<Meal> favoriteMeals = [];

  void toggleFavorite(String mealId) {
    final index = favoriteMeals.indexWhere((meal) => meal.id == mealId);
    print(index.toString());
    if (index == -1) {
      setState(() {
        print(favoriteMeals.length);
        Meal fm = DUMMY_MEALS.firstWhere((meal) => meal.id == mealId);
        favoriteMeals.add(fm);
        print(favoriteMeals.length);
      });
    } else {
      setState(() {
        favoriteMeals.removeAt(index);
      });
    }
  }

  bool isMealFavorite(String mealId) {
    print(
        '$mealId is favorite - ${favoriteMeals.any((meal) => meal.id == mealId).toString()}');
    return favoriteMeals.any((meal) => meal.id == mealId);
  }

  void _setFilters(Map filterData) {
    setState(() {
      filters = filterData;
      availableMeals = DUMMY_MEALS.where((meal) {
        if (filters['glutenfree'] == true && meal.isGlutenFree == false) {
          return false;
        }
        if (filters['vegetarian'] == true && meal.isVegetarian == false) {
          return false;
        }
        if (filters['vegan'] == true && meal.isVegan == false) {
          return false;
        }
        if (filters['lactosefree'] == true && meal.isLactoseFree == false) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
            bodyText1: TextStyle(
              color: Color.fromRGBO(20, 51, 51, 1),
            ),
            bodyText2: TextStyle(
              color: Color.fromRGBO(20, 51, 51, 1),
            ),
            subtitle1: TextStyle(
              fontSize: 20,
              fontFamily: 'RobotoCondensed',
              fontWeight: FontWeight.bold,
            )),
      ),
      // home: CategoriesScreen(),
      initialRoute: '/',
      // default is '/'
      routes: {
        '/': (ctx) => TabsScreen(favoriteMeals: favoriteMeals),
        CategoryMealsScreen.routeName: (ctx) =>
            CategoryMealsScreen(meals: availableMeals),
        MealDetailScreen.routeName: (ctx) => MealDetailScreen(
            toggleFavorite: toggleFavorite, isMealFavorite: isMealFavorite),
        FiltersScreen.routeName: (ctx) =>
            FiltersScreen(filterfunction: _setFilters, filters: filters),
      },
      onGenerateRoute: (settings) {
        print(settings.arguments);
        // if (settings.name == '/meal-detail') {
        //   return ...;
        // } else if (settings.name == '/something-else') {
        //   return ...;
        // }
        // return MaterialPageRoute(builder: (ctx) => CategoriesScreen(),);
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (ctx) => CategoriesScreen(),
        );
      },
    );
  }
}
