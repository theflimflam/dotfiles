# frozen_string_literal: true

# See https://gist.github.com/lfender6445/9919357

# Full stacktrace
# https://github.com/pry/pry/issues/1495
Pry.config.exception_handler = proc do |output, exception, _pry_|
  output.puts "#{exception}"
  output.puts %Q<#{exception.backtrace.join("\n")}>
end
