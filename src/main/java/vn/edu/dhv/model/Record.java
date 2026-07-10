package vn.edu.dhv.model;

public class Record {
    private int id;
    private String stname;
    private String course;
    private int fee;

    public Record() {}

    public Record(int id, String stname, String course, int fee) {
        this.id = id;
        this.stname = stname;
        this.course = course;
        this.fee = fee;
    }

    public Record(String stname, String course, int fee) {
        this.stname = stname;
        this.course = course;
        this.fee = fee;
    }

    public int getId() { return id; } 
    public void setId(int id) { this.id = id; }
    public String getStname() { return stname; }
    public void setStname(String stname) { this.stname = stname; }
    public String getCourse() { return course; }
    public void setCourse(String course) { this.course = course; }
    public int getFee() { return fee; }
    public void setFee(int fee) { this.fee = fee; }
}
