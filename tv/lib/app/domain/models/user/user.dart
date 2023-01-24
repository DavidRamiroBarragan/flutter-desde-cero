import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  const User._();

  const factory User({
    required int id,
    required String username,
    @JsonKey(
      fromJson: avatarPathFromJson,
      name: 'avatar',
    )
        String? avatarPath,
  }) = _User;

  String getFormatted() {
    return '$username $id';
  }

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}

String? avatarPathFromJson(Map<String, dynamic> json) {
  return json['tmdb']?['avatar_path'] as String?;
}
