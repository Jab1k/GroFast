import 'dart:convert';

List<String?>? hammasiniOlFromJson(String str) => json.decode(str) == null
    ? []
    : List<String?>.from(json.decode(str)!.map((x) => x));

String hammasiniOlToJson(List<String?>? data) =>
    json.encode(data == null ? [] : List<dynamic>.from(data.map((x) => x)));
