class User {
  final int id;
  final String email;
  final String password_hash;
  final String firstname;
  final String lastname;
  final String address;
  final int age;
  final String occupation;
  final String contact_number;

  const User({
    required this.id,
    required this.email,
    required this.password_hash,
    required this.firstname,
    required this.lastname,
    required this.address,
    required this.age,
    required this.occupation,
    required this.contact_number,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    int id = json['id'];
    String email = json['email'];
    String password_hash = "password";
    String firstname = json['firstname'];
    String lastname = json['lastname'];
    String address = json['address'];
    int age = json['age'];
    String occupation = json['occupation'];
    String contact_number = json['mobile_number'];

    return User(
      id: id,
      email: email,
      password_hash: password_hash,
      firstname: firstname,
      lastname: lastname,
      address: address,
      age: age,
      occupation: occupation,
      contact_number: contact_number,
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
        'contact_number': contact_number,
      };
}

enum MoodId { HAPPY, SAD, CONFUSED, SCARED, ANGRY }
