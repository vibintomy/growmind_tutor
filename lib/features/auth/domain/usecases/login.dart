


import 'package:growmind_tutuor/features/auth/domain/entities/user.dart';
import 'package:growmind_tutuor/features/auth/domain/repositories/auth_repositoreis.dart';

class Login {
  final AuthRepository repository;
  Login(this.repository);
  Future<User> execute(String email, String password) {
    return repository.login(email, password);
  }
}
