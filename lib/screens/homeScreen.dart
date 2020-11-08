import 'dart:math';
import 'package:flutter/material.dart';
import 'package:mandado_express_dev/services/authService.dart';

// Lib
import 'package:provider/provider.dart';

// Theme
import 'package:mandado_express_dev/theme/colors.dart';

// Helpers
import 'package:mandado_express_dev/helpers/helpers.dart';

// Service
import 'package:mandado_express_dev/services/roomService.dart';

// Models
import 'package:mandado_express_dev/models/responses/roomResponse.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final roomService = Provider.of<RoomService>(context);
    
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: CustomColors.black,
        title: Text('Chats', style: TextStyle( color: Colors.white, fontWeight: FontWeight.w800, fontSize: 28.0)),
        leading: IconButton(
          icon: Icon( Icons.exit_to_app, color: Colors.white ),
          onPressed: (){
            Navigator.pushReplacementNamed(context, 'login');
            AuthService.deleteToken();
          },
        ),
        actions: <Widget>[
          
        ],
      ),
      body: FutureBuilder(
        future: roomService.getRooms(),
        builder: (BuildContext context, AsyncSnapshot<List<RoomResponse>> snapshot) {
          if (snapshot.hasData){
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: ( context, i ) => CustomListItem( room: snapshot.data[i] )
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          print("object");
        }, 
        backgroundColor: CustomColors.black,
        child:IconButton(
          icon: Icon( Icons.add, color: Colors.white ),
          onPressed: () async {
            Navigator.pushNamed(context, 'delivery');
          },
        ),
      ),
    );
  }
}



class CustomListItem extends StatelessWidget {

  final String id = getRandString(10);
  final int avatarNumber = new Random().nextInt(10);
  final int number = new Random().nextInt(20);
  final RoomResponse room;

  CustomListItem({ @required this.room });

  @override
  Widget build(BuildContext context) {
    final listItem = Container(
      padding: EdgeInsets.symmetric( horizontal: 10.0, vertical: 10.0 ),
      child: Row(
        children: <Widget>[
          AvatarCircle( id: id, name: room.name, ),
          Expanded( child: TextItem( name: room.name, message: room.message?.body?? "No text found" ) ),
          EndItem( number: number )
        ],
      ),
    );
    return GestureDetector(
      onTap: () async {
        final roomService = Provider.of<RoomService>(context, listen: false );
        final roomResponse = await roomService.getRoom( room.id );
        if ( roomResponse ){
            Navigator.pushReplacementNamed(context, 'chat');
        }
      },
      child: listItem,
    );
  }
}

class AvatarCircle extends StatelessWidget {

  final int number = new Random().nextInt(20);
  final String name;
  final String id;

  AvatarCircle({ @required this.id, @required this.name });

  @override
  Widget build( BuildContext context) {
    return Container(
      height: 50,
      child: Stack(
        children: <Widget>[
          Hero(
            tag: id,
            child:  CircleAvatar(
              child: Text( name.toUpperCase().substring(0,2), style: TextStyle( color: Colors.white )),
              backgroundColor: CustomColors.primary,
            ),
          ),
          Positioned(
            right: 5,
            bottom: 0,
            child: Container(
              alignment: Alignment.center,
              width: 15,
              height: 15,
              decoration: BoxDecoration(
                border: Border.all( color: Colors.white, width: 2 ),
                color: ( number > 10 ) ? Colors.greenAccent : Colors.redAccent,
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TextItem extends StatelessWidget {

  final String name;
  final String message;

  TextItem({ @required this.name, @required this.message});

  @override
  Widget build( BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric( horizontal: 10 ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text( name, style: TextStyle( fontWeight: FontWeight.w700, fontSize: 15, color: CustomColors.title ) ),
          SizedBox( height: 5 ),
          Text( message, style: TextStyle( fontWeight: FontWeight.w400, color: CustomColors.subtitle ))
        ],
      ),
    );
  }
}


class EndItem extends StatelessWidget {

  final int number;

  EndItem({ @required this.number });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text('1 hour', style: TextStyle( color: Colors.black38 ),),
        SizedBox( height: 7 ),
        NotificationCircle( number: number )
      ],
    );
  }
}

class NotificationCircle extends StatelessWidget {
  
  final int number;

  NotificationCircle({ @required this.number});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Text('$number', style: TextStyle( color: Colors.white, fontSize: 15 ) ),
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        color: ( number < 10 ) ? CustomColors.primary : CustomColors.gray,
        shape: BoxShape.circle,
        boxShadow: <BoxShadow> [
          if ( number < 10 )
          BoxShadow( 
            color: CustomColors.primary.withOpacity(0.4), 
            offset: Offset(0,7),
            blurRadius: 10,
          )
        ],
      ),
    );
  }
  
}
