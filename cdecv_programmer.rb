require 'rubygems'
require 'serialport'


def isEOF(str)
  str =~ /:[0-9a-fA-F]{6}01[0-9a-fA-F]*/
end


if (ARGV.size != 2)
  puts "usage:"
  puts "$ bundle exec ruby cdecv_programmer.rb <port_name> <file_name>"
  puts "example:"
  puts "$ bundle exec ruby cdecv_programmer.rb /dev/ttyS2 hexfile_sample/bitcount_test.hex"

  exit()
end

port_name = ARGV[0]
file_name = ARGV[1]

SerialPort.open(
  port_name,
  baud: 9600,
  data_bits: 8,
  stop_bits: 1,
  parity: SerialPort::NONE
  ) do |sp|

  sp.read_timeout = 100
  sp.gets("\r\n")

  File.open(file_name) do |file|
    file.each_line do |line|
      break if isEOF(line)
      puts 'WM' + line
      sp.puts 'WM' + line
      sp.gets("\r\n")
    end
  end

  puts "DONE"

end

# sp.puts "PC"
# line = sp.gets("\r\n")
# puts line


