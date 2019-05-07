import 'dart:io';

main() async {
  try{
    var socket = await Socket.connect(InternetAddress.LOOPBACK_IP_V6, 20020);
    
    socket.add("Hello, from tcp!".codeUnits);
    
    socket.listen( (msg)=>print("tcp client rec: ${new String.fromCharCodes(msg)}") );

    socket.handleError( (err)=> print("error was: ${err}"));
  }
  catch(error){
    print("an error was made");
  }
}