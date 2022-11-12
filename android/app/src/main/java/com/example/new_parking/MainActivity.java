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
                                boolean status = startPrint(call.argument("print_text"), call.argument("parking_id"));
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

    /*
  Function: void printBarCode(String data, int symbology, int height, int width, int textPosition, ICallback callback)
Parameters:
data the 1D barcode to be printed
symbology
barcode type (0-8): 0 UPC-A
1 UPC-E
2 JAN13(EAN13) 3 JAN8(EAN8)
4 CODE39
5 ITF
6 CODABAR
7 CODE93
8 CODE128
height 162
width  2
textPosition text position (0-3)
0 don’t print text
1 text above the barcode
2 text under the barcode
3 text above and under the barcode
callback Result callback
Note: the differences caused by different codes are listed below
barcode height (ranges from 1-255. 162 by default). barcode width (ranges from 2-6. 2 by default).

     */

    private boolean startPrint(String printString, String parkingId) {
        Log.d("FLUTTER PRINTER", "startPrint: " + printString + ", parking id: " + parkingId);
        InnerPrinterCallback innerPrinterCallback = new InnerPrinterCallback() {
            @Override
            protected void onConnected(SunmiPrinterService service) {
                try {

                    service.printBarCode(parkingId, 8, 162, 4, 2, new InnerResultCallback() {
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
                            try {
                                service.exitPrinterBuffer(true);
                            } catch (RemoteException e) {
                                e.printStackTrace();
                            }
                        }
                    });

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
                            try {
                                service.exitPrinterBuffer(true);
                            } catch (RemoteException e) {
                                e.printStackTrace();
                            }
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