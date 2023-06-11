import '../../../Models/ShopApp/ChangeFavouriteModel.dart';
import '../../../Models/ShopApp/ShopLoginModel.dart';

abstract class ShopStates{}
class ShopInitialState extends ShopStates{}
class ShopChangeNavBarState extends ShopStates{}
class ShopLoadingHomeDataState extends ShopStates{}
class ShopSuccessHomeDataState extends ShopStates{}
class ShopErrorHomeDataState extends ShopStates{}
class ShopSuccesscategoriesState extends ShopStates{}
class ShopErrorcategoriesState extends ShopStates{}
class ShopSuccessChangeFavouriteState extends ShopStates{
   final ChangeFavouriteModel changeFavouriteModel;

  ShopSuccessChangeFavouriteState(this.changeFavouriteModel);
}
class ShopChangeFavouriteState extends ShopStates{}
class ShopErrorChangeFavouriteState extends ShopStates{
  final  error;

  ShopErrorChangeFavouriteState(this.error);
}
class ShopSuccessGetFavState extends ShopStates{

}
class ShopErrorGetFavState extends ShopStates{


}
class ShopLoadingGetFavoritesState extends ShopStates{}
class ShopSuccessGetUserDataState extends ShopStates{
  final ShopLoginModel loginModel;

  ShopSuccessGetUserDataState(this.loginModel);
}
class ShopErrorGetUserDataState extends ShopStates{}
class ShopLoadingUpdateState extends ShopStates{}
class ShopSuccessUpdateState extends ShopStates{
  final ShopLoginModel loginModel;

  ShopSuccessUpdateState(this.loginModel);
}
class ShopErrorUpdateState extends ShopStates{}
class ShopLoadingGetUserDataState extends ShopStates{}