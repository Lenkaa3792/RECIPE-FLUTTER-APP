import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class Recipe {
  final String title;
  final String description;
  final String imageUrl;

  Recipe(this.title, this.description, this.imageUrl);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RecipeList(),
    );
  }
}

class RecipeList extends StatefulWidget {
  @override
  _RecipeListState createState() => _RecipeListState();
}

class _RecipeListState extends State<RecipeList> {
  List<Recipe> recipes = [
    Recipe(
      'Pasta',
      'Italian dish with tomato sauce and cheese',
      'https://source.unsplash.com/400x200/?pasta',
    ),
    Recipe(
      'Salad',
      'Healthy mix of vegetables with dressing',
      'https://source.unsplash.com/400x200/?salad',
    ),
    Recipe(
      'Smoothie',
      'Refreshing fruit smoothie',
      'https://source.unsplash.com/400x200/?smoothie',
    ),
    Recipe(
      'Burger',
      'Classic beef burger with cheese and vegetables',
      'https://source.unsplash.com/400x200/?burger',
    ),
    Recipe(
      'Pizza',
      'Delicious pizza with assorted toppings',
      'https://source.unsplash.com/400x200/?pizza',
    ),
    Recipe(
      'Meat',
      'Beef or mutton',
      'https://tinyurl.com/bdztecjj',
    ),
    Recipe(
      'Tacos',
      'Mexican street-style tacos with meat and salsa',
      'https://source.unsplash.com/400x200/?tacos',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recipe App'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _addNewRecipe();
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: recipes.length,
        itemBuilder: (context, index) {
          return RecipeCard(
            recipe: recipes[index],
            onEdit: () {
              _editRecipe(index);
            },
            onDelete: () {
              _deleteRecipe(index);
            },
          );
        },
      ),
    );
  }

  void _addNewRecipe() async {
    Recipe? newRecipe = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RecipeEditScreen()),
    );

    if (newRecipe != null) {
      setState(() {
        recipes.add(newRecipe);
      });
    }
  }

  void _editRecipe(int index) async {
    Recipe? editedRecipe = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RecipeEditScreen(editingRecipe: recipes[index]),
      ),
    );

    if (editedRecipe != null) {
      setState(() {
        recipes[index] = editedRecipe;
      });
    }
  }

  void _deleteRecipe(int index) async {
    bool? confirmDelete = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirm Delete'),
        content: Text('Are you sure you want to delete this recipe?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context, false); // Cancel
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context, true); // Confirm
            },
            child: Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmDelete == true) {
      setState(() {
        recipes.removeAt(index);
      });
    }
  }
}

class RecipeCard extends StatelessWidget {
  final Recipe recipe;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  RecipeCard({
    required this.recipe,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: Column(
        children: [
          ListTile(
            title: Text(recipe.title),
            subtitle: Text(recipe.description),
            leading: Image.network(
              recipe.imageUrl,
              width: 80.0,
              height: 80.0,
              fit: BoxFit.cover,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RecipeDetails(recipe),
                ),
              );
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: onEdit,
              ),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: onDelete,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class RecipeDetails extends StatelessWidget {
  final Recipe recipe;

  RecipeDetails(this.recipe);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recipe.title),
      ),
      body: Column(
        children: [
          Image.network(
            recipe.imageUrl,
            width: double.infinity,
            height: 200.0,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(recipe.description),
          ),
        ],
      ),
    );
  }
}

class RecipeEditScreen extends StatefulWidget {
  final Recipe? editingRecipe;

  RecipeEditScreen({this.editingRecipe});

  @override
  _RecipeEditScreenState createState() => _RecipeEditScreenState();
}

class _RecipeEditScreenState extends State<RecipeEditScreen> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  late TextEditingController imageUrlController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.editingRecipe?.title ?? '');
    descriptionController = TextEditingController(text: widget.editingRecipe?.description ?? '');
    imageUrlController = TextEditingController(text: widget.editingRecipe?.imageUrl ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.editingRecipe == null ? 'Add Recipe' : 'Edit Recipe'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            TextField(
              controller: imageUrlController,
              decoration: InputDecoration(labelText: 'Image URL'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Validate and save the recipe
                if (_validate()) {
                  Recipe editedRecipe = Recipe(
                    titleController.text,
                    descriptionController.text,
                    imageUrlController.text,
                  );

                  Navigator.pop(context, editedRecipe);
                }
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  bool _validate() {
    if (titleController.text.isEmpty ||
        descriptionController.text.isEmpty ||
        imageUrlController.text.isEmpty) {
      // Show error message or handle validation as needed
      return false;
    }
    return true;
  }
}
