#froze_string_literal: true

module GameInstructions
    def instructions 
        <<-HEREDOC
*-----*Mastermind*-----*

Welcome to Mastermind!

Mastermind is a codebraking 1vs1 game against the computer.
You can choose to be the CODEMAKER or the CODEBREAKER!

As the CODEMAKER you must build a 4-digit code with numbers between 1-6. 
The computer will try to break the code within 12 rounds

As the CODEBREAKER your job will be the opposite!
You will try to break the code built by the computer within the 12 rounds.

Game flow: 
Each round you try and guess the 4-digit code by typing your guess on the console.
The game will respond for each digit with: 
\e[91m\u25CF\e[0m  -> Digit is in the secret code and in the right position
\e[37m\u25CB\e[0m  -> Digit is in the secret code but not in the right position
[No Symbols] -> Digit not in the secret code

Example:
Secret code: 1234
Your guess: 1326
Game response to your play: 1326 \e[91m\u25CF\e[0m \e[37m\u25CB\e[0m \e[37m\u25CB\e[0m 

So, do you wanna be the CODEBREAKER[B] or the CODEMAKER?[M]  [B/M]

        HEREDOC
    end
end
