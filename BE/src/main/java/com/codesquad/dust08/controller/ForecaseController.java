package com.codesquad.dust08.controller;

import com.codesquad.dust08.data.ForecaseInformation;
import com.codesquad.dust08.data.ResponseResult;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.type.CollectionType;
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
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/forecase")
public class ForecaseController {

    private static final Logger log = LoggerFactory.getLogger(ForecaseController.class);

    public static final String SERVICE_KEY = "FwHUBCLVF%2BGTXPUDF9To8ArFacN6La84DaSvEn5dP4Jjw%2BPR9VUd44iYd2ITMu0yO88yseP0akLxoUvsKcHAow%3D%3D";

    // 24시간 대기오염 이미지 호출
    @GetMapping("/images")
    public String getOverallImages() {

        return "{ \"imageUrl1\": \"http://www.airkorea.or.kr/file/viewImage/?atch_id=138717\",\n" +
                "            \"imageUrl2\": \"http://www.airkorea.or.kr/file/viewImage/?atch_id=138718\",\n" +
                "            \"imageUrl3\": \"http://www.airkorea.or.kr/file/viewImage/?atch_id=138719\"\n" +
                "}";
    }

    // 예보 문구 출력 호출
    @GetMapping("/informoverall")
    public ResponseEntity getOverallForecase() throws IOException {
        LocalTime currentTime = LocalTime.now();
        String searchDate;

        // 디테일 시간 구현 필요
        if (currentTime.getHour() < 5) searchDate = LocalDate.now().minusDays(1).toString();
        else searchDate = LocalDate.now().toString();


        String jsonForecaseData = collectJsonForecaseDataFromOpenApi(searchDate);

        ObjectMapper objectMapper = new ObjectMapper();
        JsonNode forecaseInformationNode = objectMapper.readTree(jsonForecaseData).path("list");
        log.debug("Node : {}", forecaseInformationNode);

        CollectionType collectionType = objectMapper.getTypeFactory().constructCollectionType(ArrayList.class, ForecaseInformation.class);
        List<ForecaseInformation> forecaseInformationList = objectMapper.readValue(forecaseInformationNode.toString(), collectionType);

        ForecaseInformation recentForecaseData = forecaseInformationList.get(0);

        log.debug("JSON DATA : {}", recentForecaseData);

        return ResponseEntity.status(HttpStatus.OK)
                .body(new ResponseResult(recentForecaseData));
    }

    // 지역별 등급 표시 요청
    @GetMapping("/grade")
    public String getInformGrade() {

        return "{ \"informGrade\": \"서울 : 보통,제주 : 보통,전남 : 보통,전북 : 보통,광주 : 보통,경남 : 보통,경북 : 보통,울산 : 보통,대구 : 보통,부산 : 보통,충남 : 보통,충북 : 보통,세종 : 보통,대전 : 보통,영동 : 보통,영서 : 보통,경기남부 : 보통,경기북부 : 보통,인천 : 보통\" }";
    }

    public String collectJsonForecaseDataFromOpenApi(String searchDate) throws IOException {
        StringBuilder urlBuilder = new StringBuilder("http://openapi.airkorea.or.kr/openapi/services/rest/ArpltnInforInqireSvc/getMinuDustFrcstDspth"); /*URL*/
        urlBuilder.append("?" + URLEncoder.encode("ServiceKey","UTF-8") + "=" + SERVICE_KEY); /*Service Key*/
        urlBuilder.append("&" + URLEncoder.encode("searchDate","UTF-8") + "=" + URLEncoder.encode(searchDate, "UTF-8")); /*한 페이지 결과 수*/
        urlBuilder.append("&" + URLEncoder.encode("informCode","UTF-8") + "=" + URLEncoder.encode("PM10", "UTF-8")); /*페이지 번호*/
        urlBuilder.append("&" + URLEncoder.encode("_returnType","UTF-8") + "=" + URLEncoder.encode("json", "UTF-8")); /*페이지 번호*/
        URL url = new URL(urlBuilder.toString());
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        conn.setRequestProperty("Content-type", "application/json");
        System.out.println("Response code: " + conn.getResponseCode());
        BufferedReader rd;
        if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
            rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
        } else {
            rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
        }
        StringBuilder sb = new StringBuilder();
        String line;
        while ((line = rd.readLine()) != null) {
            sb.append(line);
        }
        rd.close();
        conn.disconnect();

        return sb.toString();
    }
}
