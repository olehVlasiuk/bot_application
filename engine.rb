require_relative 'input_reader'
require_relative 'file_writer'
require_relative 'statistics'
require_relative 'question_data'

class Engine
  def initialize
    @question_collection = load_question_collection
    @input_reader = InputReader.new
    @user_name = get_username
    @current_time = Time.now.strftime('%Y-%m-%d %H:%M:%S')
    @writer = FileWriter.new('a', 'answers', 'answers.txt')
    @statistics = Statistics.new(@writer, @user_name, @current_time)
  end

  def run
    puts "Welcome, #{@user_name}!"
    puts "Current Time: #{@current_time}"

    @question_collection.each_with_index do |question, index|
      puts "\nQuestion #{index + 1}:"
      puts question.to_s
      puts 'Possible Answers:'
      puts question.display_answers

      user_answer = get_answer_by_char(question)
      check(user_answer, question.question_correct_answer)

      puts "Your Answer: #{user_answer}"
      puts "Correct Answer: #{question.question_correct_answer}"
    end

    @statistics.print_report
  end

  # метод для перевiрки та ведення статистики
  def check(user_answer, correct_answer)
    user_answer == correct_answer ? @statistics.correct_answer : @statistics.incorrect_answer
  end

  # метод для введення імені користувача з валідацією
  def get_username
    username = @input_reader.read(
      welcome_message: 'Enter your name:',
      validator: ->(input) { input && !input.strip.empty? },
      error_message: 'Name cannot be empty.',
      process: ->(input) { input }
    )

    username
  end  
  
  # метод для введення відповіді користувача з валідацією
  def get_answer_by_char(question)
    answer = @input_reader.read(
      welcome_message: 'Enter your answer:',
      validator: ->(input) { input && !input.strip.empty? },
      error_message: 'Answer cannot be empty.',
      process: ->(input) { input.strip[0] }
    )
  
    answer.upcase
  end

  # метод для завантаження запису колекцій запитань 
  def load_question_collection
    question_data = QuestionData.new('yml', 'questions.yml')
    question_data.collection
  end
end
