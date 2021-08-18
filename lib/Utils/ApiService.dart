class ApiService {
  Uri signinUrl = Uri.parse(
      'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyD9-wy1q-jqUtJf3wrPzG4kcjVHblNfbrU');
  Uri signUpUrl = Uri.parse(
      'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyD9-wy1q-jqUtJf3wrPzG4kcjVHblNfbrU');

  storeData(String id) {
    return Uri.parse(
        'https://gobanten-e2df9-default-rtdb.firebaseio.com/users/$id.json');
  }

  getData(String id) {
    return Uri.parse(
        'https://gobanten-e2df9-default-rtdb.firebaseio.com/users.json?orderBy="id"&equalTo="$id"');
  }

  Uri getWisata = Uri.parse(
      'https://gobanten-e2df9-default-rtdb.firebaseio.com/wisata.json');
}
