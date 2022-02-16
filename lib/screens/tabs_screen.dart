import 'package:flutter/material.dart';
import 'favorite_screen.dart';
import 'categories_screen.dart';
import '../components/main_drawer.dart';
import '../models/meal.dart';

class TabsScreen extends StatefulWidget {
  final List<Meal> favoriteMeals;

  const TabsScreen(this.favoriteMeals);

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedScreenIndex = 0;
  List<String> _titles = [];
  List<Widget> _screens = [];

  @override
  void initState() {
    super.initState();
    _titles = [
      'Lista de Categorias',
      'Meus Favoritos',
    ];
    _screens = [
      CategoriesScreen(),
      FavoriteScreen(widget.favoriteMeals),
    ];
  }

  _selectScreen(int index) {
    setState(() {
      _selectedScreenIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(_titles[_selectedScreenIndex]),
        ),
        drawer: const Drawer(
          child: MainDrawer(),
        ),
        body: _screens[_selectedScreenIndex],
        bottomNavigationBar: BottomNavigationBar(
          onTap: _selectScreen,
          backgroundColor: Theme.of(context).colorScheme.primary,
          unselectedItemColor: Colors.white,
          selectedItemColor: Theme.of(context).colorScheme.secondary,
          currentIndex: _selectedScreenIndex,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.category), label: 'Categorias'),
            BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favoritos'),
          ],
        ));
  }
}
