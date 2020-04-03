package com.codesquad.dust08.controller;

import com.codesquad.dust08.constants.Coordinates;
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

import static com.codesquad.dust08.constants.CommonConstants.*;
import static com.codesquad.dust08.constants.UrlConstants.NEAR_STATION;
import static com.codesquad.dust08.constants.UrlConstants.STATION_DUST_STATUS;

@RestController
@RequestMapping("/stations")
public class StationController {
    private static final Logger log = LoggerFactory.getLogger(StationController.class);
    // 위도, 경도에서 가까운 측정소 반환
    @GetMapping("")
    public ResponseEntity getStationName(double latitude, double longitude) throws IOException {
        if (latitude == 0 || longitude  == 0) {
            log.debug("[*]=====> latitude or longitude is empty");
            return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                    .body(new ResponseResult(false, "잘못된 요청입니다."));
        }

        // 위도 경도 변환 -> TM 좌표
        Coordinates coordinates = new Coordinates();
        coordinates.convertToTM(latitude, longitude);

        StringBuilder urlBuilder = new StringBuilder(NEAR_STATION);
        urlBuilder.append("?" + URLEncoder.encode("ServiceKey", ENCODING_TYPE) + "=" + SERVICE_KEY);
        urlBuilder.append("&" + URLEncoder.encode("tmX", ENCODING_TYPE) + "=" + coordinates.getX()); //경도
        urlBuilder.append("&" + URLEncoder.encode("tmY", ENCODING_TYPE) + "=" + coordinates.getY()); //위도
        urlBuilder.append("&" + URLEncoder.encode("_returnType", ENCODING_TYPE) + "=" + URLEncoder.encode("JSON", ENCODING_TYPE));
        URL url = new URL(urlBuilder.toString());
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        conn.setRequestProperty("Content-type" , CONTENT_TYPE_JSON);

        int responseCode = conn.getResponseCode();
        log.debug("Response code : {}", responseCode);
        BufferedReader br;
        if (responseCode >= 200 && responseCode <=300) {
            br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
        } else {
            br = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
        }

        StringBuilder sb = new StringBuilder();
        String responseLine;
        if ((responseLine = br.readLine()) != null) {
            sb.append(responseLine);
        }

        br.close();
        conn.disconnect();

        String responseString = sb.toString();
        log.debug("Response : {}", responseString);
        ObjectMapper objectMapper = new ObjectMapper();
        JsonNode jsonNode = objectMapper.readTree(responseString);
        String stationName = jsonNode.get("list").get(0).get("stationName").asText(); //가까운 측정소 목록중 첫번쨰 데이터 값만 전달
        log.debug("stationName : {}" , stationName);

        return ResponseEntity.status(HttpStatus.OK)
                .body(new ResponseResult(stationName));

    }

    // 특정 측정소의 최근 측정된 미세먼지 등급 반환
    @GetMapping("/dust-status")
    public ResponseEntity getGrade(String stationName) throws IOException {
        if (stationName == null) {
            log.debug("[*]=====> stationName is empty");
            return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                    .body(new ResponseResult(false, "잚못된 요청입니다."));
        }
        log.debug("stationName : {}", stationName);
        StringBuilder urlBuilder = new StringBuilder(STATION_DUST_STATUS); //URL
        urlBuilder.append("?" + URLEncoder.encode("ServiceKey", ENCODING_TYPE) + "=" + SERVICE_KEY); //ServiceKey
        urlBuilder.append("&" + URLEncoder.encode("stationName", ENCODING_TYPE) + "=" + stationName); //측정소
        urlBuilder.append("&" + URLEncoder.encode("dataTerm", ENCODING_TYPE) + "=" + URLEncoder.encode("DAILY", ENCODING_TYPE)); //하루치 데이터
        urlBuilder.append("&" + URLEncoder.encode("numOfRows", ENCODING_TYPE) + "=" + URLEncoder.encode("24", ENCODING_TYPE)); //24개 데이터
        urlBuilder.append("&" + URLEncoder.encode("_returnType",ENCODING_TYPE) + "=" + URLEncoder.encode("JSON", ENCODING_TYPE));
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
