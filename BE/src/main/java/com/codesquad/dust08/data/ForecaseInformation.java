package com.codesquad.dust08.data;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;

import java.util.ArrayList;
import java.util.List;

@JsonIgnoreProperties(ignoreUnknown = true)
public class ForecaseInformation {

    private String gradeOfCities;

    private String forecaseContent;

    private String imageUrl1;

    private String imageUrl2;

    private String imageUrl3;

    private List<String> images;

    @JsonProperty("gradeOfCities")
    public String getGradeOfCities() {
        return gradeOfCities;
    }

    @JsonProperty("informGrade")
    public void setGradeOfCities(String informGrade) {
        this.gradeOfCities = informGrade;
    }

    @JsonProperty("forecaseContent")
    public String getForecaseContent() {
        return forecaseContent;
    }

    @JsonProperty("informOverall")
    public void setForecaseContent(String informOverall) {
        this.forecaseContent = informOverall;
    }

    public void setImageUrl1(String imageUrl1) {
        this.imageUrl1 = imageUrl1;
    }

    public void setImageUrl2(String imageUrl2) {
        this.imageUrl2 = imageUrl2;
    }

    public void setImageUrl3(String imageUrl3) {
        this.imageUrl3 = imageUrl3;
    }

    public List<String> getImages() {
        images = new ArrayList<>();
        images.add(imageUrl1);
        images.add(imageUrl2);
        images.add(imageUrl3);

        return images;
    }
}
