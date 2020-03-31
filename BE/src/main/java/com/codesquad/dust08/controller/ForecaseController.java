package com.codesquad.dust08.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/forecase")
public class ForecaseController {
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
    public String getOverallForecase() {

        return "{ \"informOverall\" : \"○ [미세먼지] 전 권역이 '좋음'∼'보통'으로 예상됨.\" }";
    }

    // 지역별 등급 표시 요청
    @GetMapping("/grade")
    public String getInformGrade() {

        return "{ \"informGrade\": \"서울 : 보통,제주 : 보통,전남 : 보통,전북 : 보통,광주 : 보통,경남 : 보통,경북 : 보통,울산 : 보통,대구 : 보통,부산 : 보통,충남 : 보통,충북 : 보통,세종 : 보통,대전 : 보통,영동 : 보통,영서 : 보통,경기남부 : 보통,경기북부 : 보통,인천 : 보통\" }";
    }
}
