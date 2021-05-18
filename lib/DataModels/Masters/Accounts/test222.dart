import 'dart:convert';

class User {
  String name;
  int age;
  String secondName;
  User({
    this.name,
    this.age,
    this.secondName,
  });
  

  User copyWith({
    String name,
    int age,
    String secondName,
  }) {
    return User(
      name: name ?? this.name,
      age: age ?? this.age,
      secondName: secondName ?? this.secondName,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'age': age,
      'secondName': secondName,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return User(
      name: map['name'],
      age: map['age'],
      secondName: map['secondName'],
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() => 'User(name: $name, age: $age, secondName: $secondName)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is User &&
      o.name == name &&
      o.age == age &&
      o.secondName == secondName;
  }

  @override
  int get hashCode => name.hashCode ^ age.hashCode ^ secondName.hashCode;
}
