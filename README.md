# Flexi Tab Bar

A flexible and customizable tab bar widget for Flutter.

## Overview

Flexi Tab Bar provides a versatile tab bar solution for Flutter applications, allowing developers to easily create tabbed interfaces with custom styling and functionality.

## Features

- Supports dynamic tab titles and views.
- Customizable tab bar decoration including height, margin, and text styles.
- Smooth tab switching animations with customizable duration.
- Easy-to-use API for integrating tab bar functionality into your Flutter apps.

## Installation

To use Flexi Tab Bar in your Flutter project, add the following dependency to your `pubspec.yaml` file:

```yaml
dependencies:
  flexi_tab_bar: ^0.0.1
  ```

## Usage
```dart

import 'package:flexi_tab_bar/flexi_tab_bar.dart';

// Example usage
FlexiTabBar(
  flexiTabBarConfig: FlexiTabBarConfig(
    titles: ['Tab 1', 'Tab 2', 'Tab 3'],
    views: [Container(color:Colors.red), Container(color:Colors.yellow),Container(color:Colors.blue),],
    initialPage: 0,
    pageController: PageController(),
  ),
);
```