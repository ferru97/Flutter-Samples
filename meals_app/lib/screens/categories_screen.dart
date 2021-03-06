
import 'package:flutter/material.dart';
import '../data/dummy_data.dart';
import '../wodgets/category_item.dart';

class CategoriesScreen extends StatelessWidget {
  

  const CategoriesScreen();

  @override
  Widget build(BuildContext context) {
    return GridView(
        padding: const EdgeInsets.all(25),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 3/2, //on 200w, set 300h (200*1.5)
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        children: DUMMY_CATEGORIES.map((e){
          return CategoryItem(e.id, e.title, e.color,);
        }).toList(),
      );
  }
}
