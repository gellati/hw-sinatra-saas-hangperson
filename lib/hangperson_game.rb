class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  attr_accessor :word, :wrong_guesses, :guesses
  
  def initialize(word)
    @word = word.downcase
    @guesses = ""
    @wrong_guesses = ""
  end

  def guess(letter)
    raise ArgumentError.new('no empty') if letter.to_s.empty?
    raise ArgumentError.new('letters only') if letter =~ /\W/
    ld = letter.downcase
    if @guesses.include? ld or @wrong_guesses.include? ld
      false
    else               # do not pass to guesses method, check here instead
      if @word.include? ld
        @guesses += ld
      else
        @wrong_guesses += ld
      end
      true
    end
  end


  def check_win_or_lose
    if @wrong_guesses.length < 7 
      if self.word_with_guesses.include? '-'
        @check_win_or_lose = :play # 'play' , use symbol, not string
      else
        @check_win_or_lose = :win
      end
    else 
      @check_win_or_lose = :lose
    end    
  end

  def word_with_guesses
    @word.gsub(/[^ #{@guesses}]/, '-')
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


#g = HangpersonGame.new('glorp')
#g.guess('a')
#g.guess('a')
#g.guess('a')
#g.guesses
#g.wrong_guesses
#g.word
#puts '<end>'
