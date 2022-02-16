import 'package:flutter/material.dart';
import '../models/meal.dart';

class MealDetailScreens extends StatelessWidget {
final Function(Meal) onToggleFavorite;
final bool Function(Meal) isFavorite;

  const MealDetailScreens(this.onToggleFavorite, this.isFavorite);

  Widget _createSectionTitle(BuildContext context, String title) {
    //Método que retorna um Widget
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }

  Widget _createSectionContainer(Widget child) {
    return Container(
        width: 300,
        height: 200,
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        child: child);
  }

  @override
  Widget build(BuildContext context) {
    final meal = ModalRoute.of(context)!.settings.arguments as Meal;

    return Scaffold(
        appBar: AppBar(
          title: Text(meal.title),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 250,
                width: double.infinity,
                child: Image.network(
                  meal.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
              _createSectionTitle(context,
                  'ingredientes'), //Método sendo passado para reutilização do código
              _createSectionContainer(
                //Método sendo passado para reutilização do código
                ListView.builder(
                    itemCount: meal.ingredients.length,
                    itemBuilder: (ctx, index) {
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: 10,
                          ),
                          child: Text(meal.ingredients[index]),
                        ),
                        color: Theme.of(context).colorScheme.secondary,
                      );
                    }),
              ),
              _createSectionTitle(context, 'Passos'),
              _createSectionContainer(
                ListView.builder(
                    itemCount: meal.steps.length,
                    itemBuilder: (ctx, index) {
                      return Column(
                        children: [
                          ListTile(
                           leading: CircleAvatar(
                            child: Text('${index + 1}'),
                           ),
                           title: Text(meal.steps[index]),
                          ),
                         const Divider(),
                        ],
                      );
                    }),
              )
            ],
            
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(isFavorite(meal) ? Icons.star : Icons.star_border),
          onPressed: (){
            onToggleFavorite(meal);
          }
           ),
        );
  }
}
