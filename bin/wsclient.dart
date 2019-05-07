import 'dart:io';

main() async {
  try{
    var socket = await WebSocket.connect('ws://localhost:20021/ws');

    socket.add('Hello, from WS!');
    
    socket.listen( (msg)=>print("client rec: ${msg}") );

    socket.handleError( (err)=> print("error was: ${err}"));
  }
  catch(error){
    print("an error was made");
  }
}