package com.codesquad.dust08.data;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;

@JsonIgnoreProperties(ignoreUnknown = true)
public class ForecaseInformation {

    @JsonProperty("dataTime")
    private String announceDateTime;

    @JsonProperty("imageUrl1")
    private String firstImage;

    @JsonProperty("imageUrl2")
    private String secondImage;

    @JsonProperty("imageUrl3")
    private String thirdImage;

    private String informCode;

    private String informGrade;

    private String informOverall;

    @JsonProperty("informData")
    private String forecaseDate;

    public String getAnnounceDateTime() {
        return announceDateTime;
    }

    public void setAnnounceDateTime(String announceDateTime) {
        this.announceDateTime = announceDateTime;
    }

    public String getFirstImage() {
        return firstImage;
    }

    public void setFirstImage(String firstImage) {
        this.firstImage = firstImage;
    }

    public String getSecondImage() {
        return secondImage;
    }

    public void setSecondImage(String secondImage) {
        this.secondImage = secondImage;
    }

    public String getThirdImage() {
        return thirdImage;
    }

    public void setThirdImage(String thirdImage) {
        this.thirdImage = thirdImage;
    }

    public String getInformCode() {
        return informCode;
    }

    public void setInformCode(String informCode) {
        this.informCode = informCode;
    }

    public String getInformGrade() {
        return informGrade;
    }

    public void setInformGrade(String informGrade) {
        this.informGrade = informGrade;
    }

    public String getInformOverall() {
        return informOverall;
    }

    public void setInformOverall(String informOverall) {
        this.informOverall = informOverall;
    }

    public String getForecaseDate() {
        return forecaseDate;
    }

    public void setForecaseDate(String forecaseDate) {
        this.forecaseDate = forecaseDate;
    }
}
