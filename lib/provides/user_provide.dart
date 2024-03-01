import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gradproject/models/user_modle.dart';
import 'package:gradproject/services/user_services.dart';

final usersStreamProvider = StreamProvider<List<UserModel>>((ref) {
  UserService userService = UserService();
  return userService.getUsersStream();
});
