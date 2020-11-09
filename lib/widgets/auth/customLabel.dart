part of 'widgets.dart';

class CustomLabel extends StatelessWidget {

  final String route;
  final String primaryText;
  final String secodaryText;
  final Color primaryTextColor;
  final Color secondaryTextColor;

  CustomLabel({
    @required this.route, 
    @required this.primaryText, 
    @required this.secodaryText,
    this.primaryTextColor = Colors.black87,
    this.secondaryTextColor = Colors.black54
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Text(primaryText, style: TextStyle( color: this.secondaryTextColor, fontSize: 15, fontWeight: FontWeight.w500 ) ),
          SizedBox(height: 16),
          GestureDetector(
            onTap: (){
              Navigator.pushReplacementNamed(context, route);
            },
            child: Text(secodaryText, style: TextStyle( color: this.primaryTextColor, fontSize: 18, fontWeight: FontWeight.bold ) )
          )
        ],
      ),
    );
  }
}