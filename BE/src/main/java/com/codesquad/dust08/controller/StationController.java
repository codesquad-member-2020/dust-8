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

        return "{ \"pm10Value\": \"68\", \"pm10Grade1h\": \"2\", \"dataTime\": \"2020-03-31 09:00\" }";
    }
}
