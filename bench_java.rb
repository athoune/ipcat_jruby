#!/usr/bin/env ruby --profile.api

require 'java'
require 'jruby/profiler'
require 'ipaddr'

$LOAD_PATH << './lib'
require 'ipcat.jar'

ips = File.open('ip.txt', 'r').readlines.map(&:chomp)

class Datacenters
  def initialize(file)
    @urls = []
    @blocks = org.ipcat.Blocks.new
    File.open(file, 'r').readlines.map do |line|
      add(*line.chomp.split(','))
    end
  end

  def add(start, stop, _name, url = nil)
    @urls << url
    @blocks.add IPAddr.new(start).to_i, IPAddr.new(stop).to_i
  end

  def find(ipstring)
    n = @blocks.find(org.ipcat.IP.parseIp(ipstring))
    return @urls[n] unless n == -1
  end
end

d = Datacenters.new('datacenters.csv')
cpt = 0
profile_data = JRuby::Profiler.profile do
  (1..10_000).each do
    ips.each do |ip|
      cpt += 1 if d.find(ip)
    end
  end
end

profile_printer = JRuby::Profiler::GraphProfilePrinter.new(profile_data)
profile_printer.printProfile(STDOUT)
p cpt
