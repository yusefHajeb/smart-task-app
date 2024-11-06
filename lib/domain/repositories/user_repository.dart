import '../../data/models/user_model.dart';

abstract class UserRepository {
  Future<User> getUser(int id);
  Future<void> insertUser(Map<String, dynamic> data);
  Future<void> updateUser(Map<String, dynamic> data);
  Future<void> deleteLogout(String id);
}
