class Question < ActiveRecord::Base
  belongs_to :poll
  has_many :responses
  has_many :choices

  validates :poll_id, :text, :presence => :true
  attr_accessible :poll_id, :text
end

# SELECT poll.*
# FROM poll
# WHERE poll.id = Question.poll_id

# SELECT responses.*
# FROM responses
# WHERE question_id = Question.id

# SELECT choises.*
# FROM choises
# WHERE question_id = Question.id