import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mandado_express_dev/models/viewModels/chatViewModel.dart';
import 'package:mandado_express_dev/services/authService.dart';
import 'package:mandado_express_dev/services/roomService.dart';
import 'package:mandado_express_dev/services/signalRService.dart';
import 'package:mandado_express_dev/theme/colors.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  SignalRService signalRService;
  RoomService roomService;

  @override
  void initState() {
    super.initState();
    this.signalRService = Provider.of<SignalRService>(context, listen: false );
    this.roomService = Provider.of<RoomService>(context, listen: false );

    signalRService.signalRConnection.invoke("JoinRoom", args: <Object>[ roomService.chat.id ]).then((_){
      
      this.signalRService.signalRConnection.on("ReceiveMessage", _escucharMensaje );

    });
  }

  void _escucharMensaje( dynamic data ){

    RoomMessage newMessage = new RoomMessage(
      body: data[0],
      userId: this.roomService.chat.userId,
      createOn: new DateTime.now()
    );

    this.roomService.addMessage( newMessage );

  }

  @override
  Widget build(BuildContext context) {

    final chatList = Provider.of<RoomService>(context).chat;
    
    return Scaffold(
      body: Column(
        children: <Widget>[
          AppBar( 
            id: chatList.id.toString(), 
            randomNumber: 5, 
            number: 2, 
            name: chatList.name 
          ),
          Expanded(
            child: ( chatList.roomMessages.length > 0 ) 
            ? ChatContainer( roomMessages: chatList.roomMessages )
            : Text("No hay mensajes")
          ),
          MessageComposer()
        ],
      ),
    );
  }
}

class AppBar extends StatelessWidget {

  final int number;
  final String id;
  final int randomNumber;
  final String name;

  AppBar({@required this.id, @required this.randomNumber, @required this.number, @required this.name });

  @override
  Widget build(BuildContext context) {

    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return Container(
      height: 120,
      padding: EdgeInsets.symmetric( horizontal: 10 ),
      color: CustomColors.black,
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only( bottom: 5 ),
            height: statusBarHeight,
          ),
          AppBarContent(id: id, number: number, randomNumber: randomNumber, name: name),
        ],
      ),
    );
  }
}

class AppBarContent extends StatelessWidget {
  const AppBarContent({
    Key key,
    @required this.id,
    @required this.number,
    @required this.randomNumber,
    @required this.name,
  }) : super(key: key);

  final String id;
  final int number;
  final int randomNumber;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        IconButton( icon: FaIcon( FontAwesomeIcons.chevronLeft, color: Colors.white70, size: 30 ), onPressed: (){
          Navigator.pop(context);
        }),
        SizedBox( width: 20 ),
        Container(
          height: 50,
          child: Hero(
            tag: id,
            child: Stack(
              children: <Widget>[
                CircleAvatar(
                  child: Text( name.substring(0,2)),
                  backgroundColor: Colors.blue[100],
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
                      color: ( randomNumber > 10 ) ? Colors.greenAccent : Colors.redAccent,
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox( width: 20 ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text( name, style: TextStyle( color: Colors.white, fontSize: 18, fontWeight: FontWeight.w800)),
              SizedBox( height: 2 ),
              Text('online', style: TextStyle( color: Colors.white, fontSize: 14, fontWeight: FontWeight.w400)),
            ],
          ),
        ),
        IconButton( icon: FaIcon( FontAwesomeIcons.ellipsisH, color: Colors.white70, size: 20 ), onPressed: (){}),
      ],
    );
  }
}


class ChatContainer extends StatelessWidget {

  final List<RoomMessage> roomMessages;
  ChatContainer({ @required this.roomMessages });

  @override
  Widget build(BuildContext context) {

    final userId = Provider.of<AuthService>(context, listen: false ).getUserId;
    
    return Container(
      child: ListView.builder(
        reverse: true,
        itemCount: roomMessages.length,
        itemBuilder: ( context, i ) {
            return MessageItem( message: roomMessages[i], userId: userId );
        }
      ),
    );
  }
}

class MessageItem extends StatelessWidget {
  
  final RoomMessage message;
  final String userId;

  MessageItem({ @required this.message, @required this.userId });

  @override
  Widget build(BuildContext context) {

    final isClientMessage = ( userId == message.userId ) ? true : false;

    return Container(
      padding: EdgeInsets.symmetric( horizontal: 15.0 ),
      child: Column(
        // Agregar de que lado aparecer
        crossAxisAlignment: ( isClientMessage ) ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          MessageBubble( message: message, isClientMessage: isClientMessage ),
          TextTime()
        ],
      ),
    );
  }
}

class TextTime extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only( bottom: 5 ),
      child: Text('7:23 am', style: TextStyle( fontSize: 10.0 ),),
    );
  }
}

class MessageBubble extends StatelessWidget {
 
  final RoomMessage message;
  final bool isClientMessage;

  MessageBubble({ @required this.message, @required this.isClientMessage });

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width*0.7;
    return Container(
      constraints: BoxConstraints( maxWidth: widthScreen ),
      margin: EdgeInsets.only( top: 12, bottom: 5 ),
      child:  Container(
        padding: EdgeInsets.symmetric( horizontal: 15, vertical: 15 ),
          child: Text( message.body, style: TextStyle( 
            color: ( isClientMessage ) ? Colors.white : Colors.black54, 
            fontWeight: FontWeight.w500, 
            height: 1.3 
          ) 
        ),
      ),
      decoration: BoxDecoration(
        color: ( isClientMessage ) ? Theme.of(context).primaryColorLight : Color(0xFFF3F4F6),
        borderRadius: ( isClientMessage ) ? BorderRadius.only( 
          topLeft: Radius.circular(30), 
          topRight:Radius.circular(30),
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(5)  
        ) : BorderRadius.only( 
          topLeft: Radius.circular(30), 
          topRight:Radius.circular(30),
          bottomLeft: Radius.circular(5),
          bottomRight: Radius.circular(30)  
        )
      ),
    );
  }
}

class MessageComposer extends StatefulWidget {
 
  @override
  _MessageComposerState createState() => _MessageComposerState();
}

class _MessageComposerState extends State<MessageComposer> {

  final messageController = TextEditingController();

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0 ),
      height: 70.0,
      decoration: BoxDecoration(
         color: Color(0xFFF3F4F6),
         borderRadius: BorderRadius.circular( 30.0 )
      ),
      child: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.photo),
            iconSize: 25.0,
            color: Theme.of(context).primaryColor,
            onPressed: null,
          ),
          Expanded(
            child: TextField(
              controller: messageController,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration.collapsed(
                hintText: 'Send a message...',
              ),
            ),
          ),
          IconButton(
            icon: Icon( Icons.send ),
            iconSize: 25.0,
            color: Theme.of(context).primaryColor,
            onPressed: () {
              if ( messageController.text != "" ) {
                final signalRService = Provider.of<SignalRService>(context, listen: false );
                final roomService = Provider.of<RoomService>(context, listen: false );
                signalRService.signalRConnection.invoke("SendMessage", args: <Object>[
                  roomService.chat.id, roomService.chat.userId , messageController.text,
                ]);
              }
            },
          ),
        ],
      ),
    );
  }
}