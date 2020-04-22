package com.codesquad.dust08.constants;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;

import static com.codesquad.dust08.constants.CommonConstants.ENCODING_TYPE;
import static com.codesquad.dust08.constants.CommonConstants.KAKAO_KEY;
import static com.codesquad.dust08.constants.UrlConstants.KAKAO_MAP_CONVERT_TRANSCOORD;

public class Coordinates {
    private static final Logger log = LoggerFactory.getLogger(Coordinates.class);

    private Double x;
    private Double y;

    public void convertToTM(Double latitude, Double longitude) throws IOException {

        StringBuilder urlBuilder = new StringBuilder(KAKAO_MAP_CONVERT_TRANSCOORD);
        urlBuilder.append("." + URLEncoder.encode("json", ENCODING_TYPE));
        urlBuilder.append("?" + URLEncoder.encode("x", ENCODING_TYPE) + "=" + longitude); //경도
        urlBuilder.append("&" + URLEncoder.encode("y", ENCODING_TYPE) + "=" + latitude); //위도
        urlBuilder.append("&" + URLEncoder.encode("input_coord", ENCODING_TYPE) + "=" + URLEncoder.encode("WGS84", ENCODING_TYPE));
        urlBuilder.append("&" + URLEncoder.encode("output_coord", ENCODING_TYPE) + "=" + URLEncoder.encode("TM", ENCODING_TYPE)); //TM으로 변환
        URL url = new URL(urlBuilder.toString());
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        conn.setRequestProperty("Authorization" , KAKAO_KEY);

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
        this.x = jsonNode.get("documents").get(0).get("x").asDouble();
        this.y = jsonNode.get("documents").get(0).get("y").asDouble();

        log.debug("x : {} , y : {}", x, y);
    }

    public Double getX() {
        return x;
    }

    public Double getY() {
        return y;
    }
}
