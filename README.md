# multi-platform Echo

A small project demonstrating the simplicity of running an echo server that works 
with both TCP and WebSockets in unison. 

<i> Was originally going to be a chat, but I saw no benefit in that over a simple echo server. </i>

## Usage

Once cloned, simply open in V.S. Code and start the server then the clients from the debugger or 
run them each in the command line.  

The main code for handling tcp/websocks are in the src folder.

The server and respective clients are found in bin.

### USE NOTE:
This was made in Dart 1, not 2.

## Features and bugs

Currently demonstrates how easy and convenient the standard Dart packages makes it to run a server that can
talk between TCP and WebSockets.

- Bare-bones (+)
- Does not handle errors (-)
- Does not handle disconnections from clients (-)
- Does not handle the server randomly shutting down (-)

## Requests / ETC
Feel free to request additional features, to support the above, point out problems, or suggest
improvements to the overall code. Look no further than creating an issue! Thank you.