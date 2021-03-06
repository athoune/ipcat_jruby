require 'java'
require 'ipcat.jar'

include_class 'java.lang.NumberFormatException'

module IPCat
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
      @blocks.add org.ipcat.IP.parseIp(start), org.ipcat.IP.parseIp(stop)
    end

    def find(ipstring)
      return nil if ipstring.nil?
      begin
        n = @blocks.find(org.ipcat.IP.parseIp(ipstring))
        return @urls[n] unless n == -1
      rescue NumberFormatException => e
        return nil
      end
    end

    def length
      @starts.length
    end
  end
end
