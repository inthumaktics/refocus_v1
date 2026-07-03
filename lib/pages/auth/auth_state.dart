class UserAccount {
  final String name;
  final String email;
  final String password;

  UserAccount({
    required this.name,
    required this.email,
    required this.password,
  });
}

class DummyAuth {
  // In-memory database of registered users, seeded with the demo user.
  static final List<UserAccount> _users = [
    UserAccount(
      name: 'Demo User',
      email: 'demo@refocus.app',
      password: 'Refocus123',
    ),
  ];

  // Register a new user. Returns false if the email is already registered.
  static bool register(String name, String email, String password) {
    final lowerEmail = email.trim().toLowerCase();
    if (_users.any((u) => u.email.toLowerCase() == lowerEmail)) {
      return false;
    }
    _users.add(UserAccount(
      name: name.trim(),
      email: lowerEmail,
      password: password,
    ));
    return true;
  }

  // Validate login credentials.
  static bool login(String email, String password) {
    final lowerEmail = email.trim().toLowerCase();
    return _users.any((u) => u.email.toLowerCase() == lowerEmail && u.password == password);
  }
}
