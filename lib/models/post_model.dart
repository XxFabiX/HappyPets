import 'dart:io';

class Post {
  int? id; //luego se le asigna el id
  String imagePath;   //string por si es un path de File o un asset
  String name;
  String description;
  String location;
  String user; 
  String date; 
  bool liked; 

  Post({
    this.id,
    required this.imagePath,
    required this.name,
    required this.description,
    required this.location,
    required this.user,
    required this.date,
    this.liked = false,
  });

  //convertir un Post en un Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'imagePath': imagePath,
      'name': name,
      'description': description,
      'location': location,
      'user': user,
      'date': date,
      'liked': liked ? 1 : 0,
    };
  }

  //crea un POst desde un Map
  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      id: map['id'],
      imagePath: map['imagePath'],
      name: map['name'],
      description: map['description'],
      location: map['location'],
      user: map['user'],
      date: map['date'],
      liked: map['liked'] == 1,
    );
  }

  //metodo de conveniencia para imprimir objetos Post.
  @override
  String toString() {
    return 'Post{id: $id, name: $name, user: $user, imagePath: $imagePath}';
  }
}