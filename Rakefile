require 'ant'

task :javac do
  ant.mkdir :dir => "classes/org/ipcat"
  ant.javac :srcdir => "src", :destdir => "classes",
            :source => "1.7", :target => "1.7", :debug => "no",
            :includeantruntime => "no"
end
