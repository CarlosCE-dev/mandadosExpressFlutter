part of 'widgets.dart';

class SmLogo extends StatelessWidget {

  final String titulo;
  final Color color;

  SmLogo({ 
    @required this.titulo, 
    this.color = Colors.black87,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only( top: 20 ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text( titulo, style: TextStyle( fontSize: 30, fontWeight: FontWeight.w700, color: this.color)),
          SizedBox( width: 20 ),
          Container(
            width: 50,
            child: Image( image: AssetImage('assets/images/logos/logo.png') )
          ),
        ],
      ),
    );
  }
}