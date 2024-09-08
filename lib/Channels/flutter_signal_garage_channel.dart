import 'package:aa_smart_home/Services/api_service.dart';
import 'package:flutter/services.dart';

class FlutterSignalGarageChannel {
  static const channelName = 'signal_garage';
  late MethodChannel methodChannel;
  static final _apiService = APIService();

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
        print("Method Called");
        await _apiService.signalGarage();
        break;
      default:
        print('no method handler for method ${call.method}');
    }
  }
}
