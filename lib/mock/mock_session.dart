class MockSession {
  static int id = null;

  static bool isAuthen() {
    return (id != null);
  }

  static void logout() {
    id = null;
  }

  static getCurrentUser() {
    return id;
  }
}
