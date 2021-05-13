import 'package:flutter/material.dart';
import 'package:sell_streams/utils/constants.dart';

class CTAButton extends StatelessWidget {
  final String title;
  final Color color;
  final Color textColor;
  final bool isEnabled;
  final bool isMini;
  final double width;
  final Function onPressed;

  const CTAButton(
      {Key key,
        this.title,
        this.color,
        this.textColor,
        this.isEnabled,
        this.isMini,
        this.width,
        this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Container(
//      width: w - w * 0.2,
      width: isMini ? width : w,
      child: RaisedButton(
        onPressed: isEnabled ? onPressed : null,
        elevation: 2.0,
        padding: EdgeInsets.symmetric(horizontal: isMini ? 25.0 : 6.0, vertical: isMini ? 10.0 : 18.0),
        color: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28.0),
        ),
        child: Text(title, style: kCTAButtonTextStyle.copyWith(color: textColor),),
      ),
    );
  }
}
