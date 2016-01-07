require 'ipaddr'

module IPCat
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
      high = length
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
end
