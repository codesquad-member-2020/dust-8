export const GRADE = {
  GOOD: { STATE: "좋음", COLOR: "blue", EMOJI: "😀" },
  ORDINARY: { STATE: "보통", COLOR: "green", EMOJI: "🙂" },
  BAD: { STATE: "나쁨", COLOR: "orange", EMOJI: "😷" },
  VERY_BAD: { STATE: "매우 나쁨", COLOR: "red", EMOJI: "😱" }
};

export const gradeList = ["GOOD", "ORDINARY", "BAD", "VERY_BAD"];

export const currentHours = new Date().getHours();
