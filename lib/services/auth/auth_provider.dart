import 'package:learningdart/services/auth/auth_user.dart';

//Creating Abstract Class to make methods that do not work yet, or methods without logic later I will add the logic

abstract class AuthProvider {
  Future<void> initialize();
  AuthUser? get currentUser; //I am using getter as I cannot write a method body
  //its like a short cut for than writing AuthUser? currentUser = AuthUser(isEmailVerified: True/False);
  Future<AuthUser> login({required String email, required String password});

  Future<AuthUser> register({required String email, required String password});
  Future<void> logout();
  Future<void> sendEmailVerification();
  Future<AuthUser> createUser({required String email, required String password});
}
