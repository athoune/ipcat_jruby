#!/usr/bin/env ruby --profile.api

require 'jruby/profiler'

$LOAD_PATH << './lib'
require 'ipcat'

ips = File.open('ip.txt', 'r').readlines.map(&:chomp)

d = IPCat::Datacenters.new('datacenters.csv')
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
