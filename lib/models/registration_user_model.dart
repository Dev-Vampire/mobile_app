class RegistrationUser {
  String name;
  String password;
  int birthYear;
  int birthMonth;
  int birthDate;
  int birthHour;
  int birthMinute;
  String sign;

  RegistrationUser(
      {this.name,
      this.password,
      this.birthYear,
      this.birthMonth,
      this.birthDate,
      this.birthHour,
      this.sign,
      this.birthMinute});

  RegistrationUser.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    password = json['password'];
    birthYear = json['birthYear'];
    birthMonth = json['birthMonth'];
    birthDate = json['birthDate'];
    birthHour = json['birthHour'];
    birthMinute = json['birthMinute'];
    sign = json['sign'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['password'] = this.password;
    data['birthYear'] = this.birthYear;
    data['birthMonth'] = this.birthMonth;
    data['birthDate'] = this.birthDate;
    data['birthHour'] = this.birthHour;
    data['birthMinute'] = this.birthMinute;
    return data;
  }
}
