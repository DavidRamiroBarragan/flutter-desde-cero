import 'package:freezed_annotation/freezed_annotation.dart';

import '../../typedefs.dart';

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

  factory User.fromJson(Json json) => _$UserFromJson(json);
}

String? avatarPathFromJson(Json json) {
  return json['tmdb']?['avatar_path'] as String?;
}
