class User {
  final int id;
  final String email;
  final String password_hash;
  final String firstname;
  final String lastname;
  final String address;
  final int age;
  final String occupation;

  const User({
    required this.id,
    required this.email,
    required this.password_hash,
    required this.firstname,
    required this.lastname,
    required this.address,
    required this.age,
    required this.occupation,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    print("UserData");
    print(json['id']);
    int id = json['id'];
    String email = json['email'];
    String password_hash = "password";
    String firstname = json['firstname'];
    String lastname = json['lastname'];
    String address = json['address'];
    int age = json['age'];
    String occupation = json['occupation'];

    return User(
      id: id,
      email: email,
      password_hash: password_hash,
      firstname: firstname,
      lastname: lastname,
      address: address,
      age: age,
      occupation: occupation,
    );
  }

  Map toJson() => {
        'id': id,
        'email': email,
        'password_hash': password_hash,
        'firstname': firstname,
        'lastname': lastname,
        'address': address,
        'age': age,
        'occupation': occupation,
      };
}
