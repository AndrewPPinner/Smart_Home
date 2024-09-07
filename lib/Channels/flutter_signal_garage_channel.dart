import 'package:flutter/services.dart';

class FlutterSignalGarageChannel {
  static const channelName = 'signal_garage';
  late MethodChannel methodChannel;

  static final FlutterSignalGarageChannel instance =
      FlutterSignalGarageChannel._init();

  FlutterSignalGarageChannel._init();

  void configureChannel() {
    methodChannel = const MethodChannel(channelName);
    methodChannel.setMethodCallHandler(this.methodHandler);
  }

  Future<void> methodHandler(MethodCall call) async {
    switch (call.method) {
      case "signalGarage":
        break;
      default:
        print('no method handler for method ${call.method}');
    }
  }
}
