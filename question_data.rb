require 'yaml'
require 'json'
require_relative 'question'

class QuestionData
  attr_reader :collection

  # ініціалізація атрибутів та виклик методу load_data
  def initialize(yaml_dir, in_ext)
    @collection = []
    @yaml_dir = prepare_filename(yaml_dir)
    @in_ext = in_ext
    @threads = []
    load_data
  end

  # формування колекції запитань в yaml форматі
  def to_yaml
    @collection.map(&:to_h).to_yaml
  end

  # збереження колекції запитань в yaml форматі до файлу
  def save_to_yaml(filename)
    File.write(prepare_filename(filename), to_yaml)
  end

  # формування колекції запитань в json форматі
  def to_json
    @collection.map(&:to_h).to_json
  end

  # збереження колекції запитань в json форматі до файлу
  def save_to_json(filename)
    File.write(prepare_filename(filename), to_json)
  end

  # формування абсолютного шляху
  def prepare_filename(filename)
    File.expand_path(filename, __dir__)
  end

  # метод, який на вхід приймає блок та виконує його над кожним файлом заданого каталогу 
  # (Dir.glob - повертає імена файлів при заданні шляху до директорії та маски файлів)
  def each_file(&block)
    Dir.glob(File.join(@yaml_dir, "*#{@in_ext}"), &block)
  end

  # запуск блоку коду в окремому потоці та добавлення потоку до масиву потоків
  def in_thread(&block)
    @threads << Thread.new(&block)
  end

  # завантаження інформації про тести та формування колекції запитань при допомозі методів 
  def load_data
    each_file do |filename|
      puts filename
      in_thread do
        load_from(filename)
      end
    end

    @threads.each(&:join)
  end

  # зчитування інформації з yml файлу, перемішування відповідей, формування об'єктів типу Question та добавлення їх до колекції
  def load_from(filename)
    data = YAML.load_file(filename)
    data.each do |raw_question|
      question_body = raw_question['question']
      question_answers = raw_question['answers']
      correct_answer = raw_question['correct_answer']
      question = Question.new(question_body, question_answers, correct_answer)
      @collection << question
    end
  end
end
