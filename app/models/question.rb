class Question < ActiveRecord::Base
  belongs_to :poll
  has_many :responses, :dependent => :destroy
  has_many :choices, :dependent => :destroy

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

# REV: May need :dependent => :destroy