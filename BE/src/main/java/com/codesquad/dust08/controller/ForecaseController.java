package com.codesquad.dust08.controller;

import com.codesquad.dust08.constants.CommonConstants;
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

import static com.codesquad.dust08.constants.CommonConstants.ENCODING_TYPE;
import static com.codesquad.dust08.constants.CommonConstants.SERVICE_KEY;

@RestController
@RequestMapping("/forecase")
public class ForecaseController {

    private static final Logger log = LoggerFactory.getLogger(ForecaseController.class);

    @GetMapping("")
    public ResponseEntity getOverallForecase() throws IOException {
        LocalTime currentTime = LocalTime.now();
        String searchDate;

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

    public String collectJsonForecaseDataFromOpenApi(String searchDate) throws IOException {
        StringBuilder urlBuilder = new StringBuilder("http://openapi.airkorea.or.kr/openapi/services/rest/ArpltnInforInqireSvc/getMinuDustFrcstDspth"); /*URL*/
        urlBuilder.append("?" + URLEncoder.encode("ServiceKey",ENCODING_TYPE) + "=" + SERVICE_KEY); /*Service Key*/
        urlBuilder.append("&" + URLEncoder.encode("searchDate",ENCODING_TYPE) + "=" + URLEncoder.encode(searchDate, ENCODING_TYPE)); /*한 페이지 결과 수*/
        urlBuilder.append("&" + URLEncoder.encode("informCode",ENCODING_TYPE) + "=" + URLEncoder.encode("PM10", ENCODING_TYPE)); /*페이지 번호*/
        urlBuilder.append("&" + URLEncoder.encode("_returnType",ENCODING_TYPE) + "=" + URLEncoder.encode("json", ENCODING_TYPE)); /*페이지 번호*/
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
