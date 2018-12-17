package com.amjadnas.compassplugin;

import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/** CompassPlugin */
public class CompassPlugin implements MethodCallHandler, EventChannel.StreamHandler, Compass.CompassListener {

  private final static String CHANNEL = "channel_compass_plugin";
  private final static String EVENTCHANNEL = "event_compass_plugin";
  private final static String INITIALIZE = "initializeCompass";
  private final static String PAUSE = "pauseCompass";
  private final static String RESUME = "resumeCompass";
  private final static String STOP = "stopCompass";

  private final Registrar mRegistrar;
  private EventChannel.EventSink mEvent;

  private Compass compass;

  /** Plugin registration. */
  public static void registerWith(Registrar registrar) {
    CompassPlugin plugin = new CompassPlugin(registrar);

    final MethodChannel mChannel = new MethodChannel(registrar.messenger(), CHANNEL);
    mChannel.setMethodCallHandler(plugin);
    final EventChannel eChannel = new EventChannel(registrar.messenger(), EVENTCHANNEL);
    eChannel.setStreamHandler(plugin);
  }

  CompassPlugin(Registrar registrar) {
    mRegistrar = registrar;
  }

  @Override
  public void onMethodCall(MethodCall methodCall, MethodChannel.Result result) {
    switch (methodCall.method){
      case INITIALIZE:
        result.success(initializeCompass());
        break;
      case PAUSE:
        result.success(pauseCompass());
        break;
      case RESUME:
        result.success(resumeCompass());
        break;
      case STOP:
        result.success(stopCompass());
        break;
    }
  }

  private boolean initializeCompass(){
    //Log.d("initializeCompass", "Called");
    compass = new Compass(mRegistrar.activity());
    compass.setListener(this);

    return true;
  }

  private boolean resumeCompass(){
    // Log.d("resumeCompass", "Called");
    // define desired delay types
    compass.start();
    return true;
  }

  private boolean pauseCompass(){
    // Log.d("pauseCompass", "Called");
    compass.stop();
    return true;
  }

  private boolean stopCompass(){
    //Log.d("stopCompass", "Called");

    compass.stop();

    return true;
  }

  @Override
  public void onListen(Object o, EventChannel.EventSink eventSink) {
    mEvent = eventSink;
    // Log.d("AZIMUTH", a+"");
  }

  @Override
  public void onCancel(Object o) {
    mEvent = null;

    compass.stop();


  }


  @Override
  public void onNewAzimuth(float azimuth) {
    if (mEvent != null)
      mEvent.success(azimuth);
  }
}
