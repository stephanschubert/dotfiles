require "rubygems"
require "pp"

# sudo gem install wirble
require "wirble"

colors = Wirble::Colorize.colors.merge({
  # delimiter colors
  :comma              => :blue,
  :refers             => :blue,

  # container colors (hash and array)
  :open_hash          => :green,
  :close_hash         => :green,
  :open_array         => :green,
  :close_array        => :green,

  # object colors
  :open_object        => :light_red,
  :object_class       => :white,
  :object_addr_prefix => :blue,
  :object_line_prefix => :blue,
  :close_object       => :light_red,

  # symbol colors
  :symbol             => :yellow,
  :symbol_prefix      => :yellow,

  # string colors
  :open_string        => :red,
  :string             => :light_red,
  :close_string       => :red,

  # misc colors
  :number             => :red,
  :keyword            => :green,
  :class              => :light_green,
  :range              => :red,
})

Wirble::Colorize.colors = colors
Wirble.init
Wirble.colorize


# Easily print methods local to an object's class

class Object
  def local_methods
    (methods - Object.instance_methods).sort
  end
end

# Log to STDOUT if in Rails

if ENV.include?("RAILS_ENV") && !Object.const_defined?("RAILS_DEFAULT_LOGGER")
  require "logger"
  RAILS_DEFAULT_LOGGER = Logger.new(STDOUT)
end
