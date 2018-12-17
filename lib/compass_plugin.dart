import 'dart:async';

import 'package:flutter/services.dart';

class CompassPlugin {
  static const _CHANNEL = 'channel_compass_plugin';
  static const _EVENTCHANNEL = 'event_compass_plugin';
  static const _INITIALIZE = 'initializeCompass';
  static const _PAUSE = 'pauseCompass';
  static const _RESUME = 'resumeCompass';
  static const _STOP = 'stopCompass';

  static const _eventChannel = const EventChannel(_EVENTCHANNEL);
  static const _methodChannel = const MethodChannel(_CHANNEL);

  static Stream<double> _azimuthStream;

  static get initCompassListener async{
    await _methodChannel.invokeMethod(_INITIALIZE);
    await _methodChannel.invokeMethod(_RESUME);

  }

  static get pauseCompassListener{
    //print("pause");
    _methodChannel.invokeMethod(_PAUSE);
  }

  static Stream<double> get getAzimuth {
    if(_azimuthStream == null)
        _azimuthStream = _eventChannel.receiveBroadcastStream().map((dynamic val) {
          return val as double;
        });
    return _azimuthStream;
  }

  static get resumeCompassListener{
    //print("resume");
    _methodChannel.invokeMethod(_RESUME);
  }

  static get stopCompassListener{
    //print("resume");
    _methodChannel.invokeMethod(_STOP);
  }
}
