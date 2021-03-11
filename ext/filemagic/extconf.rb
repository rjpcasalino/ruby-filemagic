require 'mkmf'
# see: https://nixos.wiki/wiki/Ruby#Trouble_with_native_dependencies
HEADER_DIRS = [
]

LIB_DIRS = [
]

$CFLAGS << ' -Wall' if ENV['WALL']
$LDFLAGS << ' -static-libgcc' if RUBY_PLATFORM =~ /cygwin|mingw|mswin/

dir_config('magic', HEADER_DIRS, LIB_DIRS)
dir_config('gnurx', HEADER_DIRS, LIB_DIRS)

have_library('gnurx')

if have_library('magic', 'magic_open') && have_header('magic.h')
  have_func('magic_version')
  have_header('file/patchlevel.h')
  create_makefile('filemagic/ruby_filemagic')
else
  abort '*** ERROR: missing required library to compile this module'
end
