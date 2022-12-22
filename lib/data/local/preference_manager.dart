import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

import '../../util/log.util.dart';

class PreferenceManager {
  static late Stream<int> fiftyStream;
  static late Stream<int> fiveHundredStream;
  static late Stream<int> fiveStream;
  static late Stream<int> oneHundredStream;
  static late Stream<int> oneThousandStream;
  static late SharedPreferences prefs;
  static late Stream<int> tenStream;
  static late Stream<int> twentyStream;
  static late Stream<int> twoHundredStream;

  static final StreamController<int> _fiftySink =
      StreamController<int>.broadcast();

  static final StreamController<int> _fiveHundredSink =
      StreamController<int>.broadcast();

  static final StreamController<int> _fiveSink =
      StreamController<int>.broadcast();

  static final StreamController<int> _oneHundredSink =
      StreamController<int>.broadcast();

  static final StreamController<int> _oneThousandSink =
      StreamController<int>.broadcast();

  static final StreamController<int> _tenSink =
      StreamController<int>.broadcast();

  static final StreamController<int> _twentySink =
      StreamController<int>.broadcast();

  static final StreamController<int> _twoHundredSink =
      StreamController<int>.broadcast();

  static int get oneThousand => prefs.getInt("oneThousand") ?? 0;

  static set oneThousand(int amount) {
    LogUtil.log(
      "PreferenceManager",
      message: "Setting \$1000 to $amount",
    );
    prefs.setInt("oneThousand", amount);
    _oneThousandSink.add(amount);
  }

  static int get fiveHundred => prefs.getInt("fiveHundred") ?? 0;

  static set fiveHundred(int amount) {
    LogUtil.log(
      "PreferenceManager",
      message: "Setting \$500 to $amount",
    );
    prefs.setInt("fiveHundred", amount);
    _fiveHundredSink.add(amount);
  }

  static int get twoHundred => prefs.getInt("twoHundred") ?? 0;

  static set twoHundred(int amount) {
    LogUtil.log(
      "PreferenceManager",
      message: "Setting \$200 to $amount",
    );
    prefs.setInt("twoHundred", amount);
    _twoHundredSink.add(amount);
  }

  static int get oneHundred => prefs.getInt("oneHundred") ?? 0;

  static set oneHundred(int amount) {
    LogUtil.log(
      "PreferenceManager",
      message: "Setting \$100 to $amount",
    );
    prefs.setInt("oneHundred", amount);
    _oneHundredSink.add(amount);
  }

  static int get fifty => prefs.getInt("fifty") ?? 0;

  static set fifty(int amount) {
    LogUtil.log(
      "PreferenceManager",
      message: "Setting \$50 to $amount",
    );
    prefs.setInt("fifty", amount);
    _fiftySink.add(amount);
  }

  static int get twenty => prefs.getInt("twenty") ?? 0;

  static set twenty(int amount) {
    LogUtil.log(
      "PreferenceManager",
      message: "Setting \$20 to $amount",
    );
    prefs.setInt("twenty", amount);
    _twentySink.add(amount);
  }

  static int get ten => prefs.getInt("ten") ?? 0;

  static set ten(int amount) {
    LogUtil.log(
      "PreferenceManager",
      message: "Setting \$10 to $amount",
    );
    prefs.setInt("ten", amount);
    _tenSink.add(amount);
  }

  static int get five => prefs.getInt("five") ?? 0;

  static set five(int amount) {
    LogUtil.log(
      "PreferenceManager",
      message: "Setting \$5 to $amount",
    );
    prefs.setInt("five", amount);
    _fiveSink.add(amount);
  }

  static Future<void> init() async {
    LogUtil.log(
      "PreferenceManager",
      message: "Initializing preference manager",
    );
    prefs = await SharedPreferences.getInstance();
    oneThousandStream = _oneThousandSink.stream;
    fiveHundredStream = _fiveHundredSink.stream;
    twoHundredStream = _twoHundredSink.stream;
    oneHundredStream = _oneHundredSink.stream;
    fiftyStream = _fiftySink.stream;
    twentyStream = _twentySink.stream;
    tenStream = _tenSink.stream;
    fiveStream = _fiveSink.stream;
  }

  static void clearHolding() {
    LogUtil.log(
      "PreferenceManager",
      message: "Clearing current holdings",
    );
    oneThousand = 0;
    fiveHundred = 0;
    twoHundred = 0;
    oneHundred = 0;
    fifty = 0;
    twenty = 0;
    ten = 0;
    five = 0;
  }

  static void dispose() {
    LogUtil.log(
      "PreferenceManager",
      message: "Disposing preference manager",
    );
    _fiftySink.close();
    _fiveHundredSink.close();
    _fiveSink.close();
    _oneHundredSink.close();
    _oneThousandSink.close();
    _tenSink.close();
    _twentySink.close();
    _twoHundredSink.close();
  }
}
