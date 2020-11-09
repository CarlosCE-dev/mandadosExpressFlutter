part of 'widgets.dart';

class CustomButton extends StatelessWidget {

  final String text;
  final Function onPress;
  final Color buttonColor;
  final Color textColor;

  CustomButton({
    @required this.text, 
    @required this.onPress,
    this.buttonColor =Colors.white,
    this.textColor = Colors.black87
  });

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      elevation: 2,
      highlightElevation: 5,
      color: buttonColor,
      shape: StadiumBorder(),
      onPressed: this.onPress,
      child: Container(
        width: double.infinity,
        height: 50,
        child: Center(
          child: Text(this.text, style: TextStyle( color: textColor, fontSize: 17 )),
        ),
      ),
    );
  }
}