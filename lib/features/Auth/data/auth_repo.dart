abstract class AuthRepo {
  registerUser(String email, String password);

  loginUser(String email, String password);

  loginWithGoogle();
}
