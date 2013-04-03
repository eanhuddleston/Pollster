class Response < ActiveRecord::Base
  belongs_to :question
  belongs_to :user

  validates :user_id, :choice_id, :presence => :true
  validate :user_has_not_responded, :user_is_not_question_creator
  attr_accessible :user_id, :choice_id, :question_id

  def user_has_not_responded
    if Response.where(:question_id => question_id,
        :user_id => user_id)
      errors[:number_answers] << "Can only answer each question once"
    end
  end

  def user_is_not_question_creator
    question = Question.find(question_id)
    poll = Poll.find(question.poll_id)
    if poll.user_id == user_id
      errors[:created_poll] << "Poll creator cannot answer question in that poll"
    end
  end
end



# SELECT questions.*
# FROM questions
# WHERE responses.question_id = questions.id
#
# SELECT user.*
# FROM users
# WHERE responses.user_id = users.id