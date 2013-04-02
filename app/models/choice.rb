class Choice < ActiveRecord::Base
  belongs_to :question

  validates :question_id, :value, :presence => :true
  attr_accessible :question_id, :value
end

# SELECT questions.*
# FROM questions
# WHERE choices.question_id = questions.id