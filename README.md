# Logiks CRUD

A Flutter application demonstrating full CRUD (Create, Read, Update, Delete) operations against a
REST backend, implemented using an MVVM architecture. The app manages a collection of LEGO set
records — each with a name, release year, price, piece count, and minifigure count.

---

## Documentation Status

Please note that the contents of this README have been drafted with AI assistance in order to
provide immediate onboarding and setup guidance for reviewers. This document should be regarded as
an interim deliverable rather than a final one. I intend to review, revise, and expand this
documentation personally — including a more detailed architectural overview, API contract
definitions, and inline code documentation — as my schedule permits.

---

## Prerequisites

| Requirement | Version |
| --- | --- |
| Flutter SDK | 3.13.2 or later (stable channel) |
| Dart SDK | 3.13.2 or later (bundled with Flutter) |

Verify your local toolchain before proceeding:

```bash
flutter --version
flutter doctor
```

## Running the Application

**1. Clone the repository**

```bash
git clone <repository-url>
cd Logiks-main
```

**2. Install dependencies**

This step is required. The `.dart_tool/` directory containing resolved package references is
intentionally excluded from version control, so package imports will not resolve until this command
has been executed:

```bash
flutter pub get
```

**3. Launch the application**

```bash
flutter run
```

### Platform-Specific Execution

This project is configured for Android, iOS, Web, Windows, Linux, and macOS. To review the list of
connected devices and available targets:

```bash
flutter devices
```

To launch against a specific target:

```bash
flutter run -d chrome     # Web
flutter run -d windows    # Windows desktop
flutter run -d macos      # macOS desktop
flutter run -d <device-id>  # Android / iOS
```

### Static Analysis

```bash
flutter analyze
```

## Project Structure

```
lib/
├── main.dart              # Application entry point, theme, and scroll behaviour
├── models/                # Data models and JSON serialisation
│   └── lego.dart
├── services/              # Network layer / REST client
│   └── legos_service.dart
├── view_models/           # Presentation logic, decoupled from the UI layer
│   ├── home_view_model.dart
│   ├── details_view_model.dart
│   ├── edit_view_model.dart
│   └── lego_add_view_model.dart
├── views/                 # UI screens
│   ├── home_page.dart
│   ├── details_page.dart
│   ├── edit_page.dart
│   └── lego_add_page.dart
└── utils/                 # Shared helpers
    ├── dialogs.dart
    ├── snackbar_utils.dart
    └── validators.dart
```

The `services` layer exposes four operations — `fetchAll`, `create`, `updateById`, and
`deleteById` — which map directly onto the corresponding REST endpoints.

## Configuration Note — API Key

The API key used by `lib/services/legos_service.dart` has been committed to the repository
deliberately, so that the project can be cloned and run for review without additional configuration
steps. The backend is a public sandbox service (`restful-api.dev`) and the credential carries no
sensitive access.

In a production context this value would not be checked into source control. The appropriate
approach would be to supply it at build time via `--dart-define` and read it through
`String.fromEnvironment`, or to source it from a secrets manager as part of the deployment pipeline.
