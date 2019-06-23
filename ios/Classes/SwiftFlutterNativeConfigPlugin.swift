import Flutter
import UIKit

public class SwiftFlutterNativeConfigPlugin: NSObject, FlutterPlugin {

  public static let channelId = "noordawod/flutter_native_config"

  public static func register(with registrar: FlutterPluginRegistrar) {
    registrar.addMethodCallDelegate(
      SwiftFlutterNativeConfigPlugin(),
      channel: FlutterMethodChannel(name: channelId, binaryMessenger: registrar.messenger())
    )
  }

  public static func getConfig(named key: String?) -> Any? {
    if let key = key, let infoMap = Bundle.main.infoDictionary {
      return infoMap[key]
    }

    return nil
  }

  private override init() {
    // Singleton.
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    if ("getConfig" == call.method) {
      var value: Any? = nil

      if let arguments = call.arguments as? Dictionary<String, Any> {
        if let key = arguments["ios"] as? String {
          value = SwiftFlutterNativeConfigPlugin.getConfig(named: key)
        } else if let key = arguments["name"] as? String {
          value = SwiftFlutterNativeConfigPlugin.getConfig(named: key)
        }
      }

      result(value)

      return
    }

    result(FlutterMethodNotImplemented)
  }
}
