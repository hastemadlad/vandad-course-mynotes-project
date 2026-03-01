import 'package:learningdart/services/auth/auth_exceptions.dart';
import 'package:learningdart/services/auth/auth_provider.dart';
import 'package:learningdart/services/auth/auth_user.dart';
import 'package:test/test.dart';

void main() async {
  group('mock authentication', () {
    final provider = MockAuthProvider();
    test('should not be initialised at start', () {
      expect(provider.isinitialized, false);
    });
    test('cannot logout without initialization', () {
      expect(
        provider.logout(),
        throwsA(const TypeMatcher<notInitializedException>()),
      );
    });

    test(
      'Minimum time of 2 seconds time checker',
      () async {
        await provider.initialize();
        expect(provider.isinitialized, true);
      },
      timeout: const Timeout(Duration(seconds: 3)),
    );

    test('Start initialization', () async {
      await provider.initialize();
      expect(provider.isinitialized, true);
    });

    test('user should be null after initializaiton', () async {
      await provider.initialize();
      expect(provider.currentUser, null);
    });

    test('create user should delegate in login function', () async {
      await provider.initialize();
      final badEmailUser = provider.createUser(
        email: 'email',
        password: 'pass',
      );
      expect(
        badEmailUser,
        throwsA(const TypeMatcher<UserNotFoundAuthException>()),
      );

      final badpassword = provider.createUser(
        email: 'email1',
        password: 'password',
      );
      expect(
        badpassword,
        throwsA(const TypeMatcher<WrongPasswordAuthException>()),
      );

      final user = await provider.createUser(email: '@', password: 'pass');
      expect(provider.currentUser, user);
      expect(user.isEmailVerified, false);
    });

    test('logged in user should be able to be verified', () {
      provider.sendEmailVerification();
      final user = provider.currentUser;
      expect(user, isNotNull);
      expect(user!.isEmailVerified, true);
    });

    test('should be allowed to logout and login again', () async {
      await provider.logout();
      await provider.login(email: '@', password: 'pass');
      final user = provider.currentUser;

      expect(user, isNotNull);
    });
  });
}

class notInitializedException implements Exception {}

class MockAuthProvider implements AuthProvider {
  AuthUser? _user;
  var _isinitialized = false;
  bool get isinitialized => _isinitialized;

  @override
  Future<AuthUser> createUser({
    required String email,
    required String password,
  }) async {
    if (!isinitialized) throw notInitializedException();
    await Future.delayed(const Duration(seconds: 1));
    return login(email: email, password: password);
  }

  @override
  // TODO: implement currentUser
  AuthUser? get currentUser => _user;

  @override
  Future<void> initialize() async {
    await Future.delayed(const Duration(seconds: 1));
    _isinitialized = true;
  }

  @override
  Future<AuthUser> login({required String email, required String password}) {
    if (!isinitialized) throw notInitializedException();
    if (email == 'email') throw UserNotFoundAuthException();
    if (password == 'password') throw WrongPasswordAuthException();
    const user = AuthUser(
      isEmailVerified: false,
      email: 'wacd@gmail.com',
      id: 'id',
    );
    _user = user;
    return Future.value(user);
  }

  @override
  Future<void> logout() async {
    if (!isinitialized) throw notInitializedException();
    if (_user == null) throw UserNotFoundAuthException();
    await Future.delayed(const Duration(seconds: 2));
    _user == null;
  }

  @override
  Future<AuthUser> register({required String email, required String password}) {
    // TODO: implement register
    throw UnimplementedError();
  }

  @override
  Future<void> sendEmailVerification() async {
    if (!isinitialized) throw notInitializedException();
    final user = _user;
    if (user == null) throw UserNotFoundAuthException();
    const newUser = AuthUser(
      isEmailVerified: true,
      email: 'wacd@gmail.com',
      id: 'id',
    );
    _user = newUser;
  }

  @override
  Future<void> sendPasswordReset({required String toEmail}) {
    // TODO: implement sendPasswordReset
    throw UnimplementedError();
  }
}
