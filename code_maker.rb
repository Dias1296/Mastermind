require "./code_display"

module Code_Maker

    include Code_Display

    def start_code_maker
        while true
            secret_code = input_secret_code
            computer_turn(secret_code)
            puts
            puts 'Would you like to play again? [Y/N]'
            if gets.chomp.upcase != 'Y'
                break
            end
        end
        
    end

    def input_secret_code
        puts "Choose your secret code"
        while true
            secret_code = gets.chomp
            case 
                when secret_code.to_i == 0
                    puts "Invalid secret code!"
                when secret_code.length != 4
                    puts "Your secret code must be 4 digits long!"
                when secret_code.split('').any? { |name| name.to_i < 1 || name.to_i > 6}
                    puts "Invalid digits. Use numbers between 1-6"
                else
                    break
                end
        end
        return secret_code.to_i
    end

    def computer_turn(secret_code)
        turn = 1
        all_combinations = [1,2,3,4,5,6].repeated_permutation(4).to_a
        p all_combinations.length
        result = computer_first_turn(secret_code, all_combinations)
        if result == ["M", "M", "M", "M"]
            puts "The computer has cracked the code"
        else
            filtered_combinations = Swaszek_algorithm_strategy(secret_code, 1122, all_combinations)
            while true
                turn += 1
                if turn == 13
                    puts "The Computer has run out of turns. YOU WIN!"
                    break
                end
                guess = filtered_combinations[0].join.to_i
                filtered_combinations.delete_at(0)
                puts "TURN NUMBER #{turn}:"
                result = compare_codes(guess, secret_code)
                if result == ['M', 'M', 'M', 'M']
                    puts "The Computer has guessed #{guess}"
                    puts "THE COMPUTER HAS CRACKED THE CODE"
                    break
                else
                    filtered_combinations = Swaszek_algorithm_strategy(secret_code, guess, filtered_combinations)
                    puts "The Computer has guessed #{guess}"
                    symbol_array = Array.new
                    result.each{ |symbol| 
                        if symbol == 'M'
                            symbol_array << "\e[91m\u25CF\e[0m "
                        elsif symbol == 'C'
                            symbol_array << "\e[37m\u25CB\e[0m "
                        end
                        }
                    puts "Result: #{guess} #{symbol_array.join}"
                    puts
                end
            end
        end
    end

    def computer_first_turn(secret_code, all_combinations)
        symbol_array = Array.new
        guess = 1122
        puts "TURN NUMBER 1:"
        puts "The computer has guessed #{guess}"
        result = compare_codes(guess, secret_code)
        result.each{ |symbol| 
            if symbol == 'M'
                symbol_array << "\e[91m\u25CF\e[0m "
            elsif symbol == 'C'
                symbol_array << "\e[37m\u25CB\e[0m "
            end
            }
        puts "Result: #{guess} #{symbol_array.join}"
        return result
    end

    def Swaszek_algorithm_strategy(secret_code, guess, filtered_combinations)
        result = compare_codes(guess, secret_code)
        #S = Filtered combinations (first turn is all possible combinations to guess the code)
        #Each turn remove from S any code that would give the same response if the guess were the code
        #Next turn choose the first sample from the filtered combinations
        filtered_combinations = filtered_combinations.filter { |i|
            compare_codes(guess, i.join.to_i).join == result.join
        }
        return filtered_combinations
    end
end