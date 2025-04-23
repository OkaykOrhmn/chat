class MeModel {
  String? id;
  String? username;
  String? firstName;
  String? lastName;
  String? email;
  String? phomeNumber;
  String? profileImage;
  String? lastActive;
  bool? ghostMode;
  String? bio;
  int? stars;
  String? status;
  bool? isVerified;
  String? createdAt;
  String? updatedAt;

  MeModel(
      {this.id,
      this.username,
      this.firstName,
      this.lastName,
      this.email,
      this.phomeNumber,
      this.profileImage,
      this.lastActive,
      this.ghostMode,
      this.bio,
      this.stars,
      this.status,
      this.isVerified,
      this.createdAt,
      this.updatedAt});

  MeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    phomeNumber = json['phomeNumber'];
    profileImage = json['profileImage'];
    lastActive = json['lastActive'];
    ghostMode = json['ghostMode'];
    bio = json['bio'];
    stars = json['stars'];
    status = json['status'];
    isVerified = json['isVerified'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['username'] = username;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['email'] = email;
    data['phomeNumber'] = phomeNumber;
    data['profileImage'] = profileImage;
    data['lastActive'] = lastActive;
    data['ghostMode'] = ghostMode;
    data['bio'] = bio;
    data['stars'] = stars;
    data['status'] = status;
    data['isVerified'] = isVerified;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }

  MeModel copyWith({
    String? id,
    String? username,
    String? firstName,
    String? lastName,
    String? email,
    String? phomeNumber,
    String? profileImage,
    String? lastActive,
    bool? ghostMode,
    String? bio,
    int? stars,
    String? status,
    bool? isVerified,
    String? createdAt,
    String? updatedAt,
  }) {
    return MeModel(
      id: id ?? this.id,
      username: username ?? this.username,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phomeNumber: phomeNumber ?? this.phomeNumber,
      profileImage: profileImage ?? this.profileImage,
      lastActive: lastActive ?? this.lastActive,
      ghostMode: ghostMode ?? this.ghostMode,
      bio: bio ?? this.bio,
      stars: stars ?? this.stars,
      status: status ?? this.status,
      isVerified: isVerified ?? this.isVerified,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
