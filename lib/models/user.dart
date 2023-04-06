class User {
  int? id;
  String? nom;
  String? prenom;
  String? email;
  String? image;
  String? token;

  User({this.id, this.nom, this.prenom, this.image, this.email, this.token});
  factory User.fromJson(Map<String, dynamic> json){
    return User(
      id: json['user']['id'],
      nom: json['user']['nom'],
      prenom: json['user']['prenom'],
      email: json['user']['email'],
      image: json['user']['image'],
      token: json['token']
    );
  }

}
