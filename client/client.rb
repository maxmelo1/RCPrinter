# Open a socket to a local daytime server, read, and print.
require 'socket'

host = "localhost";
port = 5678;

begin

	s = TCPSocket.open(host, port)

	file_name = gets.chomp
	file      = File.new(file_name, "r")
	size  	  = File::size(file_name)
	bytes 	  = file.read(size)

	s.puts(file_name)
	s.puts(size.to_s)
	s.syswrite(bytes)

	while line = s.gets
		puts line.chop
	end
ensure
	s.close
	file.close
end