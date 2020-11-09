part of 'widgets.dart';

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
