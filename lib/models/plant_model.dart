class Plant_Model {
  String? image;
  String? name;
  String? docID;
  String? description;
  String? accest;
  bool? active;
  Location? location;

  Plant_Model({
    this.image,
    this.docID,
    this.name,
    this.description,
    this.location,
    this.accest,
  });

  Plant_Model.fromJson(Map<String, dynamic> json) {
    image = json['image'] as String?;
    docID = json['docID'] as String?;
    name = json['name'] as String?;
    active = json['active'] as bool?;
    description = json['description'] as String?;
    accest = json['accest'] as String?;
    location = Location.fromJson(json['location']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {
      'image': image,
      'docID': docID,
      'name': name,
      'active': active,
      'description': description,
      'accest': accest,
      'location': location,
    };
    return map;
  }
}
class Location {
  String? Lan;
  String? Lat;


  Location({
    this.Lan,
    this.Lat,
  });

  Location.fromJson(Map<String, dynamic> json) {
    Lan = json['Lan'] as String?;
    Lat = json['Lat'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {
      'Lan': Lan,
      'Lat': Lat,
    };
    return map;
  }
}
