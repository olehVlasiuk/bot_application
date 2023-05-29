class Question
  attr_accessor :question_body, :question_correct_answer, :question_answers

  def initialize(raw_text, raw_answers, raw_correct_answer)
    @question_body = raw_text
    @question_answers = shuffle_answers(raw_answers)
    @question_correct_answer = find_char_by_answer(question_answers, raw_correct_answer)
  end

  # формування масиву стрічок у вигляді "#{char}.#{answer}"
  def display_answers
    @question_answers.each_with_index.map { |answer, index| "#{(index + 65).chr}. #{answer}" }
  end

  # перезавантаження методу to_s для заданого класу, повернення стрічки із текстом запитання
  def to_s
    @question_body
  end

  # метод, який формує хеш з ключами :question_body, question_correct_answer:, :question_answers (та їх значеннями)
  def to_h
    {
      question_body: @question_body,
      question_correct_answer: @question_correct_answer,
      question_answers: @question_answers
    }
  end

  # метод, який формує інформацію про об'єкт в JSON форматі
  def to_json
    to_h.to_json
  end

  # метод, який формує інформацію про об'єкт в yaml форматі
  def to_yaml
    to_h.to_yaml
  end

  # метод, який перемішує випадковим чином
  def shuffle_answers(raw_answers)
    raw_answers.shuffle
  end
 
  # метод, який знаходить правильну літеру відповіді
  def find_char_by_answer(answers, correct_answer)
    index = answers.index(correct_answer)
    char = (index + 65).chr
    char
  end
end
