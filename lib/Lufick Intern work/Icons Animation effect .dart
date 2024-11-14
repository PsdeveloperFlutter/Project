import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(BounceEffectApp());
}

class BounceEffectApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      home: CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text("Bounce Effect Example"),
        ),
        child: BounceEffectWidget(),
      ),
    );
  }
}

class BounceEffectWidget extends StatefulWidget {
  @override
  _BounceEffectWidgetState createState() => _BounceEffectWidgetState();
}

class _BounceEffectWidgetState extends State<BounceEffectWidget> with SingleTickerProviderStateMixin {
  bool isTapped = false;

  void _onIconTap() {
    setState(() {
      isTapped = true; // Trigger the bounce effect
    });

    // Reset the state after the animation completes
    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        isTapped = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: _onIconTap,
        child: AnimatedScale(
          scale: isTapped ? 1.8 : 1.0, // Scale up on tap
          duration: const Duration(milliseconds: 200),
          child: Icon(
            CupertinoIcons.hand_thumbsup,
            size: 100,
            color: CupertinoColors.activeBlue,
          ),
        ),
      ),
    );
  }
}
