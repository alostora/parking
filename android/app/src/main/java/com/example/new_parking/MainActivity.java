package com.example.new_parking;

import android.os.RemoteException;
import android.util.Log;

import androidx.annotation.NonNull;

import com.sunmi.peripheral.printer.InnerPrinterCallback;
import com.sunmi.peripheral.printer.InnerPrinterException;
import com.sunmi.peripheral.printer.InnerPrinterManager;
import com.sunmi.peripheral.printer.InnerResultCallback;
import com.sunmi.peripheral.printer.SunmiPrinterService;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;

public class MainActivity extends FlutterActivity {
    private static final String CHANNEL = "com.example.new_parking/print";

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
                .setMethodCallHandler(
                        (call, result) -> {
                            if (call.method.equals("startPrint")) {
                                boolean status = startPrint(call.argument("print_text"));
                                if (status) {
                                    result.success(true);
                                } else {
                                    result.error("UNAVAILABLE", "printer not available.", null);
                                }
                            } else {
                                result.notImplemented();
                            }
                        }
                );
    }

    private boolean startPrint(String printString) {
        Log.d("FLUTTER PRINTER", "startPrint: " + printString);
        InnerPrinterCallback innerPrinterCallback = new InnerPrinterCallback() {
            @Override
            protected void onConnected(SunmiPrinterService service) {
                try {
                    service.printOriginalText(printString, new InnerResultCallback() {
                        @Override
                        public void onRunResult(boolean isSuccess) {
                            Log.d("FLUTTER PRINTER", "onRunResult: " + isSuccess);
                        }

                        @Override
                        public void onReturnString(String result) {
                        }

                        @Override
                        public void onRaiseException(int code, String msg) {

                        }

                        @Override
                        public void onPrintResult(int code, String msg) {

                        }
                    });
                } catch (RemoteException e) {
                    e.printStackTrace();
                }
            }

            @Override
            protected void onDisconnected() {
            }
        };
        boolean result;
        try {
            result = InnerPrinterManager.getInstance().bindService(getContext(), innerPrinterCallback);
            return result;
        } catch (InnerPrinterException e) {
            e.printStackTrace();
        }
        return false;
    }
}

