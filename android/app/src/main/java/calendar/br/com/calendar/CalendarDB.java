package calendar.br.com.calendar;
import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;
import org.json.JSONObject;
import java.util.ArrayList;
import java.util.List;

public class CalendarDB extends SQLiteOpenHelper {
    public CalendarDB(Context context) {
        super(context, "db", null, 1);
    }
    @Override
    public void onCreate(SQLiteDatabase db) {
        db.execSQL("CREATE TABLE calendar (id INTEGER PRIMARY KEY, title TEXT, description TEXT,datetime TEXT, color TEXT, created TEXT, updated TEXT, deleted TEXT, sended INTEGER)");
    }
    @Override
    public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) {
        db.execSQL("DROP TABLE IF EXISTS calendar");
        onCreate(db);
    }
    public void updateCalendar(String id,String title,String description,String datetime, String color) {
        SQLiteDatabase db = this.getWritableDatabase();
        db.execSQL("UPDATE calendar SET title='"+title+"',description='"+description+"',datetime='"+datetime+"',color='"+color+"' WHERE id="+id);
        db.close();
    }
    public void addCalendar(String title,String description,String datetime,String color) {
        SQLiteDatabase db = this.getWritableDatabase();
        ContentValues values = new ContentValues();
        values.put("title", title);
        values.put("description", description);
        values.put("datetime", datetime);
        values.put("color", color);
        db.insert("calendar", null, values);
        db.close();
    }
    public List<CalendarData> getCalendarsSql(String sql) {
        List<CalendarData> calendarDataList = new ArrayList<CalendarData>();
        String selectQuery = sql;
        SQLiteDatabase db = this.getWritableDatabase();
        Cursor cursor = db.rawQuery(selectQuery, null);
        if (cursor.moveToFirst()) {
            do {
                CalendarData calendarData = new CalendarData();
                calendarData.setID(Integer.parseInt(cursor.getString(0)));
                calendarData.setTitle(cursor.getString(1));
                calendarData.setDescription(cursor.getString(2));
                calendarData.setDatetime(cursor.getString(3));
                calendarData.setColor(cursor.getString(4));
                calendarDataList.add(calendarData);
            } while (cursor.moveToNext());
        }
        return calendarDataList;
    }
    public void deleteCalendar(String id) {
        SQLiteDatabase db = this.getWritableDatabase();
        db.execSQL("DELETE FROM calendar WHERE id="+id);
        db.close();
    }
    public String toDart() {
        try {
            int i = 0;
            JSONObject jsonResponse = new JSONObject();
            List<CalendarData> CalendarData = getCalendarsSql("SELECT  * FROM calendar ORDER BY id DESC");
            for (CalendarData cl : CalendarData) {
                JSONObject jsonObject = new JSONObject();
                jsonObject.put("id", cl.getID());
                jsonObject.put("title", cl.getTitle());
                jsonObject.put("description", cl.getDescription());
                jsonObject.put("datetime", cl.getDatetime());
                jsonObject.put("color", cl.getColor());
                jsonResponse.put(String.valueOf(i), jsonObject);
                i++;
            }
            return jsonResponse.toString();
        } catch (Exception e) {
            System.out.println("toDart error");
            return "";
        }
    }
}



