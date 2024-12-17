


import 'package:growmind_tutuor/features/auth/domain/entities/user.dart';

abstract class AuthRepository {
  Future<User> login(String email, String password);
  Future<User> signup(String email, String password, String displayName,String phone);
}
