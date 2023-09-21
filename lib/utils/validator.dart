class Validator {
  static validateId(String id) {
    if (id.isEmpty) {
      return '아이디를 입력하세요.';
    }
    return null;
  }

  static validatePassword(String password) {
    if (password.isEmpty) {
      return '비밀번호를 입력하세요.';
    }
    return null;
  }
}
