class Poll < ActiveRecord::Base
  belongs_to :user
  has_many :questions
  has_many :responses, :through => :questions

  validates :title, :presence => :true
  attr_accessible :title, :user_id

  def Poll.get_results(poll_id)
    p = Poll.find(poll_id)
    p.questions.includes(:responses)
  end
end

# SELECT user
# FROM users
# WHERE Poll.user_id = users.id
#
# SELECT questions.*
# FROM questions
# WHERE questions.poll_id = Poll.id
#
# SELECT responses*
# FROM responses JOIN questions
# ON responses.question_id = questions.id
# WHERE questions.poll_id = Poll.id