import 'package:lolly_flutter/models/misc/muser.dart';
import 'package:lolly_flutter/services/misc/user_service.dart';

class LoginViewModel {
  final item = MUser();
  final userService = UserService();

  Future<String> login() async {
    final lst = await userService.getData(item.username, item.password);
    return lst.isEmpty ? "" : lst[0].userid;
  }
}
