# 미세먼지 서비스 8팀 

## 팀원

| 클래스       | 이름             |
| --------- | -------------- |
| Back-end  | Solar, Ragdoll |
| iOS       | Olaf           |
| Front-end | Hoo            |

## 요구사항 기술서

[구글 스프레드 시트 링크](https://docs.google.com/spreadsheets/d/1jXbJLQjVUFciTBiK5itZQLJudNjb7fn9I3y3HE2u2BA/edit?usp=sharing)



## Ground Rule

### 컨벤션

- [Git - 커밋 메시지 컨벤션](https://doublesprogramming.tistory.com/256)을 따른다. 
- 커밋 타입은 [Feat], [Fix] 형식을 유지한다.
- 예시: `[Feat] 로그인 기능 추가`
- 커밋에 이슈 번호를 붙인다. ??



### 프로젝트 관리

- 각 클래스별 저장소 폴더를 만들어서 관리한다.
- Project를 FE, BE, iOS로 3개 만들어 To do, Doing, Done 상태를 표시한다.



### 브랜치 관리

- master: 최종 릴리즈되는 마스터
- dev: 각 클래스 별 기능 완료 시 PR보내는 브랜치
- fe, ios : 각 클래스 별로 기능이 완료되었을 때 PR보내는 브랜치
- feature/fe/ui: 기능 단위로 브랜치 클래스 분류해서 설정

> 기능 단위 브랜치는 fe나 dev로 머지 후에 삭제한다.



### 이슈 관리

- issue에 구현할 내용 정리한다.
- 구현 후 commit할 때 closed 처리한다.

  

### 스크럼

- 시간: 12시
- 방식: 구두로 공유 후 wiki에 해당 날짜의 스크럼 업로드
- 공유하는 내용: 어제 한 일, 오늘 할 일, 오늘 컨디션


### 회고

- 시간: 6시
- 방식: 구두로 공유 후 wiki에 해당 날짜의 스크럼 업로드
- 공유하는 내용: 오늘 한 일, 잘한 점, 아쉬운 점, 피드백