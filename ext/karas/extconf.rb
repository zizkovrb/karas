# Loads mkmf which is used to make makefiles for Ruby extensions
require 'mkmf'

$CFLAGS = "-Wall"

# Give it a name
extension_name = 'karas'

# The destination
dir_config(extension_name)

config = "php-config"

prefix = `#{config} --prefix`.chomp

php_inc, php_lib = dir_config("php5", "#{prefix}/include", "#{prefix}/lib")

$INCFLAGS = "-I#{File.join(php_inc, "php").quote} #{$INCFLAGS}"

%w{ Zend TSRM main }.each do |dir|
  $INCFLAGS = "-I#{File.join(php_inc, "php", dir).quote} #{$INCFLAGS}"
end

unless find_library("php5", "php_embed_init", php_lib)
  abort "php is missing!"
end

# Do the work
create_makefile(extension_name)
