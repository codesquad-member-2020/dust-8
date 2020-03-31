package com.codesquad.dust08.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class StationController {
    // 위도, 경도에서 가까운 측정소 반환
    @GetMapping("/stations")
    public String getStationName(@RequestParam double latitude, @RequestParam double longitude) {

        return "{ \"stationName\" : \"강남구\" }";
    }

    // 특정 측정소의 최근 측정된 미세먼지 등급 반환
    @GetMapping("/stations/dust-status")
    public String getGrade(@RequestParam String stationName) {

        return "{ \"pm10Value\": \"68\", \"pm10Grade1h\": \"2\", \"dataTime\": \"2020-03-31 09:00\" }";
    }
}
