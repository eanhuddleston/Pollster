class Response < ActiveRecord::Base
  belongs_to :question
  belongs_to :user

  validates :user_id, :choice_id, :presence => :true
  attr_accessible :user_id, :choice_id, :question_id
end

# SELECT questions.*
# FROM questions
# WHERE responses.question_id = questions.id
#
# SELECT user.*
# FROM users
# WHERE responses.user_id = users.id