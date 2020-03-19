class UpdateUser {
  String firstName;
  String lastName;
  String email;

  UpdateUser(this.firstName, this.lastName, this.email);

  @override
  String toString() {
    return 'UpdateUser{firstName: $firstName, lastName: $lastName, email: $email}';
  }

  UpdateUser.getUser(UpdateUser user) {
    this.firstName = user.firstName;
    this.lastName = user.lastName;
    this.email = user.email;
  }

}