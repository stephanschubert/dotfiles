if defined?(PryDebugger) or defined?(Byebug)
  Pry.commands.alias_command 'c', 'continue'
  Pry.commands.alias_command 's', 'step'
  Pry.commands.alias_command 'n', 'next'
  Pry.commands.alias_command 'f', 'finish'
  Pry.commands.alias_command 'b', 'break'

  Pry::Commands.command(/^$/, "repeat last command") do
    _pry_.input = StringIO.new(Pry.history.to_a.last)
  end
end

# require "rubygems"
# require "awesome_print"
# AwesomePrint.pry!

Pry.config.editor = proc { |file, line| "emacsclient -nw -c +#{line} #{file}" }

# Pry prints [0G right after start?
Pry.config.correct_indent = false if ENV["EMACS"]
