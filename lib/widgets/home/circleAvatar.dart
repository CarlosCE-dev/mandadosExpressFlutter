part of 'widgets.dart';

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
