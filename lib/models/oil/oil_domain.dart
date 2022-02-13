class OilDomain {
  String? properties;
  String? precautionOfUse;
  String? areaOfUse;
  String? practicalUse;
  String? synergy;

  OilDomain({
    this.properties,
    this.precautionOfUse,
    this.areaOfUse,
    this.practicalUse,
    this.synergy,
  });

  Map<String, dynamic> toMap() {
    return {
      'properties': properties,
      'precautionOfUse': precautionOfUse,
      'areaOfUse': areaOfUse,
      'practicalUse': practicalUse,
      'synergy': synergy,
    };
  }

  factory OilDomain.fromMap(Map<String, dynamic> data) {
    String? properties = data['properties'];
    String? precautionOfUse = data['precautionOfUse'];
    String? practicalUse = data['practicalUse'];
    String? areaOfUse = data['areaOfUse'];
    String? synergy = data['synergy'];

    return OilDomain(
      properties: properties,
      precautionOfUse: precautionOfUse,
      practicalUse: practicalUse,
      areaOfUse: areaOfUse,
      synergy: synergy,
    );
  }

  @override
  String toString() {
    return 'properties: $properties, precautionOfUse: $precautionOfUse, practicalUse: $practicalUse , areaOfUse: $areaOfUse, synergy: $synergy';
  }
}
