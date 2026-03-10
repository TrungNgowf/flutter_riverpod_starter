# Flutter Riverpod Starter

A production-ready Flutter starter template built with **Riverpod**, featuring a clean architecture, multi-environment support, robust networking layer, theming, localization, and code generation.

## Features

- **State Management** — Riverpod 3 with code generation (`riverpod_annotation`, `riverpod_generator`)
- **Routing** — Auto Route with shell-based bottom navigation
- **Networking** — Dio-based API client with auth, retry, error interceptors, and `BaseRepository`
- **Multi-Environment** — Dev / Staging / Production flavors with `envied` for secret management
- **Theming** — Complete Material 3 theme system with light/dark mode and `flex_seed_scheme`
- **Localization** — ARB-based i18n with English and Vietnamese, switchable at runtime
- **Code Generation** — Freezed, JSON serialization, auto_route, flutter_gen for assets
- **Logging** — Per-environment log levels using the `logger` package and Talker Dio logger
- **Feature Flags** — `AppConfig` with per-environment flags for analytics, crashlytics, and custom features
- **Functional Error Handling** — `fpdart` Either-based `ApiResult` pattern

## Project Structure

```
lib/
├── _main/                  # Entry points & app root
│   ├── app.dart            # AppRoot + MyApp (MaterialApp.router)
│   ├── main_dev.dart       # Dev entry point
│   ├── main_stg.dart       # Staging entry point
│   └── main_prod.dart      # Production entry point
├── core/
│   ├── config/             # AppConfig & FeatureFlags (per-env)
│   ├── environments/       # Env (envied-based secrets)
│   ├── logging/            # AppLogger (per-env log levels)
│   ├── network/
│   │   ├── api_client.dart       # Dio wrapper (auth + public)
│   │   ├── base_repository.dart  # BaseRepository + PaginationMixin
│   │   ├── endpoints.dart        # API endpoint constants
│   │   ├── token_manager/        # Token storage & refresh
│   │   ├── interceptors/         # Auth, Retry, Error interceptors
│   │   └── api_helpers/          # ApiResult, ApiResponse, ApiException
│   └── theme/              # AppTheme, AppColors, AppTypography, AppSizes
├── features/
│   ├── home/
│   ├── search/
│   ├── scan/
│   ├── notifications/
│   ├── settings/
│   ├── songs/              # Example feature (provider + state + page)
│   └── main_shell/         # Bottom navigation shell
├── gen/                    # Generated asset references (flutter_gen)
├── l10n/                   # Localizations (ARB files + providers)
├── models/                 # Shared models, enums (Flavor, AppLanguage, Song)
├── router/                 # AutoRouter configuration
├── services/               # Service layer (e.g. SongsService)
├── utils/                  # Extensions (BuildContext, Ref, Extendable)
└── widgets/                # Shared widgets
```

## Tech Stack

| Category | Package |
|---|---|
| State Management | `hooks_riverpod`, `riverpod_annotation`, `flutter_hooks` |
| Routing | `auto_route` |
| Networking | `dio`, `talker_dio_logger` |
| Serialization | `json_annotation`, `freezed_annotation` |
| Environment | `envied` |
| Theming | `flex_seed_scheme`, `google_fonts` |
| Localization | `flutter_localizations`, `intl` |
| Functional | `fpdart` |
| UI | `animated_bottom_navigation_bar`, `iconsax_flutter`, `loading_animation_widget` |
| Assets | `flutter_gen_runner` |

## Getting Started

### Prerequisites

- Flutter SDK `^3.10` (Dart `^3.10`)
- CocoaPods (for iOS development)
- A running backend or mock API

### Setup

1. **Clone the repository**

```bash
git clone <repo-url>
cd flutter_riverpod_starter
```

2. **Install dependencies**

```bash
flutter pub get
```

3. **Create environment files** in the project root (these are gitignored and **must** exist before code generation):

```bash
touch .env.dev .env.stg .env.prod
```

Each file should contain at minimum:

```
BASE_URL=https://api.example.com
```

4. **Run code generation** (generates Riverpod providers, Freezed classes, routes, env bindings, and asset refs):

```bash
dart run build_runner build --delete-conflicting-outputs
```

5. **iOS setup**

```bash
cd ios && pod install && cd ..
```

6. **(Optional) Generate launcher icons** — requires `assets/images/ic_launcher.png`:

```bash
dart run flutter_launcher_icons
```

7. **(Optional) Change app package name** — to replace the default `dev.turng.flutter_riverpod_starter`:

```bash
dart run change_app_package_name:main com.yourcompany.yourapp
```

### Running the App

Each flavor requires both `--flavor` and `-t` (target entry point):

```bash
# Development
flutter run --flavor develop -t lib/_main/main_dev.dart

# Staging
flutter run --flavor staging -t lib/_main/main_stg.dart

# Production
flutter run --flavor production -t lib/_main/main_prod.dart
```

Non-production builds display a flavor banner in the top-right corner.

### Building for Release

```bash
# Android APK
flutter build apk --flavor production -t lib/_main/main_prod.dart

# Android App Bundle
flutter build appbundle --flavor production -t lib/_main/main_prod.dart

# iOS
flutter build ios --flavor production -t lib/_main/main_prod.dart
```

## Environment Configuration

| Flavor | Logging | Analytics | Crashlytics |
|---|---|---|---|
| `develop` | On | Off | Off |
| `staging` | On | Off | Off |
| `production` | Off | On | On |

Feature flags are managed in `lib/core/config/app_config.dart` and can be toggled per environment.

## Code Generation

This project relies on `build_runner` for several generators:

| Generator | Purpose |
|---|---|
| `riverpod_generator` | Generates Riverpod providers from annotations |
| `freezed` | Generates immutable data classes and unions |
| `json_serializable` | Generates JSON serialization code |
| `auto_route_generator` | Generates route definitions |
| `envied_generator` | Generates environment variable bindings |
| `flutter_gen_runner` | Generates type-safe asset references |

Regenerate all at once:

```bash
dart run build_runner build --delete-conflicting-outputs
```

Or watch for changes:

```bash
dart run build_runner watch --delete-conflicting-outputs
```

## Localization

Supported locales: **English** (`en`), **Vietnamese** (`vi`).

ARB files are located in `lib/l10n/arb/`. To add or update translations:

1. Edit `app_en.arb` and `app_vi.arb`
2. Run `flutter gen-l10n` (or rely on `generate: true` in `pubspec.yaml`)

Language can be switched at runtime via `AppLanguageController`.

## Architecture Overview

```
UI (Pages/Widgets)
    ↓ watches
Providers (Riverpod)
    ↓ calls
Services
    ↓ uses
BaseRepository → ApiClient → Dio
                              ↓
                  Interceptors (Auth → Retry → Logger → Error)
```

- **Pages** consume Riverpod providers and render UI.
- **Providers** hold state and orchestrate business logic.
- **Services** encapsulate domain operations and interact with repositories.
- **BaseRepository** provides parsing helpers; **ApiClient** wraps Dio with type-safe `ApiResult<T>` responses.
