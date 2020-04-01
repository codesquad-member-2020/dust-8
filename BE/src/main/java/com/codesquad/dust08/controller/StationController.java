package com.codesquad.dust08.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;

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
    public String getGrade(String stationName) throws IOException {
        final String SERVICE_KEY = "6aRmxVKhQasLEppxZRQirEm2LIgzObFzmhH4sg1veRb3trWgiOU58lfEQqUHcYMucI398cs2Vd8S2Ygz9pS9Zw%3D%3D";
        log.debug("stationName : {}", stationName);
        StringBuilder urlBuilder = new StringBuilder("http://openapi.airkorea.or.kr/openapi/services/rest/ArpltnInforInqireSvc/getMsrstnAcctoRltmMesureDnsty"); //URL
        urlBuilder.append("?" + URLEncoder.encode("ServiceKey", "UTF-8") + "=" + SERVICE_KEY); //ServiceKey
        urlBuilder.append("&" + URLEncoder.encode("stationName", "UTF-8") + "=" + stationName); //측정소
        urlBuilder.append("&" + URLEncoder.encode("dataTerm", "UTF-8") + "=" + URLEncoder.encode("DAILY", "UTF-8")); //하루치 데이터
        urlBuilder.append("&" + URLEncoder.encode("numOfRows", "UTF-8") + "=" + URLEncoder.encode("24", "UTF-8")); //24개 데이터
        urlBuilder.append("&" + URLEncoder.encode("_returnType","UTF-8") + "=" + URLEncoder.encode("JSON", "UTF-8"));
        URL url = new URL(urlBuilder.toString());
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");

        int responseCode = conn.getResponseCode();
        log.debug("Response code : {}", responseCode);
        BufferedReader br;
        if (responseCode >= 200 && responseCode <= 300) {
            br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
        } else {
            br = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
        }

        StringBuilder sb = new StringBuilder();
        String line;
        while ((line = br.readLine()) != null) {
            sb.append(line);
        }

        br.close();
        conn.disconnect();
        log.debug("Response : {}", sb.toString());

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
