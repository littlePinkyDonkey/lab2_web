package beans;

import model.Point;

import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;

public class ResultBean implements Serializable {
    private static final long serialVersionUID = 2041275512219239990L;

    private Set<Point> history = new HashSet<>();
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
        if (currentPoint != null)
            this.history.add(currentPoint);
    }
}
