class ApplicationController < ActionController::Base
  protect_from_forgery
  
  private
  def connect_irc
    return if $socket
    require 'socket'
    $socket = TCPSocket.new 'localhost', 6667
    $socket.puts "NICK acm-qdb"
    $socket.puts "USER acm-qdb * * :The Univ. of Akron Student ACM Chapter QDB"
    
    Thread.new do
      while line = $socket.gets.strip
        puts line
        if line =~ /^PING/
          $socket.puts line.sub('I', 'O')
        elsif line.split[1] == '376'
          $socket.puts "JOIN #uakroncs"
        elsif line =~ /:!inspect (\d+)/
          quote = Quote.find_by_id($1)
          if not quote.nil?
            log quote.inspect
          end
        end
      end
    end

  end

  def log(message, channel="#uakroncs")
    connect_irc
    $socket.puts "PRIVMSG #{channel} :#{message}"
  end
end
