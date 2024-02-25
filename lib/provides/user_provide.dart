import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gradproject/models/user_modle.dart';
import 'package:gradproject/services/user_services.dart';

final usersProvider = FutureProvider<List<UserModel>>((ref) async {
  UserService userService = UserService();
  return await userService.getUsers();
});
