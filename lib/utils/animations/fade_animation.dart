import 'package:flutter/material.dart';

/// --- Fade animation ---

class FadeAnimation extends StatefulWidget {
  const FadeAnimation({
    Key? key,
    required this.child,
    this.duration = const Duration(milliseconds: 600),
    this.delay = const Duration(milliseconds: 0),
  }) : super(key: key);

  final Widget child;
  final Duration duration;
  final Duration delay;

  @override
  State<FadeAnimation> createState() => _FadeAnimationState();
}

class _FadeAnimationState extends State<FadeAnimation> with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this, duration: widget.duration);
    animation = CurvedAnimation(parent: animationController, curve: Curves.easeOut);

    /// do animate
    Future.delayed(widget.delay, () {
      animationController.forward();
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (BuildContext context, Widget? child) {
        return Opacity(
          opacity: animation.value,
          child: widget.child,
        );
      },
    );
  }
}

/// --- FadeInDownAnimation ---
class FadeInDownAnimation extends StatefulWidget {
  const FadeInDownAnimation({
    Key? key,
    required this.child,
    this.duration = const Duration(milliseconds: 800),
    this.delay = const Duration(milliseconds: 0),
  }) : super(key: key);

  final Widget child;
  final Duration duration;
  final Duration delay;

  @override
  State<FadeInDownAnimation> createState() => _FadeInDownAnimationState();
}

class _FadeInDownAnimationState extends State<FadeInDownAnimation> with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;
  late Animation<double> opacity;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this, duration: widget.duration);

    animation = Tween<double>(begin: -100, end: 0).animate(CurvedAnimation(parent: animationController, curve: Curves.easeOut));
    opacity = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: animationController, curve: Curves.easeOut));

    /// do animate
    Future.delayed(widget.delay, () {
      animationController.forward();
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget? child) {
        return Transform.translate(
          offset: Offset(0, animation.value),
          child: Opacity(
            opacity: opacity.value,
            child: widget.child,
          ),
        );
      },
    );
  }
}

/// --- FadeInUpAnimation ---
class FadeInUpAnimation extends StatefulWidget {
  const   FadeInUpAnimation({
    Key? key,
    required this.child,
    this.duration = const Duration(milliseconds: 800),
    this.delay = const Duration(milliseconds: 0),
  }) : super(key: key);

  final Widget child;
  final Duration duration;
  final Duration delay;

  @override
  State<FadeInUpAnimation> createState() => _FadeInUpAnimationState();
}

class _FadeInUpAnimationState extends State<FadeInUpAnimation> with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;
  late Animation<double> opacity;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this, duration: widget.duration);

    animation = Tween<double>(begin: 100, end: 0).animate(CurvedAnimation(parent: animationController, curve: Curves.easeOut));
    opacity = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: animationController, curve: Curves.easeOut));

    /// do animate
    Future.delayed(widget.delay, () {
      animationController.forward();
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget? child) {
        return Transform.translate(
          offset: Offset(0, animation.value),
          child: Opacity(
            opacity: opacity.value,
            child: widget.child,
          ),
        );
      },
    );
  }
}

/// --- FadeInLeftAnimation ---

class FadeInLeftAnimation extends StatefulWidget {
  const FadeInLeftAnimation({
    Key? key,
    required this.child,
    this.duration = const Duration(milliseconds: 800),
    this.delay = const Duration(milliseconds: 0),
  }) : super(key: key);

  final Widget child;
  final Duration duration;
  final Duration delay;

  @override
  State<FadeInLeftAnimation> createState() => _FadeInLeftAnimationState();
}

class _FadeInLeftAnimationState extends State<FadeInLeftAnimation> with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;
  late Animation<double> opacity;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this, duration: widget.duration);

    animation = Tween<double>(begin: -100, end: 0).animate(CurvedAnimation(parent: animationController, curve: Curves.easeOut));
    opacity = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: animationController, curve: Curves.easeOut));

    /// do animate
    Future.delayed(widget.delay, () {
      animationController.forward();
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget? child) {
        return Transform.translate(
          offset: Offset(animation.value, 0),
          child: Opacity(
            opacity: opacity.value,
            child: widget.child,
          ),
        );
      },
    );
  }
}

/// --- FadeInRightAnimation ---

class FadeInRightAnimation extends StatefulWidget {
  const FadeInRightAnimation({
    Key? key,
    required this.child,
    this.duration = const Duration(milliseconds: 800),
    this.delay = const Duration(milliseconds: 0),
  }) : super(key: key);

  final Widget child;
  final Duration duration;
  final Duration delay;

  @override
  State<FadeInRightAnimation> createState() => _FadeInRightAnimationState();
}

class _FadeInRightAnimationState extends State<FadeInRightAnimation> with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;
  late Animation<double> opacity;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this, duration: widget.duration);

    animation = Tween<double>(begin: 100, end: 0).animate(CurvedAnimation(parent: animationController, curve: Curves.easeOut));
    opacity = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: animationController, curve: Curves.easeOut));

    /// do animate
    Future.delayed(widget.delay, () {
      animationController.forward();
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget? child) {
        return Transform.translate(
          offset: Offset(animation.value, 0),
          child: Opacity(
            opacity: opacity.value,
            child: widget.child,
          ),
        );
      },
    );
  }
}
