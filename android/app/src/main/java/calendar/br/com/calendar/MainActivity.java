package calendar.br.com.calendar;

import android.app.NotificationChannel;
import android.app.NotificationManager;
import android.os.Build;
import android.provider.Settings;

import androidx.annotation.NonNull;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
    CalendarDB calendarDB;
    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine);
        String UUID = Settings.Secure.getString(this.getContentResolver(),
                Settings.Secure.ANDROID_ID);
        calendarDB = new CalendarDB(this);
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            NotificationChannel channel = new NotificationChannel("messages", "Messages", NotificationManager.IMPORTANCE_LOW);
            NotificationManager manager = getSystemService(NotificationManager.class);
            manager.createNotificationChannel(channel);
        }
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), "channel")
                .setMethodCallHandler(
                        (call, result) -> {
                            if (call.method.equals("uuid")) {
                                result.success(UUID);
                            } else if (call.method.equals("tojava")) {
                                String r = "";
                                try {
                                    String ref = call.argument("ref").toString();
                                    if (ref.equals("list")) {
                                        r = calendarDB.toDart();
                                    } else if (ref.equals("edit")) {
                                        if (Integer.parseInt(call.argument("id").toString()) > 0) {
                                            calendarDB.updateCalendar(
                                                    call.argument("id").toString(),
                                                    call.argument("title").toString(),
                                                    call.argument("description").toString(),
                                                    call.argument("datetime").toString(),
                                                    call.argument("color").toString()
                                            );
                                        } else {
                                            calendarDB.addCalendar(
                                                    call.argument("title").toString(),
                                                    call.argument("description").toString(),
                                                    call.argument("datetime").toString(),
                                                    call.argument("color").toString()
                                            );
                                        }
                                    } else if (ref.equals("del")) {
                                        calendarDB.deleteCalendar(call.argument("id").toString());
                                    }
                                } catch (Exception e) {
                                    System.out.println("Error");
                                }
                                result.success(r);
                            }
                        }
                );
    }
}