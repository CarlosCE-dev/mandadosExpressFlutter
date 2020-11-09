part of 'widgets.dart';

class Logo extends StatelessWidget {

  final String titulo;
  final Color color;
  final double size;

  Logo({ 
    @required this.titulo, 
    this.color = Colors.black87,
    this.size = 170.0
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.only( top: 50 ),
        width: this.size,
        child: Column(
          children: <Widget>[
            Image( image: AssetImage('assets/images/logos/logo.png')),
            SizedBox( height: 20 ),
            Text( titulo, style: TextStyle( fontSize: 30, fontWeight: FontWeight.w700, color: this.color),)
          ],
        ),
      ),
    );
  }
}