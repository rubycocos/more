
# 3rd party gems/libs

require 'textutils'


# our own code

require 'about/version'  # let it always go first


module About

  def self.root
    "#{File.expand_path( File.dirname(File.dirname(__FILE__)) )}"
  end

end  # module About


require 'about/server'
