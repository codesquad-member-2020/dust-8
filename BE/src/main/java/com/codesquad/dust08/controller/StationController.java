package com.codesquad.dust08.controller;

import com.codesquad.dust08.data.DustStatus;
import com.codesquad.dust08.data.ResponseResult;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;

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
    public ResponseEntity getGrade(String stationName) throws IOException {
        if (stationName == null) {
            log.debug("is empty!!!!!!");
            return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                    .body(new ResponseResult(false, "잚못된 요청입니다."));
        }
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
        conn.setRequestProperty("Content-type", "application/json");

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
        String responseString = sb.toString();
        log.debug("Response : {}", responseString);

        ObjectMapper mapper = new ObjectMapper();
        List<DustStatus> dustStatusList = new ArrayList<>();
        JsonNode jsonNode = mapper.readTree(responseString);
        for (JsonNode list : jsonNode.get("list")) {
            log.debug("list : {}", list);
            DustStatus dustStatus = new DustStatus();
            dustStatus.setDataTime(list.get("dataTime").asText());
            dustStatus.setPm10Value(list.get("pm10Value").asInt());
            dustStatus.setPm10Grade1h(list.get("pm10Grade1h").asInt());
            dustStatusList.add(dustStatus);
        }

        return ResponseEntity.status(HttpStatus.OK)
                .body(new ResponseResult(dustStatusList));
    }
}
