import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int id;

  // final String iso6391;
  // final String iso31661;
  // final String name;
  // final bool includeAdult;
  final String username;

  const User({
    required this.id,
    // required this.iso6391,
    // required this.iso31661,
    // required this.name,
    // required this.includeAdult,
    required this.username,
  });

  @override
  List<Object?> get props => [
        id,
        username,
      ];
}
