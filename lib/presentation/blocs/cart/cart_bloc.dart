import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:sell_streams/domain/repositories/cart_repository.dart';
import 'package:sell_streams/presentation/blocs/cart/cart.dart';

class CartBloc extends Bloc<CartEvent, CartState> {

  final CartRepository _cartRepository;
  CartBloc(CartRepository repository)
      : assert (repository != null),
        _cartRepository = repository,
        super(CartStateInitial());

  @override
  Stream<CartState> mapEventToState(CartEvent event) async* {
    if(event is FetchAllCartItems){
      yield* _mapFetchAllCartItemsToState(event);
    }

    if(event is AddToCartItems){
      yield* _mapAddToCartItemsToState(event);
    }

    if(event is DeleteOneCartItem){
      yield* _mapDeleteOneCartItemToState(event);
    }

    if(event is DeleteAllCartItems){
      yield* _mapDeleteAllCartItemsToState(event);
    }

  }

  Stream<CartState> _mapFetchAllCartItemsToState(FetchAllCartItems event) async* {
    yield CartStateLoading();
    try {
      final cartItems = await _cartRepository.getAllCartItems();
      if(cartItems != null){
        yield CartStateSuccess(cartList: cartItems);
      } else {
        print('empty response \n $cartItems');
        yield CartStateFailure(errorMessage: 'Error Fetching All Movies, Try Again!');
      }
    } catch (err){
      print(err);
      yield CartStateFailure(errorMessage: 'Error Fetching All Cart Items, Try Again!');
    }
  }

  Stream<CartState> _mapAddToCartItemsToState(AddToCartItems event) async* {
    yield CartStateLoading();
    try {
      final response = await _cartRepository.addMovieToCart(movieId: event.movieId);
      final list = await _cartRepository.getAllCartItems();
      print(response);
      if(response != null) {
        yield CartStateSuccess(cartList: list, itemAdded: response);
      } else {
        print('empty response \n $response');
        yield CartStateFailure(errorMessage: 'Error Adding Item to Cart');
      }
    } catch (err){
      print(err);
      yield CartStateFailure(errorMessage: 'Error Fetching All Cart Items, Try Again!');
    }
  }

  Stream<CartState> _mapDeleteOneCartItemToState(DeleteOneCartItem event) async* {
    yield CartStateLoading();
    try {
      await _cartRepository.removeMovieFromCart(movieId: event.movieId);
      final list = await _cartRepository.getAllCartItems();
      yield CartStateSuccess(cartList: list, itemAdded: null);
    } catch (err){
      print(err);
      yield CartStateFailure(errorMessage: 'Error Fetching All Cart Items, Try Again!');
    }
  }

  Stream<CartState> _mapDeleteAllCartItemsToState(DeleteAllCartItems event) async* {
    yield CartStateLoading();
    try {
      await _cartRepository.clearCart();
      yield CartStateSuccess(cartList: [], itemAdded: null);
    } catch (err){
      print(err);
      yield CartStateFailure(errorMessage: 'Error Fetching All Cart Items, Try Again!');
    }
  }

}