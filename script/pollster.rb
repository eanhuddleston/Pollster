class Pollster
  @user = nil

  def self.login
    puts "Please enter your username:"
    username = gets.chomp
    @user = User.find_or_create_by_name(username)
  end

  def self.menu
    self.login

    options = { 1 => :create_poll, 2 => :create_question,
          3 => :answer_question, 4 => :display_poll_responses,
          5 => :display_user_responses, 6 => :delete_question }

    userinput = ""
    until userinput == "exit"
      puts ""
      puts "please enter:"
      puts "1. Create poll"
      puts "2. Add question"
      puts "3. Answer a poll question"
      puts "4. See poll results"
      puts "5. See all your poll responses"
      puts "6. Delete a poll question"
      puts "7. Exit"

      userinput = gets.chomp
      break if userinput == "7"
      self.send( options[userinput.to_i] )
    end
  end

  def self.delete_question
    chosen_poll = self.select_poll
    puts "Please choose question to delete:"
    questions = Question.where(:poll_id => chosen_poll)
    questions.each_with_index do |question, index|
      puts "#{index}: #{question.text}"
    end
    choice = gets.chomp.to_i
    questions[choice].destroy
    puts "Deleted question, responses and all choices"
  end

  def self.display_user_responses
    choices_hash = self.create_choices_hash
    polls = @user.get_all_responses
    polls.each do |poll|
      puts "Poll: #{poll.title}"
      poll.questions.each do |question|
        puts "Question: #{question.text}"
        question.responses.each do |response|
          puts "#{choices_hash[response.choice_id]}"
        end
      end
    end
  end

  def self.create_choices_hash
    choices = Choice.all
    choices_hash = {}
    choices.each do |choice|
      choices_hash[choice.id] = choice.value
    end

    choices_hash
  end

  def self.display_poll_responses
    chosen_poll = self.select_poll
    results = Poll.get_results(chosen_poll)
    choices_hash = self.create_choices_hash
    results.each do |result|
      counts = result.responses.group(:choice_id).count(:user_id)
      puts "#{result.text}:"
      counts.each do |key, value|
        puts "#{choices_hash[key]}: #{value}"
      end
    end
  end

  def self.answer_question
    chosen_poll = self.select_poll
    puts "Please choose question:"
    questions = Question.where(:poll_id => chosen_poll)
    questions.each_with_index do |question, index|
      puts "#{index}: #{question.text}"
    end
    question_choice = gets.chomp.to_i
    poss_choices = Choice.where(:question_id =>
        questions[question_choice].id)
    puts "Please select answer:"
    poss_choices.each_with_index do |choice, index|
      puts "#{index}: #{choice.value}"
    end
    user_choice = gets.chomp.to_i
    Response.create!(:user_id => @user.id,
        :choice_id => poss_choices[user_choice].id,
        :question_id => questions[question_choice].id)
    puts "Response logged"
  end

  def self.create_poll
    puts "Enter poll title:"
    title = gets.chomp
    Poll.create!(:title => title, :user_id => @user.id)
  end

  def self.select_poll
    puts "Please choose poll:"
    polls = Poll.all
    polls.each_with_index do |poll|
      puts "#{poll.id}: #{poll.title}"
    end

    gets.chomp.to_i
  end

  def self.create_question
    chosen = self.select_poll
    puts "Enter question to add to poll:"
    question = gets.chomp
    q = Question.create!(:poll_id => chosen, :text => question)
    self.create_choices(q.id)
  end

  def self.create_choices(question_id)
    while true
      puts "Enter a possible response for your question"
      puts "or 'f' when finished:"
      choice = gets.chomp
      break if choice == 'f'
      Choice.create!(:question_id => question_id,
          :value => choice)
    end
  end
end

Pollster.menu