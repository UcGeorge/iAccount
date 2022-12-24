import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

import '../local/database_manager.dart';

class Register extends Equatable {
  Register({
    required this.fifty,
    required this.five,
    required this.fiveHundred,
    required this.oneHundred,
    required this.oneThousand,
    required this.ten,
    required this.twenty,
    required this.twoHundred,
  })  : id = DateFormat.yMMMEd().format(DateTime.now()),
        dateModified = DateTime.now();

  factory Register.fromJson(String source) =>
      Register.fromMap(json.decode(source));

  factory Register.fromMap(Map<String, dynamic> map) {
    return Register(
      fifty: map['fifty']?.toInt() ?? 0,
      five: map['five']?.toInt() ?? 0,
      fiveHundred: map['fiveHundred']?.toInt() ?? 0,
      oneHundred: map['oneHundred']?.toInt() ?? 0,
      oneThousand: map['oneThousand']?.toInt() ?? 0,
      ten: map['ten']?.toInt() ?? 0,
      twenty: map['twenty']?.toInt() ?? 0,
      twoHundred: map['twoHundred']?.toInt() ?? 0,
    );
  }

  factory Register.zero() => Register(
        fifty: 0,
        five: 0,
        fiveHundred: 0,
        oneHundred: 0,
        oneThousand: 0,
        ten: 0,
        twenty: 0,
        twoHundred: 0,
      );

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

  int get total =>
      (oneThousand * 1000) +
      (fiveHundred * 500) +
      (twoHundred * 200) +
      (oneHundred * 100) +
      (fifty * 50) +
      (twenty * 20) +
      (ten * 10) +
      (five * 5);

  Register copyWith({
    int? fifty,
    int? five,
    int? fiveHundred,
    int? oneHundred,
    int? oneThousand,
    int? ten,
    int? twenty,
    int? twoHundred,
  }) {
    return Register(
      fifty: fifty ?? this.fifty,
      five: five ?? this.five,
      fiveHundred: fiveHundred ?? this.fiveHundred,
      oneHundred: oneHundred ?? this.oneHundred,
      oneThousand: oneThousand ?? this.oneThousand,
      ten: ten ?? this.ten,
      twenty: twenty ?? this.twenty,
      twoHundred: twoHundred ?? this.twoHundred,
    );
  }

  Register increment(Register register) {
    return Register(
      fifty: register.fifty + fifty,
      five: register.five + five,
      fiveHundred: register.fiveHundred + fiveHundred,
      oneHundred: register.oneHundred + oneHundred,
      oneThousand: register.oneThousand + oneThousand,
      ten: register.ten + ten,
      twenty: register.twenty + twenty,
      twoHundred: register.twoHundred + twoHundred,
    );
  }

  Register decrement(Register register) {
    return Register(
      fifty: fifty - register.fifty,
      five: five - register.five,
      fiveHundred: fiveHundred - register.fiveHundred,
      oneHundred: oneHundred - register.oneHundred,
      oneThousand: oneThousand - register.oneThousand,
      ten: ten - register.ten,
      twenty: twenty - register.twenty,
      twoHundred: twoHundred - register.twoHundred,
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

  static Future<void> append(
    Register register, {
    required bool take,
  }) async {
    final Register? currentRecord = await get(register.id);
    if (currentRecord == null) {
      return await insert(register);
    } else {
      return await update(take
          ? currentRecord.increment(register)
          : currentRecord.decrement(register));
    }
  }

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
