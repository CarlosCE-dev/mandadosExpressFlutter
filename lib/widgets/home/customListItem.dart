part of 'widgets.dart';

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