import 'package:flutter/material.dart';
import 'package:sell_streams/utils/constants.dart';
import 'package:sell_streams/utils/strings.dart';


class PolicyView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: ()=> Navigator.pop(context),
                    icon: Icon(Icons.close, color: Theme.of(context).primaryColor,),
                  ),
                  _buildPolicyHeader(title: 'Privacy Policy'),
                  Text(policyDescText, style: kPolicyBodyTextStyle),
                  SizedBox(height: 20.0,),
                  _buildPolicyHeader(title: 'Information Collection and Use'),
                  Text(infoUseCollectionText, style: kPolicyBodyTextStyle),
                  SizedBox(height: 20.0,),
                  _buildPolicyHeader(title: 'Changes to Privacy Policy'),
                  Text(changesPolicyText, style: kPolicyBodyTextStyle),
                  SizedBox(height: 20.0,),
                ],
              ),
            )
          ),
        ),
      ),
    );
  }

  Widget _buildPolicyHeader({String title}){
    return Row(
      children: [
        Text(title, style: kPolicyHeaderTextStyle, textAlign: TextAlign.center,)
      ],
    );
  }

}
