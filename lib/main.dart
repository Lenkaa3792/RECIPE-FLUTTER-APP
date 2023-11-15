import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RecipeList(),
    );
  }
}

class RecipeList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recipe App'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Recipes in our lists',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          RecipeCard(
            'Pasta',
            'Italian dish with tomato sauce and cheese',
            'https://source.unsplash.com/400x200/?pasta',
          ),
          RecipeCard(
            'Salad',
            'Healthy mix of vegetables with dressing',
            'https://source.unsplash.com/400x200/?salad',
          ),
          RecipeCard(
            'Smoothie',
            'Refreshing fruit smoothie',
            'https://source.unsplash.com/400x200/?smoothie',
          ),
          RecipeCard(
            'Burger',
            'Classic beef burger with cheese and vegetables',
            'https://source.unsplash.com/400x200/?burger',
          ),
          RecipeCard(
            'Pizza',
            'Delicious pizza with assorted toppings',
            'https://source.unsplash.com/400x200/?pizza',
          ),
          RecipeCard(
            'Meat',
            'Beef or mutton',
            'https://tinyurl.com/bdztecjj',
          ),
          RecipeCard(
            'Tacos',
            'Mexican street-style tacos with meat and salsa',
            'https://source.unsplash.com/400x200/?tacos',
          )
        ],
      ),
    );
  }
}

class RecipeCard extends StatelessWidget {
  final String title;
  final String description;
  final String imageUrl;

  RecipeCard(this.title, this.description, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: ListTile(
        title: Text(title),
        subtitle: Text(description),
        leading: Image.network(
          imageUrl,
          width: 80.0,
          height: 80.0,
          fit: BoxFit.cover,
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RecipeDetails(title, description, imageUrl),
            ),
          );
        },
      ),
    );
  }
}

class RecipeDetails extends StatelessWidget {
  final String title;
  final String description;
  final String imageUrl;

  RecipeDetails(this.title, this.description, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Column(
        children: [
          Image.network(
            imageUrl,
            width: double.infinity,
            height: 200.0,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(description),
          ),
        ],
      ),
    );
  }
}