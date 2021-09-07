module Code_Display

    def compare_codes(breaker_code, secret_code)
        #Compare_codes
        secret_array = secret_code.digits.reverse
        breaker_array = breaker_code.digits.reverse
        match = get_matching_digits(breaker_array, secret_array)
        return match
        #Return an array with symbols that say if your code is correct and what digits match
    end

    def get_matching_digits(breaker, secret) #Get the guessed digits that are in the same place as the secrete code
        matching = secret.each_with_index.filter_map { |digit, index| digit if digit == breaker[index]}
        containing = (breaker-matching).each_with_index.filter_map { |digit, index| digit if (secret-matching).include? digit }
        code_match = Array.new()
        matching.each {|digit| code_match << 'M'}
        containing.each { |digit| code_match << 'C'}
        return code_match
    end

end