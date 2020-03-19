
class Users {
   int id;
   String firstName;
   String lastName;
   String email;
   String token;
   bool isAdmin;
   bool isSuperAdmin;
   bool isActive;

  // ignore: non_constant_identifier_names
  Users(this.id, this.firstName, this.lastName, this.email, this.token,
      {this.isActive, this.isAdmin, this.isSuperAdmin});

  static Users getUserFromJson(dynamic json) {
    int id = json['id'];
    String firstName = json['first_name'];
    String lastName = json['last_name'];
    String email = json['email'];
    String token = json['token'];
    bool isAdmin = json['is_admin'];
    bool isSuperAdmin = json['is_super_admin'];
    bool isActive = json['is_active'];

    return Users(id, firstName, lastName, email, token,
        isAdmin: isAdmin, isActive: isActive, isSuperAdmin: isSuperAdmin);
  }

  @override
  String toString() {
    return 'Users{id: $id, first_name: $firstName, last_name: $lastName, email: $email, token: $token}';
  }
}
