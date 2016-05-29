# Open a socket to a local daytime server, read, and print.
require 'socket'
require 'cups'

server = TCPServer.open(5678);
loop{
	client = server.accept
	#msg = client.recvfrom( 1000 ) #em bytes
	#puts "msg: #{msg}"

	begin
		file_name 	= client.gets.chomp
		size		= client.gets.chomp.to_i
		bytes		= client.read(size)

		file		= File.new("copia_#{file_name}","wb")
		file.syswrite(bytes)
		
		client.puts(Time.now.ctime)

	ensure
		page = Cups::PrintJob.new("copia_#{file_name}")
		job_id = page.print # => 127

		client.puts("printing document, server job id = #{job_id}")
		client.puts("bye bye")
		
		client.close
	end
}