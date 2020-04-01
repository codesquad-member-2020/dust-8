package com.codesquad.dust08.data;

public class DustStatus {
    private String dataTime;
    private int pm10Value;
    private int pm10Grade1h;

    public String getDataTime() {
        return dataTime;
    }

    public void setDataTime(String dataTime) {
        this.dataTime = dataTime;
    }

    public int getPm10Value() {
        return pm10Value;
    }

    public void setPm10Value(int pm10Value) {
        this.pm10Value = pm10Value;
    }

    public int getPm10Grade1h() {
        return pm10Grade1h;
    }

    public void setPm10Grade1h(int pm10Grade1h) {
        this.pm10Grade1h = pm10Grade1h;
    }
}
