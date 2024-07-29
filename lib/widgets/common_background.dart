import 'package:flutter/material.dart';

class CommonBackground extends StatelessWidget {
  final Widget child;
  final bool isFullWidth;

  const CommonBackground(
      {super.key, required this.child, this.isFullWidth = true, appBar});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Stack(children: [
        Container(
            height: isFullWidth
                ? MediaQuery.sizeOf(context).height
                : MediaQuery.sizeOf(context).height * 0.73,
            decoration: BoxDecoration(
                borderRadius: isFullWidth
                    ? null
                    : const BorderRadius.only(
                        bottomRight: Radius.circular(30.0),
                        bottomLeft: Radius.circular(30.0)),
                image: const DecorationImage(
                    image: AssetImage('assets/background_image.png'),
                    fit: BoxFit.fill))),
        child
      ]),
    );
  }
}
