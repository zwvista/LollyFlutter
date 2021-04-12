import 'package:lolly_flutter/models/misc/muser.dart';

import '../misc/base_service.dart';

class UserService extends BaseService<MUser> {
  Future<List<MUser>> getData(String username, String password) async =>
      MUsers.fromJson(await getDataByUrl(
              "USERS?filter=USERNAME,eq,$username&filter=PASSWORD,eq,$password"))
          .lst;
}
