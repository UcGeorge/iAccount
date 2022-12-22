import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../local/database_manager.dart';

class Register extends Equatable {
  const Register({
    required this.dateModified,
    required this.fifty,
    required this.five,
    required this.fiveHundred,
    required this.id,
    required this.oneHundred,
    required this.oneThousand,
    required this.ten,
    required this.twenty,
    required this.twoHundred,
  });

  factory Register.fromJson(String source) =>
      Register.fromMap(json.decode(source));

  factory Register.fromMap(Map<String, dynamic> map) {
    return Register(
      dateModified: DateTime.parse(map['dateModified']),
      fifty: map['fifty']?.toInt() ?? 0,
      five: map['five']?.toInt() ?? 0,
      fiveHundred: map['fiveHundred']?.toInt() ?? 0,
      id: map['id'] ?? '',
      oneHundred: map['oneHundred']?.toInt() ?? 0,
      oneThousand: map['oneThousand']?.toInt() ?? 0,
      ten: map['ten']?.toInt() ?? 0,
      twenty: map['twenty']?.toInt() ?? 0,
      twoHundred: map['twoHundred']?.toInt() ?? 0,
    );
  }

  final DateTime dateModified;
  final int fifty;
  final int five;
  final int fiveHundred;
  final String id;
  final int oneHundred;
  final int oneThousand;
  final int ten;
  final int twenty;
  final int twoHundred;

  @override
  List<Object> get props => [id];

  @override
  String toString() {
    return 'Register(dateModified: $dateModified, fifty: $fifty, five: $five, fiveHundred: $fiveHundred, id: $id, oneHundred: $oneHundred, oneThousand: $oneThousand, ten: $ten, twenty: $twenty, twoHundred: $twoHundred)';
  }

  Register copyWith({
    DateTime? dateModified,
    int? fifty,
    int? five,
    int? fiveHundred,
    String? id,
    int? oneHundred,
    int? oneThousand,
    int? ten,
    int? twenty,
    int? twoHundred,
  }) {
    return Register(
      dateModified: dateModified ?? this.dateModified,
      fifty: fifty ?? this.fifty,
      five: five ?? this.five,
      fiveHundred: fiveHundred ?? this.fiveHundred,
      id: id ?? this.id,
      oneHundred: oneHundred ?? this.oneHundred,
      oneThousand: oneThousand ?? this.oneThousand,
      ten: ten ?? this.ten,
      twenty: twenty ?? this.twenty,
      twoHundred: twoHundred ?? this.twoHundred,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'dateModified': dateModified.toIso8601String(),
      'fifty': fifty,
      'five': five,
      'fiveHundred': fiveHundred,
      'id': id,
      'oneHundred': oneHundred,
      'oneThousand': oneThousand,
      'ten': ten,
      'twenty': twenty,
      'twoHundred': twoHundred,
    };
  }

  String toJson() => json.encode(toMap());

  static Future<void> insert(Register register) async =>
      DatabaseManager.insert(register.toMap(), table: "register");

  static Future<void> update(Register register) async => DatabaseManager.update(
        register.id,
        table: "register",
        data: register.toMap(),
      );

  static Future<void> delete(Register register) async => DatabaseManager.delete(
        register.id,
        table: "register",
      );

  static Future<void> deleteAll() async =>
      DatabaseManager.deleteAll("register");

  static Future<Register?> get(String registerId) async {
    final Map<String, dynamic>? data = await DatabaseManager.read(
      registerId,
      table: "register",
    );
    if (data == null) return null;
    return Register.fromMap(data);
  }

  static Future<List<Register>> getAll() async =>
      (await DatabaseManager.readAll('register'))
          .map((e) => Register.fromMap(e))
          .toList();
}
