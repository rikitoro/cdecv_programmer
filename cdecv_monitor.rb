require 'rubygems'
require 'serialport'
require 'json'

def isEOF(str)
  str =~ /:[0-9a-fA-F]{6}01[0-9a-fA-F]*/
end

commands =[]
if (ARGV.size != 1)
  puts "usage:"
  puts "bundle exec ruby cdecv_monitor.rb <port_name>"
  puts "example:"
  puts "bundle exec ruby cdecv_monitor.rb /dev/ttyS2"

  exit()
end

port_name = ARGV[0]

monitor_data = {};

SerialPort.open(
  port_name,
  baud: 9600 ,
  data_bits: 8,
  stop_bits: 1,
  parity: SerialPort::NONE
  ) do |sp|

  sp.read_timeout = 100
  sp.gets("\r\n") #

  [
    ["PC", "PC"],
    ["RA", "A"],
    ["RB", "B"],
    ["RC", "C"],
    ["RT", "T"],
    ["RR", "R"],
    ["FL", "FLG"],
    ["XB", "Xbus"],
    ["MA", "MA"],
    ["WD", "WD"],
    ["RD", "RD"],
    ["RI", "I"]
  ].each { |command, signal_name|
    #puts line
    sp.puts command
    monitor_data[signal_name] = sp.gets("\r\n")[11..12]
  }

  [
    ["XS", "xsrc"]
  ].each { |command, signal_name|
    sp.puts command
    monitor_data[signal_name] = sp.gets("\r\n")[11..12].to_i.to_s(2).rjust(3, '0')
  }

  [
    ["XD", "xdst"]
  ].each { |command, signal_name|
    sp.puts command
    monitor_data[signal_name] = sp.gets("\r\n")[11..12].to_i.to_s(2).rjust(10, '0')
  }

  [
    ["OP", "aluop"]
  ].each { |command, signal_name|
    sp.puts command
    monitor_data[signal_name] = sp.gets("\r\n")[12].to_i.to_s(2).rjust(4, '0')
  }

  [
    ["CC", "cycle"]
  ].each { |command, signal_name|
    sp.puts command
    monitor_data[signal_name] = sp.gets("\r\n")[9..12]
  }



  puts monitor_data.to_json
end

