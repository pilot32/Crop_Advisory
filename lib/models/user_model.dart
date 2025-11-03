/// User Model
/// 
/// Represents a user/farmer in the application
/// Contains profile information and preferences

import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    required String id,
    required String email,
    String? phoneNumber,
    String? fullName,
    String? avatarUrl,
    String? state,
    String? district,
    String? village,
    double? latitude,
    double? longitude,
    @Default('en') String languagePreference,
    @Default([]) List<String> cropsGrown,
    double? farmSize, // in acres
    String? soilType,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}
