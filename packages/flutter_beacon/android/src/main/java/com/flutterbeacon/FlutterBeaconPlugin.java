package com.flutterbeacon;

import android.app.Activity;
import android.content.Context;

import androidx.annotation.NonNull;

import org.altbeacon.beacon.BeaconManager;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class FlutterBeaconPlugin implements FlutterPlugin, MethodChannel.MethodCallHandler {

  public static final int REQUEST_CODE_BLUETOOTH = 12345;
  public static final int REQUEST_CODE_LOCATION = 54321;

  private static BeaconManager beaconManager;
  private static Context context;
  private static Activity activity;
  public static MethodChannel.Result flutterResult;

  private MethodChannel channel;

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding binding) {
    context = binding.getApplicationContext();
    channel = new MethodChannel(binding.getBinaryMessenger(), "flutter_beacon");
    channel.setMethodCallHandler(this);
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
    channel = null;
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
    // 임시 처리
    result.notImplemented();
  }

  public static BeaconManager getBeaconManager() {
    return beaconManager;
  }

  public static void setBeaconManager(BeaconManager manager) {
    beaconManager = manager;
  }

  public static Context getContext() {
    return context;
  }

  public static Activity getActivity() {
    return activity;
  }

  public static void setActivity(Activity act) {
    activity = act;
  }
}