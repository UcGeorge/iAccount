import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

import '../../util/log.util.dart';
import '../models/register.dart';

class PreferenceManager {
  static late Stream<Register> cacheRegisterStream;
  static late SharedPreferences prefs;

  static final StreamController<Register> _cacheRegisterSink =
      StreamController<Register>.broadcast();

  static Register get cachedRegister => prefs.containsKey("register")
      ? Register.fromJson(prefs.getString("register")!)
      : Register.zero();

  static set cachedRegister(Register register) {
    LogUtil.log(
      "PreferenceManager",
      message: "Setting register cache: $register",
    );
    prefs.setString("register", register.toJson());
    _cacheRegisterSink.add(register);
  }

  static Future<void> init() async {
    LogUtil.log(
      "PreferenceManager",
      message: "Initializing preference manager",
    );
    prefs = await SharedPreferences.getInstance();
    cacheRegisterStream = _cacheRegisterSink.stream;
    _cacheRegisterSink.add(cachedRegister);
    LogUtil.log(
      "PreferenceManager",
      message: "Cached register: $cachedRegister",
    );
  }

  static void clearRegisterCache() {
    LogUtil.log(
      "PreferenceManager",
      message: "Clearing register cache",
    );
    cachedRegister = Register.zero();
  }

  static void dispose() {
    LogUtil.log(
      "PreferenceManager",
      message: "Disposing preference manager",
    );
    _cacheRegisterSink.close();
  }
}
