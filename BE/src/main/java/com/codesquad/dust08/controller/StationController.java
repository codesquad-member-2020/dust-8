package com.codesquad.dust08.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/stations")
public class StationController {
    private static final Logger log = LoggerFactory.getLogger(StationController.class);
    // 위도, 경도에서 가까운 측정소 반환
    @GetMapping("")
    public String getStationName(double latitude, double longitude) {
        return "{ \"stationName\" : \"강남구\" }";
    }

    // 특정 측정소의 최근 측정된 미세먼지 등급 반환
    @GetMapping("/dust-status")
    public String getGrade(String stationName) {

        return "{\n" +
                "\t\"dustStatus\": [{\n" +
                "\t\t\t\"dataTime\": \"2020-03-30 18:00\",\n" +
                "\t\t\t\"pm10Value\": \"10\",\n" +
                "\t\t\t\"pm10Grade1h\": \"1\"\n" +
                "\t\t},\n" +
                "\t\t{\n" +
                "\t\t\t\"dataTime\": \"2020-03-30 17:00\",\n" +
                "\t\t\t\"pm10Value\": \"20\",\n" +
                "\t\t\t\"pm10Grade1h\": \"1\"\n" +
                "\t\t},\n" +
                "\t\t{\n" +
                "\t\t\t\"dataTime\": \"2020-03-30 16:00\",\n" +
                "\t\t\t\"pm10Value\": \"30\",\n" +
                "\t\t\t\"pm10Grade1h\": \"1\"\n" +
                "\t\t},\n" +
                "\t\t{\n" +
                "\t\t\t\"dataTime\": \"2020-03-30 15:00\",\n" +
                "\t\t\t\"pm10Value\": \"40\",\n" +
                "\t\t\t\"pm10Grade1h\": \"2\"\n" +
                "\t\t}]}";
    }
}
