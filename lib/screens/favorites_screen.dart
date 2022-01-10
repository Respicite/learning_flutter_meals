import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/widgets/meal_item.dart';

class FavoritesScreen extends StatelessWidget {
  final List favoriteMeals;

  const FavoritesScreen({Key key, this.favoriteMeals}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(favoriteMeals.isEmpty){
      return Center(
        child: Text('No Favorites yet'),
      );
    }else{
      return ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            id: favoriteMeals[index].id,
            title: favoriteMeals[index].title,
            imageUrl: favoriteMeals[index].imageUrl,
            duration: favoriteMeals[index].duration,
            affordability: favoriteMeals[index].affordability,
            complexity: favoriteMeals[index].complexity,
            removeItem: null,
          );
        },
        itemCount: favoriteMeals.length,
      );
    }

  }
}
