class APIConstants {
  APIConstants._();

  static const String PROD_BASE_URL = 'https://academician-api.herokuapp.com';

  static const String AUTH_SEGMENT = '/api/v1/auth';
  static const String USER_SEGMENT = '/api/v1/user';
  static const String MOVIES_SEGMENT = '/api/v1/movies';
  static const String GENRES_SEGMENT = '/api/v1/genres';
  static const String CART_SEGMENT = '/api/v1/cart';
  static const String ORDERS_SEGMENT = '/api/v1/orders';

  static const ACCESS_TOKEN_KEY = 'access_token';
  static const REFRESH_TOKEN_KEY = 'refresh_token';
  static const USER_ID_KEY = 'userId';

}