class Statistics
  def initialize(writer, username, start_time)
    @correct_answers = 0
    @incorrect_answers = 0
    @writer = writer
    @username = username
    @start_time = start_time
  end

  # метод-лічильник коректних відповідей
  def correct_answer
    @correct_answers += 1
  end

  # метод-лічильник некоректних відповідей
  def incorrect_answer
    @incorrect_answers += 1
  end

  # формування підсумків проходження тесту, включаючи загальну к-сть коректних та некоректних відповідей та процентного відношення коректних відповідей до загальної к-сті запитань.
  def print_report
    total_questions = @correct_answers + @incorrect_answers
    accuracy = total_questions.zero? ? 0 : (@correct_answers.to_f / total_questions) * 100

    emoji = if accuracy >= 80
      "🎉"
    elsif accuracy >= 50
      "🙂"
    else
      "😕"
    end

    report = <<~REPORT

      Test Results:
      Name: #{@username}
      Start time: #{@start_time}
      Total Questions: #{total_questions}
      Correct Answers: #{@correct_answers}
      Incorrect Answers: #{@incorrect_answers}
      Accuracy: #{accuracy}% #{emoji}

    REPORT

    @writer.write(report)
    puts report
  end
end
