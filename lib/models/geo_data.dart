import 'dart:convert';

class DataModelProperty {
  final String name;
  final LocalNames localNames;
  final double lat;
  final double lon;
  final String country;
  final String state;

  DataModelProperty({
    required this.name,
    required this.localNames,
    required this.lat,
    required this.lon,
    required this.country,
    required this.state,
  });

  factory DataModelProperty.fromJson(Map<String, dynamic> json) {
    return DataModelProperty(
      name: json['name'],
      localNames: LocalNames.fromJson(json['local_names']),
      lat: json['lat'].toDouble(),
      lon: json['lon'].toDouble(),
      country: json['country'],
      state: json['state'],
    );
  }
}

class LocalNames {
  final Map<String, String> names;

  LocalNames({required this.names});

  factory LocalNames.fromJson(Map<String, dynamic> json) {
    return LocalNames(
      names: Map<String, String>.from(json),
    );
  }

  Map<String, dynamic> toJson() {
    return names;
  }
}

List<DataModelProperty> geoData(String str) => List<DataModelProperty>.from(
      json.decode(str).map(
            (x) => DataModelProperty.fromJson(x),
          ),
    );
