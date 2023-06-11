import '../../Modules/shop app/Shop login/shopLogin.dart';
import '../../Network/local/Cash_helper.dart';
import 'components.dart';

void signOut(context)=> CashHelper.removeData(key: 'token').then((value) {
  if(value)
    navigateAndFinish(context, shopLogin());
});
  String ? token;