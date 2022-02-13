import 'oil_domain.dart';

class Oil {
  String? id;
  String name;
  List<String?>? otherNames;
  String? sciName;
  String? distilledOrgan;
  String? extractionProcess;
  List<String?>? allergies;
  List<String?>? color;
  List<String?>? aspect;
  List<String?>? smell;
  OilDomain? health;
  OilDomain? beauty;
  OilDomain? wellBeing;

  Oil(
      {required this.id,
      required this.name,
      required this.otherNames,
      this.sciName,
      this.distilledOrgan,
      this.extractionProcess,
      this.allergies,
      this.color,
      this.aspect,
      this.smell,
      this.health,
      this.beauty,
      this.wellBeing});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'otherNames': otherNames,
      'sciName': sciName,
      'distilledOrgan': distilledOrgan,
      'extractionProcess': extractionProcess,
      'allergies': allergies,
      'color': color,
      'aspect': aspect,
      'smell': smell,
      //TODO:: add the other properties when push to database
    };
  }

  factory Oil.fromMap(Map<String, dynamic>? data, String documentID) {
    String name = data!['name'].toString();
    String? sciName = data['sciName'];
    List<String?>? otherNames = List<String?>.from(data['otherNames']);
    String? distilledOrgan = data['distilledOrgan'];

    String? extractionProcess = data['extractionProcess'];
    List<String?>? allergies = List<String?>.from(data['allergies']);
    List<String?>? color = List<String?>.from(data['color']);
    List<String?>? aspect = List<String?>.from(data['aspect']);
    List<String?>? smell = List<String?>.from(data['smell']);

    OilDomain? health =
        data['health'] != null ? OilDomain.fromMap(data['health']) : null;
    OilDomain? beauty =
        data['beauty'] != null ? OilDomain.fromMap(data['beauty']) : null;
    OilDomain? wellBeing =
        data['wellBeing'] != null ? OilDomain.fromMap(data['wellBeing']) : null;

    return Oil(
        id: documentID,
        name: name,
        sciName: sciName,
        otherNames: otherNames,
        distilledOrgan: distilledOrgan,
        extractionProcess: extractionProcess,
        allergies: allergies,
        color: color,
        aspect: aspect,
        smell: smell,
        health: health,
        beauty: beauty,
        wellBeing: wellBeing);
  }

  @override
  String toString() {
    return 'id: $id, name: $name';
  }
}
