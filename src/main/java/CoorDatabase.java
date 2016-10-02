import com.google.gson.Gson;

import java.util.ArrayList;
import java.util.List;

public class CoorDatabase {

    private List<Marker> mark;

    private static CoorDatabase dbInstance = null;

    protected CoorDatabase() {
        mark = new ArrayList<Marker>();
    }

    public static CoorDatabase getInstance() {
        if(dbInstance == null) {
            dbInstance = new CoorDatabase();
        }
        return dbInstance;
    }

    public void setCLL(String cont, String lat, String lng) {
        mark.add(new Marker (cont, lat, lng));
    }

    public String getMarks() {
        return new Gson().toJson(mark);
    }

}