require 'socket'               # Get sockets from stdlib

server = TCPServer.open(2000)  # Socket to listen on port 2000
contador = 0
loop {                         # Servers run forever
  client = server.accept       # Wait for a client to connect
  client.puts(Time.now.ctime)  # Send the time to the client
  client.puts "La conexion esta abierta en el puerto 2000 del servidor \ny se ve reflejada el mensaje en el socket abierto por el cliente"
  puts "Mensaje del servidor Notificando cuantas veces entraron \nHan entrado: #{contador += 1} ve(z)(ces)"
  client.puts "The server has closed the connection. Bye!"
  client.close                 # Disconnect from the client
}
