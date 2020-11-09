part of 'widgets.dart';

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