import 'dart:convert';

import 'package:empmaster/models/apiResponse.dart';
import 'package:empmaster/models/user.dart';

import '../constant.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<ApiResponse> login(String email, String password) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    final response = await http.post(Uri.parse(loginURL),
        headers: {'Accept': 'application/json'},
        body: {'email': email, 'password': password});
    print(response.statusCode);
    switch (response.statusCode) {
      case 200:
        apiResponse.data = User.fromJson(jsonDecode(response.body));
        break;
      case 422:
        final errors = jsonDecode(response.body)['errors'];
        apiResponse.error = errors.values.elementAt(0)[0];
        break;
      case 401:
        apiResponse.error = jsonDecode(response.body)['message'];
        break;
      default:
        apiResponse.error = somethingWentWrong;
        break;
    }
  } catch (e) {
    apiResponse.error = serverError;
    print(apiResponse.error);
  }

  return apiResponse;
}

Future<ApiResponse> register(String email, String password, String nom,
    String prenom, String id_dep) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    final response = await http.post(Uri.parse(registerURL), headers: {
      'Accept': 'application/json'
    }, body: {
      'email': email,
      'password': password,
      'nom': nom,
      'prenom': prenom,
      'id_dep': id_dep
    });

    switch (response.statusCode) {
      case 201:
        apiResponse.error = jsonDecode(response.body)['message'];
        break;
      case 422:
        final errors = jsonDecode(response.body)['errors'];
        apiResponse.error = errors.values.elementAt(0)[0];
        break;
      case 403:
        apiResponse.error = unauthorized;
        break;
      case 500:
        apiResponse.error = jsonDecode(response.body)['message'];
        break;
      default:
        apiResponse.error = somethingWentWrong;
        break;
    }
  } catch (e) {
    apiResponse.error = serverError;
    print(apiResponse.error);
    print(e);
  }

  return apiResponse;
}

// Future<ApiResponse> login(String email, String password) async {
//   ApiResponse apiResponse = ApiResponse();
//   try {
//     final response = await http.post(
//         Uri.parse(loginURL),
//         headers: {'Accept': 'application/json'},
//         body: {'email': email, 'password': password}
//     );
//
//     switch (response.statusCode) {
//       case 200:
//         apiResponse.data = User.fromJson(jsonDecode(response.body));
//         break;
//       case 422:
//         final errors = jsonDecode(response.body)['errors'];
//         apiResponse.error = errors[errors.keys.elementAt(0)[0]];
//         break;
//       case 403:
//         apiResponse.error = jsonDecode(response.body)['message'];
//         break;
//       default:
//         apiResponse.error = somethingWentWrong;
//         break;
//     }
//   } catch (e) {
//     apiResponse.error = serverError;
//     print(apiResponse.error);
//   }
//
//   return apiResponse;
// }

Future<ApiResponse> getUser() async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.get(Uri.parse(userURL), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });

    switch (response.statusCode) {
      case 200:
        apiResponse.data = User.fromJson(jsonDecode(response.body));
        break;
      case 401:
        apiResponse.error = unauthorized;
        break;
      default:
        apiResponse.error = somethingWentWrong;
        break;
    }
  } catch (e) {
    apiResponse.error = serverError;
    print(apiResponse.error);
  }

  return apiResponse;
}

Future<String> getToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('token') ?? '';
}

Future<int> getUserID() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getInt('userID') ?? 0;
}

Future<ApiResponse> logout() async {
  ApiResponse apiResponse = ApiResponse();
  bool t = false;
  String token = await getToken();
  print('token :' + token);
  if (token != '') {
    try {
      final response = await http.post(Uri.parse(logoutURL), headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });
      switch (response.statusCode) {
        case 200:
          apiResponse.error = jsonDecode(response.body)['message'];
          SharedPreferences prefs = await SharedPreferences.getInstance();
          t = await prefs.remove('token');
          print(t.toString() + 'Token removed');
          break;
        case 422:
          final errors = jsonDecode(response.body)['errors'];
          apiResponse.error = errors[errors.keys.elementAt(0)[0]];
          print(apiResponse.error);
          break;
        case 403:
          apiResponse.error = jsonDecode(response.body)['message'];
          print(apiResponse.error);
          break;
        default:
          apiResponse.error = somethingWentWrong;
          break;
      }
    } catch (e) {
      apiResponse.error = serverError;
      print(apiResponse.error);
    }
    return apiResponse;
  }
  return apiResponse;
}

Future<String> getLocation() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return (prefs.getString('localisation')) ?? '';
}

Future<ApiResponse> pointerEntre(String localisation, String heure) async {
  ApiResponse apiResponse = ApiResponse();
  String token = await getToken();
  print('token :' + token);
  if (token != '') {
    try {
      final response = await http.post(Uri.parse(pointageEntre), headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      }, body: {
        'heure': heure,
        'localisation': localisation
      });
      switch (response.statusCode) {
        case 201:
          apiResponse.data = jsonDecode(response.body)['retard'];
          apiResponse.error = jsonDecode(response.body)['message'];

          break;
        case 401:
          apiResponse.error = jsonDecode(response.body)['message'];
          print(apiResponse.error);
          break;
        case 500:
          apiResponse.error = jsonDecode(response.body)['message'];
          print(apiResponse.error);
          break;
        default:
          apiResponse.error = somethingWentWrong;
          break;
      }
    } catch (e) {
      apiResponse.error = serverError;
      print(apiResponse.error);
    }
    return apiResponse;
  }
  return apiResponse;
}

Future<ApiResponse> updateProfile(
    String nom, String prenom, String email) async {
  ApiResponse apiResponse = ApiResponse();
  String token = await getToken();
  print('token :' + token);
  if (token != '') {
    try {
      final response = await http.post(Uri.parse(updateProfileURL), headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      }, body: {
        'nom': nom,
        'prenom': prenom,
        'email': email,
      });
      switch (response.statusCode) {
        case 201:
          apiResponse.error = jsonDecode(response.body)['message'];
          print(apiResponse.error);
          break;
        case 401:
          apiResponse.error = jsonDecode(response.body)['message'];
          print(apiResponse.error);
          break;
        case 500:
          apiResponse.error = jsonDecode(response.body)['message'];
          print(apiResponse.error);
          break;
        default:
          apiResponse.error = somethingWentWrong;
          break;
      }
    } catch (e) {
      apiResponse.error = serverError;
      print(apiResponse.error);
    }
    return apiResponse;
  }
  return apiResponse;
}

Future<ApiResponse> updatePassword(
    String password) async {
  ApiResponse apiResponse = ApiResponse();
  String token = await getToken();
  print('token :' + token);
  if (token != '') {
    try {
      final response = await http.post(Uri.parse(updatePasswordURL), headers: {
        'Accept': 'application/json',
        'Authorization': 'FBearer $token',
      }, body: {
        'password': password,
  
      });
      switch (response.statusCode) {
        case 201:
          apiResponse.error = jsonDecode(response.body)['message'];
          print(apiResponse.error);
          break;
        case 401:
          apiResponse.error = jsonDecode(response.body)['message'];
          print(apiResponse.error);
          break;
        case 500:
          apiResponse.error = jsonDecode(response.body)['message'];
          print(apiResponse.error);
          break;
        default:
          apiResponse.error = somethingWentWrong;
          break;
      }
    } catch (e) {
      apiResponse.error = serverError;
      print(apiResponse.error);
    }
    return apiResponse;
  }
  return apiResponse;
}

Future<ApiResponse> pointerSortie(String localisation, String heure) async {
  ApiResponse apiResponse = ApiResponse();
  String token = await getToken();
  print('token :' + token);
  try {
    final response = await http.post(Uri.parse(pointageSortie), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    }, body: {
      'heure': heure,
      'localisation': localisation
    });
    switch (response.statusCode) {
      case 201:
        apiResponse.error = jsonDecode(response.body)['message'];
        break;
      case 401:
        apiResponse.error = jsonDecode(response.body)['message'];
        print(apiResponse.error);
        break;
      case 500:
        apiResponse.error = jsonDecode(response.body)['message'];
        print(apiResponse.error);
        break;
      default:
        apiResponse.error = somethingWentWrong;
        break;
    }
  } catch (e) {
    apiResponse.error = serverError;
    print(e);
  }
  return apiResponse;
}

Future<Map<String, dynamic>> checkPointage() async {
  ApiResponse apiResponse = ApiResponse();
  String token = await getToken();
  Map<String, dynamic> arr = <String, dynamic>{};
  print('token :' + token);
  try {
    final response = await http.post(Uri.parse(checkPointageURL), headers: {
      'Content-Type': 'application/json;charset=UTF-8',
      'Charset': 'utf-8',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });

    switch (response.statusCode) {
      case 200:
        arr = jsonDecode(response.body);
        break;
      case 404:
        arr = jsonDecode(response.body);
        break;
      case 500:
        apiResponse.error = jsonDecode(response.body)['message'];
        print(apiResponse.error);
        break;
      default:
        apiResponse.error = somethingWentWrong;
        break;
    }
  } catch (e) {
    apiResponse.error = serverError;
    print(e.toString());
  }
  return arr;
}

Future<Map<String, dynamic>> getHeures() async {
  ApiResponse apiResponse = ApiResponse();
  String token = await getToken();
  Map<String, dynamic> arr = <String, dynamic>{};
  print('token :' + token);
  try {
    final response = await http.post(Uri.parse(getHeuresURL), headers: {
      'Content-Type': 'application/json;charset=UTF-8',
      'Charset': 'utf-8',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });

    switch (response.statusCode) {
      case 200:
        arr = jsonDecode(response.body);
        break;
      case 404:
        arr = jsonDecode(response.body);
        break;
      case 500:
        apiResponse.error = jsonDecode(response.body)['message'];
        print(apiResponse.error);
        break;
      default:
        apiResponse.error = somethingWentWrong;
        break;
    }
  } catch (e) {
    apiResponse.error = serverError;
    print(e.toString());
  }
  return arr;
}

Future<dynamic> getPointages(String mois) async {
  ApiResponse apiResponse = ApiResponse();
  String token = await getToken();
  var arr;
  print('token :' + token);
  try {
    final response = await http.post(Uri.parse(getPointagesURL), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    }, body: {
      'mois': mois,
    });

    switch (response.statusCode) {
      case 200:
        arr = jsonDecode(response.body)['pointages'];
        break;
      case 404:
        arr = jsonDecode(response.body)['pointages'];
        break;
      case 500:
        apiResponse.error = jsonDecode(response.body)['message'];
        print(apiResponse.error);
        break;
      default:
        apiResponse.error = somethingWentWrong;
        break;
    }
  } catch (e) {
    apiResponse.error = serverError;
    print(e.toString());
  }
  return arr;
}

Future<dynamic> getPointage(String id) async {
  ApiResponse apiResponse = ApiResponse();
  String token = await getToken();
  var arr;
  print('token :' + token);
  try {
    final response = await http.post(Uri.parse(getPointageURL), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    }, body: {
      'id': id,
    });

    switch (response.statusCode) {
      case 200:
        arr = jsonDecode(response.body)['pointages'];
        break;
      case 404:
        arr = jsonDecode(response.body)['pointages'];
        break;
      case 500:
        apiResponse.error = jsonDecode(response.body)['message'];
        print(apiResponse.error);
        break;
      default:
        apiResponse.error = somethingWentWrong;
        break;
    }
  } catch (e) {
    apiResponse.error = serverError;
    print(e.toString());
  }
  return arr;
}
