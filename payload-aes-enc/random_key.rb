#!/usr/bin/env ruby

KEY_SIZE = 6
KEY_RANGE = 10

print "key128 db "
KEY_SIZE.times { |x| print "0x%02x," % rand(KEY_RANGE) }
print "%d dup (0x00)\n" % (16 - KEY_SIZE)

