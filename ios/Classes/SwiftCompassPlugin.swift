import Flutter
import UIKit
import CoreLocation

public class SwiftCompassPlugin: NSObject, FlutterPlugin, CLLocationManagerDelegate, FlutterStreamHandler {
    private var eventSink: FlutterEventSink?;
    private var location: CLLocationManager!

  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "channel_compass_plugin", binaryMessenger: registrar.messenger())
    let eventchannel = = FlutterEventChannel.init(name: "event_compass_plugin", binaryMessenger: registrar.messenger())
    let instance = SwiftCompassPlugin()
    //channel.setMethodCallHandler(instance)
    eventchannel.setStreamHandler(instance);
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  init(channel: FlutterEventChannel) {
      super.init()
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    if call.method == "initializeCompass"{
        initializeCompass()
        result(true)
    }else if call.method == "resumeCompass"{
        resumeCompass()
        result(true)
    }else if call.method == "stopCompass"{
       stopCompass()
       result(true)
    }else if call.method == "pauseCompass"{
       stopCompass()
       result(true)
    }
  }

  initializeCompass(){
    location = CLLocationManager();
    let status = CLLocationManager.authorizationStatus()
    if (status == .authorizedAlways) {
       print("status enabled")
     else {
      location.requestAlwaysAuthorization();
      location.requestWhenInUseAuthorization();
    }
    location.delegate = self
    location.headingFilter = 1;

  }

  func resumeCompass(){
    location.startUpdatingHeading();
  }

  func stopCompass(){
    location.stopUpdatingHeading();
  }

  public func onListen(withArguments arguments: Any?, eventSink: @escaping FlutterEventSink) -> FlutterError? {
      self.eventSink = eventSink;
      return nil;
  }

  public func onCancel(withArguments arguments: Any?) -> FlutterError? {
      eventSink = nil;
      location.stopUpdatingHeading();
      return nil;
  }

  public func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
      print(newHeading.magneticHeading);
      if(newHeading.headingAccuracy>0){
         let heading:CLLocationDirection!;
         heading = newHeading.trueHeading > 0 ? newHeading.trueHeading : newHeading.magneticHeading;
         eventSink!(heading);
      }
  }
}
