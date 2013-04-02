class User < ActiveRecord::Base
  has_many :polls
  has_many :responses
  has_many :questions, :through => :polls

  validates :name, :presence => :true
  validates :name, :uniqueness => :true
  attr_accessible :name

  def find_or_create_by_name(username)
    @user = User.where(:name => username)[0]
    if @user.nil?
      @user = User.create(:name => username)
    end
    @user
  end
end

# SELECT polls*
# FROM polls
# WHERE user_id = User.id

# SELECT responses*
# FROM responses
# WHERE user_id = User.id
#
# SELECT questions*
# FROM polls JOIN questions
# ON poll.id = questions.poll_id
# WHERE poll.user_id = User.id