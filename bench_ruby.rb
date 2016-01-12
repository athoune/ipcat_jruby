#!/usr/bin/env ruby --profile.api

require 'ipaddr'
require 'jruby/profiler'

ips = File.open('ip.txt', 'r').readlines.map(&:chomp)

class Datacenters
  def initialize(file)
    @starts = []
    @ends = []
    @urls = []
    File.open(file, 'r').readlines.map do |line|
      add(*line.chomp.split(','))
    end
  end

  def add(start, stop, _name, url = nil)
    @starts << IPAddr.new(start).to_i
    @ends << IPAddr.new(stop).to_i
    @urls << url
  end

  def length
    @starts.length
  end

  def find(ipstring)
    ip = IPAddr.new(ipstring).to_i
    high = length - 1
    low = 0
    while high >= low
      probe = ((high + low) / 2).floor.to_i
      if @starts[probe] > ip
        high = probe - 1
      elsif @ends[probe] < ip
        low = probe + 1
      else
        return @urls[probe]
      end
    end
    nil
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
