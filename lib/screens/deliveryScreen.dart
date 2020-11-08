import 'package:flutter/material.dart';
import 'package:mandado_express_dev/models/responses/userResponse.dart';
import 'package:mandado_express_dev/models/user.dart';
import 'package:mandado_express_dev/services/roomService.dart';
import 'package:mandado_express_dev/theme/colors.dart';
import 'package:provider/provider.dart';


class DeliveryScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final roomService = Provider.of<RoomService>(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: CustomColors.black,
        title: Text('Repartidores disponibles', style: TextStyle( color: Colors.white, fontWeight: FontWeight.w800, fontSize: 28.0)),
      ),
      body: FutureBuilder(
        future: roomService.getDeliveryUsers(),
        builder: (BuildContext context, AsyncSnapshot<List<UsersResponse>> snapshot) {
          if (snapshot.hasData){
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: ( context, i ) => _usuarioListTile( snapshot.data[i], context, roomService )
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  ListTile _usuarioListTile( UsersResponse user, BuildContext context, RoomService roomService ) {
    return ListTile(
        title: Text(user.fullName),
        subtitle: Text("Ver mas..."),
        leading: Hero(
          tag: user.userId,
          child: CircleAvatar(
            child: Text( user.fullName.substring(0,2)),
            backgroundColor: Colors.blue[100],
          ),
        ),
        trailing: Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: Colors.greenAccent,
            borderRadius: BorderRadius.circular(100)
          ),
        ),
        onTap: () async {
          final roomResponse = await roomService.createRoom( user.userId );
          if ( roomResponse ){
            Navigator.pushReplacementNamed(context, 'chat');
          }
        },
      );
  }

}