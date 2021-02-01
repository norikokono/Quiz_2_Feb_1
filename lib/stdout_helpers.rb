module Stdout
    def self.progress_bar(complete_val, current_val, indicator = "=")
      current_val = current_val + 1
      current_val = current_val.to_f
      complete_val = complete_val.to_f
      current_percent = (current_val / complete_val * 100).ceil
      # \r in text means return to front of the line. This is how you can log information on the terminal without having to move to a new line
      # printf is a method like p or puts but with more features.
      printf("\r#{yield}: [%-100s] %%#{current_percent}", "#{indicator}" * current_percent)
      if current_val == complete_val
        # \b in text means backspace. We can delete characters relative to the cursor location using this technique
        # \e[32m is
        return puts "\b\b\b\b\b \e[32mdone\e[0m"
      end
    end
  end