package calendar.br.com.calendar;
public class CalendarData {
    int _id;
    String _title;
    String _description;
    String _datetime;
    String _color;
    public CalendarData() {}
    public int getID() {
        return this._id;
    }
    public void setID(int id){
        this._id = id;
    }
    public String getTitle(){
        return this._title;
    }
    public void setTitle(String title){
        this._title = title;
    }
    public String getDescription(){
        return this._description;
    }
    public void setDescription(String description){
        this._description = description;
    }
    public String getDatetime(){
        return this._datetime;
    }
    public void setDatetime(String datetime){
        this._datetime = datetime;
    }
    public String getColor(){
        return this._color;
    }
    public void setColor(String color){
        this._color = color;
    }
}
