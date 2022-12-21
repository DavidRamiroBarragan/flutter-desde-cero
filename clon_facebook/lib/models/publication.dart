class Publication {
  final String title;
  final DateTime createAt;
  final String imageUrl;
  final int commentsCount;
  final int shareCount;
  final User user;
  final Reaction reaction;

  Publication({
    required this.title,
    required this.createAt,
    required this.imageUrl,
    required this.commentsCount,
    required this.shareCount,
    required this.user,
    required this.reaction,
  });
}

class User {
  final String avatar;
  final String username;

  User({required this.avatar, required this.username});
}

enum Reaction {
  like,
  love,
  laughing,
  sad,
  shocking,
  angry,
}
