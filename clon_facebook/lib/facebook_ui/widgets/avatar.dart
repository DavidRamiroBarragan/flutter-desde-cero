import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  final double size;
  final String asset;
  final double border;

  const Avatar(
      {Key? key, required this.size, required this.asset, this.border = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final fromNetwork =
        asset.startsWith('http://') || asset.startsWith('https://');
    final imageProvider = fromNetwork ? NetworkImage(asset) : AssetImage(asset);
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        border: Border.all(
          width: border,
          color: Colors.white,
        ),
        shape: BoxShape.circle,
        image: DecorationImage(
          image: imageProvider as ImageProvider,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
