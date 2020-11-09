part of 'widgets.dart';

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