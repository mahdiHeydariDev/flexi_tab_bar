library flexi_tab_bar;

import 'package:flutter/material.dart';

/// A configuration class for creating a flexible tab bar in Flutter.
class FlexiTabBarConfig {
  /// List of tab titles.
  final List<String> titles;

  /// List of corresponding tab views.
  final List<Widget> views;

  /// Initial page index to display when the tab bar is first rendered.
  final int initialPage;

  /// Page controller for managing tab switching.
  final PageController pageController;

  /// Constructs a FlexiTabBarConfig instance.
  ///
  /// [titles] is a required list of tab titles.
  ///
  /// [views] is a required list of corresponding tab views.
  ///
  /// [initPage] specifies the initial page index to display when the tab bar is first rendered.
  ///
  /// [pageController] is required for managing tab switching.
  FlexiTabBarConfig({
    required this.titles,
    required this.views,
    required this.initialPage,
    required this.pageController,
  }) : assert(titles.length == views.length, 'Number of titles must match number of views');
}

/// A class representing the decoration properties for a FlexiTabBar.
class FlexiTabBarDecoration {
  /// Decoration for the tab bar.
  final BoxDecoration? tabBarDecoration;

  /// Height of the tab bar.
  final double? height;

  /// Margin applied to the tab bar.
  final EdgeInsets? margin;

  /// Page controller for managing tab switching.
  final PageController pageController;

  /// Text style for active tab labels.
  final TextStyle? activeLabelTextStyle;

  /// Text style for inactive tab labels.
  final TextStyle? inactiveLabelTextStyle;

  /// Color for the active tab indicator.
  final Color? tabBarActiveColor;

  /// Duration for animation when switching tabs.
  final Duration? animationDuration;

  /// Constructs a FlexiTabBarDecoration instance.
  /// [pageController] is required for managing tab switching.
  ///
  /// [tabBarDecoration] allows customization of the tab bar's appearance.
  ///
  /// [height] sets the height of the tab bar.
  ///
  /// [margin] applies margin to the tab bar.
  ///
  /// [activeLabelTextStyle] specifies the text style for active tab labels.
  ///
  /// [inactiveLabelTextStyle] specifies the text style for inactive tab labels.
  ///
  /// [tabBarActiveColor] sets the color for the active tab indicator.
  ///
  /// [animationDuration] determines the duration for tab switching animations.
  FlexiTabBarDecoration({
    this.tabBarDecoration,
    required this.pageController,
    this.height,
    this.margin,
    this.activeLabelTextStyle,
    this.inactiveLabelTextStyle,
    this.tabBarActiveColor,
    this.animationDuration,
  });
}

class FlexiTabBar extends StatefulWidget {
  final FlexiTabBarDecoration? flexiTabBarDecoration;
  final FlexiTabBarConfig flexiTabBarConfig;

  const FlexiTabBar({
    super.key,
    this.flexiTabBarDecoration,
    required this.flexiTabBarConfig,
  });

  @override
  State<FlexiTabBar> createState() => _FlexiTabBarState();
}

class _FlexiTabBarState extends State<FlexiTabBar> {
  int currentPage = 0;
  @override
  void initState() {
    currentPage = widget.flexiTabBarConfig.initialPage;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Container(
            height: widget.flexiTabBarDecoration?.height ?? 60,
            width: double.infinity,
            margin: widget.flexiTabBarDecoration?.margin ??
                const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
            decoration: widget.flexiTabBarDecoration?.tabBarDecoration ??
                BoxDecoration(
                  color: const Color(0xffFFFFFF),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: const Color(
                      0xffC4D7ED,
                    ),
                  ),
                ),
            child: Row(
              children: <Widget>[
                for (var i = 0; i < widget.flexiTabBarConfig.views.length; i++)
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        widget.flexiTabBarConfig.pageController.animateToPage(
                          i,
                          duration: const Duration(
                            milliseconds: 400,
                          ),
                          curve: Curves.linear,
                        );
                        setState(() {
                          currentPage = i;
                        });
                      },
                      child: AnimatedContainer(
                        duration: widget.flexiTabBarDecoration?.animationDuration ??
                            const Duration(
                              milliseconds: 400,
                            ),
                        curve: Curves.linear,
                        decoration: BoxDecoration(
                          color: currentPage == i ? widget.flexiTabBarDecoration?.tabBarActiveColor ?? const Color(0xff00639B) : Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            widget.flexiTabBarConfig.titles[i],
                            style: i == currentPage
                                ? widget.flexiTabBarDecoration?.activeLabelTextStyle ??
                                    const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    )
                                : widget.flexiTabBarDecoration?.inactiveLabelTextStyle ??
                                    const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Expanded(
            child: PageView.builder(
              itemCount: widget.flexiTabBarConfig.views.length,
              controller: widget.flexiTabBarConfig.pageController,
              itemBuilder: (context, index) {
                return Padding(
                  padding: widget.flexiTabBarDecoration?.margin ??
                      const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                  child: widget.flexiTabBarConfig.views[index],
                );
              },
              onPageChanged: (newIndex) {
                setState(() {
                  currentPage = newIndex;
                });
              },
            ),
          )
        ],
      ),
    );
  }
}
