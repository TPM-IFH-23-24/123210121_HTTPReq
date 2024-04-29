import 'bases_network.dart';

class ApiDataSource{
  static ApiDataSource instance = ApiDataSource();

  static Future<Map<String, dynamic>> loadUsers(int page){
    return baseNetwork.get("users?page=$page");
  }

  static Future<Map<String, dynamic>> userData(int id) {
    return baseNetwork.get("users/$id");
  }

}