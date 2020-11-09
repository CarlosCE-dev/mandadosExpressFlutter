import 'package:flutter/material.dart';

// Lib
import 'package:provider/provider.dart';

// Theme
import 'package:mandado_express_dev/theme/colors.dart';

// Service
import 'package:mandado_express_dev/services/authService.dart';
import 'package:mandado_express_dev/services/roomService.dart';

// Models
import 'package:mandado_express_dev/models/viewModels/roomResponse.dart';

// Widgets
import 'package:mandado_express_dev/widgets/home/widgets.dart';

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
            // TODO: Verificar si desea cerrar session
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
          Navigator.pushNamed(context, 'delivery');
        }, 
        backgroundColor: CustomColors.black,
        child: Icon( Icons.add, color: Colors.white )
      ),
    );
  }
}