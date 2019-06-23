#import "FlutterNativeConfigPlugin.h"
#import <flutter_native_config/flutter_native_config-Swift.h>

@implementation FlutterNativeConfigPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterNativeConfigPlugin registerWithRegistrar:registrar];
}
@end
