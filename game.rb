require "./game_instructions" #Include the file with game instructions
require "./code_breaker"
require "./code_maker"

class Game

    include GameInstructions #Include GameInstruction module in the game instructions file
    include Code_Breaker
    include Code_Maker
    
    def start_game
        puts instructions #Print out the game instruction
        case get_game_mode
        when 1
            start_code_breaker
        when 2
            start_code_maker
        end
    end

    private

    def get_game_mode
        @game_mode = gets.chomp
        case 
        when @game_mode.upcase == 'B'
            return 1
        when @game_mode.upcase == 'M'
            return 2
        end
        get_game_mode
    end
end
