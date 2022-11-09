package com.example.new_parking;
import android.os.RemoteException;
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

    //DriverManager mDriverManager;
    //Printer mPrinter;
    Boolean result;
    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
            .setMethodCallHandler(
                (call, result) -> {

                    if (call.method.equals("startPrint")) {
                        int status = startPrint();
                        if (status != -1) {
                            result.success(status);
                        } else {
                            result.error("UNAVAILABLE", "printer not available.", null);
                        }
                    } else {
                        result.notImplemented();
                    }
                }
            );
    }



    void prnitPaper(SunmiPrinterService service) {
        try{
            service.printText("Hosam Zaki\\n", new InnerResultCallback() {
                @Override
                public void onRunResult(boolean isSuccess) throws RemoteException {
                }
                @Override
                public void onReturnString(String result) throws RemoteException {
                }
                @Override
                public void onRaiseException(int code, String msg) throws RemoteException {

                }
                @Override
                public void onPrintResult(int code, String msg) throws RemoteException {

                }
            });
        } catch (RemoteException e) {
            e.printStackTrace();
        }
    }

    private int startPrint() {

        InnerPrinterCallback innerPrinterCallback = new InnerPrinterCallback(){

            @Override
            protected void onConnected(SunmiPrinterService service) {
                prnitPaper(service);
            }

            @Override
            protected void onDisconnected() {

            }
        };

        result = false;

        try {
            result = InnerPrinterManager.getInstance().bindService(getContext(),innerPrinterCallback);

            if (result){
                return 1;
            }

        } catch (InnerPrinterException e) {
            e.printStackTrace();
        }
        return 2;

    }
}

