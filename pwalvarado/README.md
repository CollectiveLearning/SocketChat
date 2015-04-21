# SocketChat

This is simple chat server application that can serve a large and scalable number of clients. By the reading of the source code, you will
know how to use the standard Sockets class to build both client and server applications, as well as how to use classes that simplify sockets programming, including TCPSocket and TCPServer.

    +--------------+           +-------------+
    |              |           |             |
    |   Client A   +----------->             |
    |              |           |             |
    +--------------+           |             |
                               |             |
    +--------------+           |             |
    |              |           |             |
    |   Client B   <-----------+   Server    |
    |              |           |             |
    +--------------+           |             |
                               |             |
    +--------------+           |             |
    |              |           |             |
    |   Client C   <-----------+             |
    |              |           |             |
    +--------------+           +-------------+

### Features

1. Connect to chat with a nickname.
2. List users connected.
3. Send public messages.
4. Send private messages.
5. Disconnect from server.
6. Show help message.

### References

* [Ruby Socket Programming - TutorialsPoint](http://www.tutorialspoint.com/ruby/ruby_socket_programming.htm)
* [Ruby TCP Chat - SitePoint](http://www.sitepoint.com/ruby-tcp-chat/)
* [Sockets programming in Ruby](https://www6.software.ibm.com/developerworks/education/l-rubysocks/l-rubysocks-a4.pdf)

### Trying Things Out

To try things out, you’ll need three or more windows. In window 1, start up server chat ``ruby server.rb <ip> <port>``:

  $ ruby server.rb "localhost" 3300

Then, in window 2 and 3, connect to server ``ruby client.rb <ip> <port>``, enter a nickname, wait for others enter to chat room, then chat!

Window 2

  $ ruby client.rb "localhost" 3300
  Enter the username:
  carlinno
  Connection established, Thank you for joining! Happy chatting
  Hi
  peter: Hello

Window 3

  $ ruby client.rb "localhost" 3300
  Enter the username:
  carlinno
  Connection established, Thank you for joining! Happy chatting
  Hi
  peter: Hello

In window 1, you will see:

  $ ruby server.rb "localhost" 3300
  peter #<TCPSocket:0x0000000091d228>
  carlinno #<TCPSocket:0x0000000091ccb0>