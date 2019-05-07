// Copyright (c) 2017, Cay. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:core';
import 'dart:async';
import 'dart:io';

// Lazy way of holding WebSockets and Sockets(tcp)
List<dynamic> socketList;

Future<Null> startTcpServer( int port ) async {
  ServerSocket server = await ServerSocket.bind( InternetAddress.LOOPBACK_IP_V6.address, port);
  await for( Socket socket in server ){
    print("tcp connected!");
    socketList.add(socket);
    socket.listen(readMessage); 
  }
}

Future<Null> startWSServer( int port ) async {
    HttpServer server = await HttpServer.bind( InternetAddress.LOOPBACK_IP_V6.address, port);
    await for (var req in server) {
      if (req.uri.path == '/ws') {
        // Upgrade a HttpRequest to a WebSocket connection.
        WebSocket socket = await WebSocketTransformer.upgrade(req);
        print("web socket connected");
        socketList.add( socket );
        socket.listen(readMessage);
      };
    }
}

void readMessage(dynamic data) {
  String response;
  if( data is List<int> ){
    // binary (usually TCP)
    String result = new String.fromCharCodes(data);
    response = result.substring(0, result.length - 1);
    print("Binary:${response}");
  }  
  else if( data is List<String> ){
    // strings (only WebSock)
    response = data.toString();
    print("String List..: ${response}");
  }
  else if( data is String ){
    //WebSock only
    response = data;
    print("String: ${data}");
  }
  
  // Yell at everyone what someone said
  broadcast( response );
}

void broadcast(String message){
  for( var socket in socketList ){
    if( socket is WebSocket ){
      socket.add( message );
    }
    else if( socket is Socket ){
      socket.add( message.codeUnits );
    }
  }
}

void startServer(){
  socketList = [];
  startTcpServer(20020);
  print("listening to tcp connections: 20020");
  startWSServer(20021);
  print("listening to ws connections: ws://xx:20021");
}