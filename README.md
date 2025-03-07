<a href="https://flutter.dev/">
  <h1 align="center">
    <picture>
      <source media="(prefers-color-scheme: dark)" srcset="https://storage.googleapis.com/cms-storage-bucket/6e19fee6b47b36ca613f.png">
      <img alt="Flutter" src="https://storage.googleapis.com/cms-storage-bucket/c823e53b3a1a7b0d36a9.png">
    </picture>
  </h1>
</a>

[![Flutter CI Status](https://flutter-dashboard.appspot.com/api/public/build-status-badge?repo=flutter)](https://flutter-dashboard.appspot.com/#/build?repo=flutter)
[![codecov](https://codecov.io/gh/flutter/flutter/branch/master/graph/badge.svg?token=11yDrJU2M2)](https://codecov.io/gh/flutter/flutter)
[![CII Best Practices](https://bestpractices.coreinfrastructure.org/projects/5631/badge)](https://bestpractices.coreinfrastructure.org/projects/5631)
[![OpenSSF Scorecard](https://api.securityscorecards.dev/projects/github.com/flutter/flutter/badge)](https://deps.dev/project/github/flutter%2Fflutter)
[![SLSA 1](https://slsa.dev/images/gh-badge-level1.svg)](https://slsa.dev)

# Clean Architecture

A Flutter project demonstrating the implementation of Clean Architecture principles using Bloc State management with Rest API.
This project serves as an example project for building scalable and maintainable Flutter applications using Clean Architecture.

## Table of Contents

- [Introduction](#introduction)
- [Project Structure](#project-structure)
- [Setup](#setup)
- [Dependencies](#dependencies)

## Introduction

Clean Architecture, popularized by Robert C. Martin (Uncle Bob), aims to create systems that are:
- Independent of Frameworks
- Testable
- Independent of UI
- Independent of Database
- Independent of any external agency

This project integrates Hive for local storage, ensuring that our data layer remains fast and efficient.

## Project Structure

```
lib/
├── core/
│   ├── error/
│   └── routes/
├── features/
│   ├── feature_name/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
├── injection.dart
├── observer.dart
└── main.dart
```

## Setup

1. **Clone the repository:**

```bash
git clone https://github.com/kuldii/tutorial_clean_architecture.git
cd tutorial_clean_architecture
```

2. **Install dependencies:**

```bash
flutter clean
flutter pub upgrade --major-versions
flutter pub get
```

3. **Generate some missing part:**

```bash
dart run build_runner build --delete-conflicting-outputs
```

4. **Run the application:**

```bash
flutter run
```

## Dependencies

- [Bloc](https://pub.dev/packages/bloc)
- [Hive](https://pub.dev/packages/hive)
- [HTTP](https://pub.dev/packages/http)
- [INTL](https://pub.dev/packages/intl)
- [Dartz](https://pub.dev/packages/dartz)
- [Get It](https://pub.dev/packages/get_it)
- [Mockito](https://pub.dev/packages/mockito)
- [Go Router](https://pub.dev/packages/go_router)
- [Equatable](https://pub.dev/packages/equatable)
- [Path Provider](https://pub.dev/packages/path_provider)
- [Connectivity Plus](https://pub.dev/packages/connectivity_plus)

For more information on Flutter, visit the [official documentation](https://docs.flutter.dev/). If you're new to Flutter, consider starting with the [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab) or explore the [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook).
