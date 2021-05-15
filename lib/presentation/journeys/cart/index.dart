import 'package:flutter/material.dart';

import 'package:sell_streams/data/models/cart_model.dart';

import 'package:sell_streams/presentation/blocs/cart/cart.dart';
import 'package:sell_streams/presentation/journeys/widgets/loader_widget.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sell_streams/utils/constants.dart';

class CartView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocListener<CartBloc, CartState>(
          listener: (context, state) {
            if(state is CartStateLoading) {
              return AppLoader(text: 'Loading Cart...',);
            }
            if(state is CartStateFailure){
              Fluttertoast.showToast(
                  msg: state.errorMessage ?? 'Could Not Fetch Your Cart Items At The Moment!!',
                  textColor: Colors.redAccent,
                  backgroundColor: Colors.blueGrey,
                  fontSize: 16.0,
                  gravity: ToastGravity.CENTER,
                  toastLength: Toast.LENGTH_LONG
              );
            }
            if(state is CartStateSuccess){
              Fluttertoast.showToast(
                  msg: 'Retrieved Your Cart Items !!',
                  textColor: Colors.greenAccent,
                  backgroundColor: Colors.orangeAccent,
                  fontSize: 16.0,
                  gravity: ToastGravity.CENTER,
                  toastLength: Toast.LENGTH_LONG
              );
            }
          },
          child: BlocBuilder<CartBloc, CartState>(
            builder: (context, state){
              if(state is CartStateLoading) {
                return AppLoader(text: 'Loading Cart...',);
              }
              if(state is CartStateFailure){
                Fluttertoast.showToast(
                  msg: state.errorMessage ?? 'Could Not Fetch Your Cart Items At The Moment!!',
                  textColor: Colors.redAccent,
                  backgroundColor: Colors.blueGrey,
                  fontSize: 16.0,
                  gravity: ToastGravity.CENTER,
                  toastLength: Toast.LENGTH_LONG
                );
              }
              if(state is CartStateSuccess){
                Fluttertoast.showToast(
                    msg: 'Retrieved Your Cart Items !!',
                    textColor: Colors.greenAccent,
                    backgroundColor: Colors.orangeAccent,
                    fontSize: 16.0,
                    gravity: ToastGravity.CENTER,
                    toastLength: Toast.LENGTH_LONG
                );
                return CartViewPage(cartList: state.cartList);
              }
              return AppLoader(text: 'Loading Cart...',);
            },
          ),
        ),
      ),
    );
  }
}

class CartViewPage extends StatefulWidget {

  final List<CartModel> cartList;
  CartViewPage({@required this.cartList});

  @override
  _CartViewPageState createState() => _CartViewPageState();
}

class _CartViewPageState extends State<CartViewPage> {
  @override
  Widget build(BuildContext context) {
    return widget.cartList.isEmpty
        ? Container(
            child: Center(
              child: Text('No Items in Cart', style: kErrorLoadingTextStyle,),
            )
          )
        : Container();
  }
}
