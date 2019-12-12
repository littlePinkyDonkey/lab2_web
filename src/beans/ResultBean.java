package beans;

import model.Point;

import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;

public class ResultBean implements Serializable {
    private static final long serialVersionUID = 2041275512219239990L;
    

    private HashSet<Point> history = new HashSet<>();
    private Point currentPoint;

    public ResultBean(){

    }

    public Set<Point> getHistory() {
        return history;
    }
    public Point getCurrentPoint() {
        return currentPoint;
    }

    public void setCurrentPoint(Point currentPoint) {
        this.history.add(currentPoint);
    }
}
