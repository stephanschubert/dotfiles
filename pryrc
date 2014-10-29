if defined?(PryDebugger) or defined?(Byebug)
  Pry.commands.alias_command 'c', 'continue'
  Pry.commands.alias_command 's', 'step'
  Pry.commands.alias_command 'n', 'next'
  Pry.commands.alias_command 'f', 'finish'
  Pry.commands.alias_command 'b', 'break'

  Pry::Commands.command /^$/, "repeat last command" do
    _pry_.input = StringIO.new(Pry.history.to_a.last)
  end
end

require 'awesome_print'
AwesomePrint.pry!
