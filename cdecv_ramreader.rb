require 'rubygems'
require 'serialport'


def isEOF(str)
  str =~ /:[0-9a-fA-F]{6}01[0-9a-fA-F]*/
end

commands =[]
if (ARGV.size != 1)
  puts "usage:"
  puts "bundle exec ruby cdec_v_ramreader.rb <port_name>"
  puts "example:"
  puts "bundle exec ruby cdec_v_ramreader.rb /dev/ttyS2"

  exit()
end

port_name = ARGV[0]

SerialPort.open(
  port_name,
  baud: 9600 #,
  #data_bits: 8,
  #stop_bits: 1,
  #parity: SerialPort::NONE
  ) do |sp|

  sp.read_timeout = 100
  sp.gets("\r\n")

  commands = [
    "RM:100000",
    "RM:100010",
    "RM:100020",
    "RM:100030",
    "RM:100040",
    "RM:100050",
    "RM:100060",
    "RM:100070",
    "RM:100080",
    "RM:100090",
    "RM:1000A0",
    "RM:1000B0",
    "RM:1000C0",
    "RM:1000D0",
    "RM:1000E0",
    "RM:0F00F0"
  ].each { |line|
    #puts line
    sp.puts line
    puts sp.gets("\r\n")
  }
  puts ':00000001FF'
end