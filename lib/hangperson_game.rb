class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  attr_accessor :word, :wrong_guesses, :guesses, :check_win_or_lose
  
  def initialize(word)
    @word = word.downcase
    @guesses = ""
    @wrong_guesses = ""
    @check_win_or_lose = :play
  end
  
  def guess(letter)
    raise ArgumentError.new('No empty letters please') if letter.to_s.empty?
    raise ArgumentError.new('Invalid letter') if letter =~ /\W/
    lc = letter.downcase
    if @wrong_guesses.include? lc or @guesses.include? lc
      false
    else
      if @word.include? lc
        @guesses += lc
      else
        @wrong_guesses += lc
      end
      true
    end
  end
  
  def check_win_or_lose
    if @wrong_guesses.length < 7
      if word_with_guesses.include? '-'
        @check_win_or_lose = :play
      else
        @check_win_or_lose = :win
      end
    else
      @check_win_or_lose = :lose
    end
  end
  
  def word_with_guesses
    word.gsub(/[^ #{@guesses}]/, '-')
  end
  
  

  # You can test it by running $ bundle exec irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> HangpersonGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.new('watchout4snakes.com').start { |http|
      return http.post(uri, "").body
    }
  end

end
