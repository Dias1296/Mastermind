require "./code_display"

module Code_Breaker

    include Code_Display

    def start_code_breaker
        while true
            turn = 0
            secret_code = generate_secret_code
            puts
            puts 'The secret code has been generated! It is time to break it.'
            code_breaker_turn(turn, secret_code)
            puts "Would you like to play again?! [Y/N]"
            if gets.chomp.upcase != 'Y'
                break
            end
        end
    end

    def generate_secret_code
        return Array.new(4) { rand(1..6) }.join.to_i #New array with random numbers between 1 and 6
    end

    def code_breaker_turn(turn, secret_code)
        while true
            turn += 1
            if turn == 13
                puts 'You have played 12 turns and failed to find the secret code.'
                puts "The secret code was #{secret_code}"
                break
            end
            puts "Turn number: #{turn}"
            while true
                puts "Try and guess the secret code..."
                guess_code = gets.chomp
                if check_code_valid(guess_code) == 1
                    break
                end
            end
            check_array = compare_codes(guess_code.to_i, secret_code)
            if check_array == ["M", "M", "M", "M"]
                puts "YOU HAVE CRACKED THE CODE"
                break
            else
                symbol_array = Array.new
                puts "Your guess:"
                puts check_array
                check_array.each { |symbol| 
                    if symbol == 'M'
                        symbol_array << "\e[91m\u25CF\e[0m "
                    elsif symbol == 'C'
                        symbol_array << "\e[37m\u25CB\e[0m "
                    end
                }
                puts "#{guess_code} #{symbol_array.join}"
                puts "Try again!"
                puts 
            end
        end
    end

    def check_code_valid(code_guessed)
        case
        when code_guessed.to_i == 0
            puts "Not a number!"
            return 0
        when code_guessed.length != 4
            puts "Invalid code size! Guess again!"
            return 0
        when code_guessed.split('').any? { |name| name.to_i < 1 || name.to_i > 6}
            puts "Invalid digits. Use numbers between 1-6"
            return 0
        else
            return 1
        end
    end
end