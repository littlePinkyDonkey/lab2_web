package model;

public class Point {
    private double x;
    private double y;
    private double r;
    private String result;

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

    public boolean checkArea(){
        if (x>= 0){
            if (y>=0 && y<=r/2 && x<=r &&
                    Math.pow(x,2)+Math.pow(y,2)<=Math.pow(r,2)){
                return true;
            }else return y <= 0 && Math.pow(x, 2) + Math.pow(y, 2) < Math.pow(r / 2, 2);
        }else {
            return x >= -r && y >= 0 && y <= r / 2;
        }
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
        return "{x: " + this.x + ", y: " + this.y + ", r: " + this.r + "} ";
    }
}
