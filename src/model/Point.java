package model;

public class Point {
    private double x;
    private double y;
    private double r;
    private String result;

    public Point(){}
    public Point(double x, double y, double r) {
        this.x = x;
        this.y = y;
        this.r = r;
    }

    public double getX() {
        return x;
    }
    public double getY() {
        return y;
    }
    public double getR() {
        return r;
    }
    public String getResult(){
        return result;
    }

    public void setResult(String result){
        this.result = result;
    }
    public void setX(double x) {
        this.x = x;
    }
    public void setY(double y) {
        this.y = y;
    }
    public void setR(double r) {
        this.r = r;
    }

    public boolean checkArea() {
        double halfR = r / 2;

        return x >= 0 && y >= 0 && y < halfR - x / 2 ||
                x >= 0 && y <= 0 && x * x + y * y < halfR * halfR ||
                x <= 0 && y >= 0 && x >= -r && y <= halfR;
    }

    @Override
    public int hashCode() {
        int start = (int) x >>> 2 & (int) y | (int) r;
        start += result.hashCode() ^ start;
        return start << 4;
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj) return true;
        if (obj == null || obj.getClass() != this.getClass()) return false;

        Point point = (Point) obj;
        return this.x == point.getX() && this.y == point.getY()
                && this.r == point.getR() && this.result.equals(point.getResult());
    }

    @Override
    public String toString() {
        //{"x":1,"y":5,"r":0}
        return "{\"x\":" + this.x + ",\"y\":" + this.y
                + ",\"r\":" + this.r + ",\"result\":\"" + this.result + "\"}";
    }
}
