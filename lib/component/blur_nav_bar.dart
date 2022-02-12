import 'dart:ui';
import 'package:flutter/material.dart';

import 'blur_nav_bar_item.dart';

class BlurNavBar extends StatelessWidget {
  final int currentIndex;
  final List<BlurNavBarItem> items;
  final ValueChanged<int> onChanged;
  final BoxBorder? border;
  final BorderRadiusGeometry? borderRadius;
  final BorderRadiusGeometry? barBorderRadius;
  final Color backgroundColor;
  final Color shadowColor;
  final Color barColor;
  final EdgeInsetsGeometry? margin;

  const BlurNavBar({
    Key? key,
    required this.currentIndex,
    required this.items,
    required this.onChanged,
    this.border,
    this.borderRadius,
    this.barBorderRadius,
    this.shadowColor = Colors.green,
    this.backgroundColor = Colors.black26,
    this.barColor = Colors.green,
    this.margin,
  })  : assert(items.length >= 2),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? const EdgeInsets.all(8.0),
      child: Material(
        color: Colors.transparent,
        elevation: 0,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius ?? BorderRadius.circular(16),
        ),
        child: SizedBox(
          height: kBottomNavigationBarHeight + 4,
          child: Column(
            children: [
              SizedBox(
                height: kBottomNavigationBarHeight,
                child: Stack(
                  children: [
                    /// build shadows
                    Positioned.fill(
                      bottom: -kBottomNavigationBarHeight,
                      child: Row(
                        children: List.generate(
                          items.length,
                          (index) => TweenAnimationBuilder<double>(
                            duration: const Duration(milliseconds: 300),
                            tween: Tween(end: currentIndex == index ? 1 : 0),
                            builder: (context, t, child) => Expanded(
                              child: Container(
                                height: lerpDouble(0, kBottomNavigationBarHeight, t),
                                decoration: BoxDecoration(
                                  color: Color.lerp(Colors.transparent, shadowColor, t),
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    /// build items
                    Positioned.fill(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Container(
                          decoration: BoxDecoration(
                            color: backgroundColor,
                            borderRadius: borderRadius ?? BorderRadius.circular(16),
                            border: border ?? Border.all(color: Colors.white70),
                          ),
                          child: Row(
                            children: List.generate(
                              items.length,
                              (index) => Expanded(
                                child: TweenAnimationBuilder<double>(
                                  duration: const Duration(milliseconds: 200),
                                  tween: Tween(end: currentIndex == index ? 1 : 0),
                                  builder: (context, t, child) => InkWell(
                                    onTap: () => onChanged.call(index),
                                    hoverColor: shadowColor.withOpacity(0.1),
                                    splashColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    child: Transform.scale(
                                      scale: lerpDouble(0.95, 1, t),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            items[index].icon,
                                            color: Colors.white,
                                          ),
                                          Text(
                                            items[index].label,
                                            style: Theme.of(context).textTheme.caption!.copyWith(
                                                  color: Colors.white,
                                                ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              /// build bars
              Row(
                children: List.generate(
                  items.length,
                  (index) => TweenAnimationBuilder<double>(
                    duration: const Duration(milliseconds: 200),
                    tween: Tween(end: currentIndex == index ? 1 : 0),
                    builder: (context, t, child) => Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: lerpDouble(0, 4, t),
                            width: kBottomNavigationBarHeight / 2,
                            decoration: BoxDecoration(
                              color: Color.lerp(Colors.transparent, barColor, t),
                              borderRadius: barBorderRadius ??
                                  const BorderRadius.only(
                                    bottomLeft: Radius.circular(4),
                                    bottomRight: Radius.circular(4),
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
