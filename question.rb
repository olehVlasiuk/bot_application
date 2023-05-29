class Question
  attr_accessor :question_body, :question_correct_answer, :question_answers

  def initialize(raw_text, raw_answers, raw_correct_answer)
    @question_body = raw_text
    @question_answers = load_answers(raw_answers)
    @question_correct_answer = find_answer_by_char(question_answers, raw_correct_answer)
  end

  def display_answers
    @question_answers.each_with_index.map { |answer, index| "#{(index + 65).chr}. #{answer}" }
  end

  def to_s
    @question_body
  end

  def to_h
    {
      question_body: @question_body,
      question_correct_answer: @question_correct_answer,
      question_answers: @question_answers
    }
  end

  def to_json
    to_h.to_json
  end

  def to_yaml
    to_h.to_yaml
  end

  def load_answers(raw_answers)
    raw_answers.shuffle
  end

  def find_answer_by_char(answers, correct_answer)
    index = answers.index(correct_answer)
    char = (index + 65).chr
    char
  end
end
