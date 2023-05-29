require_relative 'quiz'

Quiz.config do |quiz|
  quiz.yaml_dir = 'yml'
  quiz.in_ext = '.yml'
  quiz.answers_dir = 'answers'
end
