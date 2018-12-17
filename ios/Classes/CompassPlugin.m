#import "CompassPlugin.h"
#import <compass_plugin/compass_plugin-Swift.h>

@implementation CompassPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftCompassPlugin registerWithRegistrar:registrar];
}
@end
