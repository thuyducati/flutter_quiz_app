import 'package:flutter/material.dart';

import '../utils/question.dart';
import '../utils/quiz.dart';

import '../UI/answer_button.dart';
import '../UI/question_text.dart';
import '../UI/correct_wrong_overlay.dart';

import '../pages/score_page.dart';

class QuizPage extends StatefulWidget {
  @override
  State createState() => new QuizPageState();
}

class QuizPageState extends State<QuizPage> {
  Question currentQuestion;
  Quiz quiz = new Quiz([
    new Question(
        "Giải vô địch bóng đá thế giới được thành lập vào năm 1930.", true),
    new Question("Không thể hắt xì hơi khi mắt mở.", true),
    new Question("Donald Trump là đương kim Tổng thống Hoa Kỳ thứ 47.", false),
    new Question("Loài rắn hiện nay đã có chân.", false),
    new Question(
        "Trong Android Studio, một file có phần mở rộng là .xml thì file đó sẽ là file layout.",
        false),
    new Question("Trước năm 1868, thủ đô của Nhật Bản tên là Kyoto.", true),
    new Question("Bạn có thể bay lên trời bằng bong bóng bay.", true),
    new Question(
        "Java là một ngôn ngữ lập trình được phát triển dựa trên C#.", false),
    new Question(
        "Núi Phú Sĩ là ngọn núi cao nhất Nhật Bản và là biểu tượng nổi tiếng của quốc gia này.",
        true),
    new Question("Từ pneumonoultramicros có 20 ký tự.", false),
    new Question(
        "Một chiếc tàu điện chạy về hướng Tây thì khói của nó sẽ bay về hướng Đông.",
        false),
    new Question(
        "Chim cánh cụt sống ở Nam Cực, còn gấu trắng sống ở Bắc Cực.", true),
    new Question("Một hình lập phương sẽ có tổng cộng là 12 cạnh.", true),
    new Question(
        "Trong trận chung kết World Cup 2018, trái thứ hai được đá vào lưới thuộc đội tuyển Pháp.",
        false),
    new Question(
        "Trung bình một người đàn ông 50 tuổi thì sẽ có 50 ngày sinh nhật.",
        false),
    new Question("Chia 30 với 1/2 rồi cộng thêm 10, đáp án là 70.", true),
    new Question(
        "Khi bạn tạo mới một Empty Activity trong Android Studio, thì mặc định luôn luôn có một file layout đi kèm theo.",
        true),
    new Question(
        "Tên chính thức của nước Việt Nam là Cộng hòa Xã hội Chủ nghĩa Việt Nam.",
        true),
    new Question(
        "Trong bóng đá thì trên sân chỉ có duy nhất 11 cầu thủ.", false),
    new Question(
        "Nhà phát minh đã sáng chế ra bóng đèn có tên là Ludwig van Beethoven.",
        false),
  ]);
  String questionText;
  int questionNumber;
  bool isCorrect;
  bool overlayShouldBeVisible = false;

  @override
  void initState() {
    super.initState();
    currentQuestion = quiz.nextQuestion;
    questionText = currentQuestion.question;
    questionNumber = quiz.questionNumber;
  }

  void handleAnswer(bool answer) {
    isCorrect = (currentQuestion.answer == answer);
    quiz.answer(isCorrect);
    this.setState(() {
      overlayShouldBeVisible = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Stack(
      fit: StackFit.expand,
      children: <Widget>[
        new Column(
          children: <Widget>[
            new AnswerButton(true, () => handleAnswer(true)),
            new QuestionText(questionText, questionNumber),
            new AnswerButton(false, () => handleAnswer(false)),
          ],
        ),
        overlayShouldBeVisible == true
            ? new CorrectWrongOverlay(isCorrect, () {
                if (quiz.length == questionNumber) {
                  Navigator.of(context).pushAndRemoveUntil(
                      new MaterialPageRoute(
                          builder: (BuildContext context) =>
                              new ScorePage(quiz.score, quiz.length)),
                      (Route route) => route == null);
                  return;
                }
                currentQuestion = quiz.nextQuestion;
                this.setState(() {
                  overlayShouldBeVisible = false;
                  questionText = currentQuestion.question;
                  questionNumber = quiz.questionNumber;
                });
              })
            : new Container(),
      ],
    );
  }
}
