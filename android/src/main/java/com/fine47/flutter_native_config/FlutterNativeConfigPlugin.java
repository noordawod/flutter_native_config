package com.fine47.flutter_native_config;

import android.content.Context;
import android.content.pm.ApplicationInfo;
import android.content.pm.PackageManager;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/** FlutterNativeConfigPlugin */
@SuppressWarnings("WeakerAccess")
public class FlutterNativeConfigPlugin implements MethodCallHandler {

  public static final String CHANNEL_ID = "noordawod/flutter_native_config";

  /** Plugin registration. */
  public static void registerWith(final Registrar registrar) {
    final MethodChannel channel = new MethodChannel(registrar.messenger(), CHANNEL_ID);
    channel.setMethodCallHandler(new FlutterNativeConfigPlugin(registrar));
  }

  public static String getConfig(
    final Context context,
    final Object name
  ) throws PackageManager.NameNotFoundException, NullPointerException {
    assert null != context;

    if (null != name) {
      final String nameString = name.toString().trim();

      if (!"".equals(nameString)) {
        final ApplicationInfo appInfo = context.getPackageManager().getApplicationInfo(
          context.getPackageName(),
          PackageManager.GET_META_DATA
        );

        return appInfo.metaData.getString(nameString);
      }
    }

    return null;
  }

  private final Registrar registrar;

  private FlutterNativeConfigPlugin(final Registrar registrar) {
    this.registrar = registrar;
  }

  @Override
  public void onMethodCall(final MethodCall call, final Result result) {
    try {
      if ("getConfig".equals(call.method)) {
        final Context context = registrar.context();

        result.success(getConfig(
          context,
          call.argument(call.hasArgument("android") ? "android" : "name")
        ));

        return;
      }
    } catch(PackageManager.NameNotFoundException ignored) {
      // NO-OP.
    } catch(NullPointerException ignored) {
      // NO-OP.
    } catch (ClassCastException ignored) {
      // NO-OP.
    }

    result.notImplemented();
  }
}
