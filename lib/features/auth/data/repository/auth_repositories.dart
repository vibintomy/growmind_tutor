
import 'package:growmind_tutuor/features/auth/data/datasource/auth_local_datasource.dart';
import 'package:growmind_tutuor/features/auth/data/datasource/auth_remote_datasource.dart';
import 'package:growmind_tutuor/features/auth/domain/entities/user.dart';
import 'package:growmind_tutuor/features/auth/domain/repositories/auth_repositoreis.dart';

class AuthRepositorieImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  AuthRepositorieImpl(
      {required this.localDataSource, required this.remoteDataSource});

  @override
  Future<User> login(String email, String password) async {
    final UserModel = await remoteDataSource.login(email, password);
    await localDataSource.cacheUser(UserModel);
    return User(id: UserModel.id, email: UserModel.email);
  }

  @override
  Future<User> signup(String email, String password, String displayName,String phone) async {
    final UserModel =
        await remoteDataSource.signup(email, password, displayName,phone);
    await localDataSource.cacheUser(UserModel);
    return User(id: UserModel.id, email: UserModel.email);
  }
}
