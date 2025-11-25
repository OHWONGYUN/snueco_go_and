package com.example.my_project

import android.app.*
import android.bluetooth.BluetoothAdapter
import android.bluetooth.le.*
import android.content.Context
import android.content.Intent
import android.os.Build
import android.os.IBinder
import android.util.Log
import androidx.annotation.RequiresApi
import java.util.*

class BeaconService : Service() {

    private var scanner: BluetoothLeScanner? = null
    private var scanCallback: ScanCallback? = null
    private val TAG = "BeaconService"

    override fun onCreate() {
        super.onCreate()
        startForegroundService()
        startScanning()
    }

    override fun onDestroy() {
        stopScanning()
        super.onDestroy()
    }

    override fun onBind(intent: Intent?): IBinder? = null

    private fun startForegroundService() {
        val channelId = "beacon_channel"
        val channelName = "Beacon Background Service"
        val notificationManager = getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val chan = NotificationChannel(channelId, channelName, NotificationManager.IMPORTANCE_LOW)
            notificationManager.createNotificationChannel(chan)
        }

        val notification = Notification.Builder(this, channelId)
            .setContentTitle("비콘 스캔 중")
            .setContentText("백그라운드에서 비콘을 감지하고 있어요.")
            .setSmallIcon(android.R.drawable.ic_menu_mylocation)
            .build()

        startForeground(1, notification)
    }

    private fun startScanning() {
        val bluetoothAdapter = BluetoothAdapter.getDefaultAdapter()
        scanner = bluetoothAdapter.bluetoothLeScanner

        scanCallback = object : ScanCallback() {
            override fun onScanResult(callbackType: Int, result: ScanResult?) {
                result?.let {
                    val scanRecord = result.scanRecord
                    val manufacturerData = scanRecord?.getManufacturerSpecificData(0x004C)

                    if (manufacturerData != null && manufacturerData.size >= 23) {
                        val uuidBytes = manufacturerData.copyOfRange(2, 18)
                        val major = ((manufacturerData[18].toInt() and 0xFF) shl 8) + (manufacturerData[19].toInt() and 0xFF)
                        val minor = ((manufacturerData[20].toInt() and 0xFF) shl 8) + (manufacturerData[21].toInt() and 0xFF)
                        val uuid = bytesToHex(uuidBytes)

                        Log.d(TAG, "iBeacon 감지됨 → UUID: $uuid, Major: $major, Minor: $minor")
                    } else {
                        Log.d(TAG, "BLE 감지됨 (iBeacon 아님): ${result.device.address} / RSSI: ${result.rssi}")
                    }
                }
            }

            override fun onScanFailed(errorCode: Int) {
                Log.e(TAG, "BLE 스캔 실패: $errorCode")
            }
        }

        val settings = ScanSettings.Builder()
            .setScanMode(ScanSettings.SCAN_MODE_LOW_LATENCY)
            .build()

        scanner?.startScan(null, settings, scanCallback)
    }

    private fun stopScanning() {
        scanner?.stopScan(scanCallback)
    }

    private fun bytesToHex(bytes: ByteArray): String {
        return bytes.joinToString(separator = "") { byte -> "%02x".format(byte) }
    }
}
