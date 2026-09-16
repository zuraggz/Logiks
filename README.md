# Logiks CRUD

A Flutter app for managing a collection of LEGO sets through a REST API, built with the MVVM
pattern. Each set has a name, release year, price, piece count and minifigure count.

## Features

- **List screen:** shows every set's name and ID, with pull-to-refresh, a loading indicator and an
  error state with a Retry button
- **Details screen:** tap a set to see all of its information
- **Create and edit:** forms with input validation
- **Delete:** from the list's menu or the details screen, with a confirmation dialog
- **Feedback:** a snackbar message after each successful or failed action

## Prerequisites

| Requirement | Version |
| --- | --- |
| Flutter SDK | 3.32 or later, stable channel (developed and tested on 3.47.2) |
| Dart SDK | 3.13.2 or later (bundled with Flutter) |

## Getting Started

```bash
git clone https://github.com/zuraggz/Logiks.git
cd Logiks
flutter pub get
flutter run
```

### Running on a specific platform

The project includes Android, iOS, Web, Windows and Linux targets. List the available devices
with `flutter devices`, then run:

```bash
flutter run -d chrome        # Web
flutter run -d windows       # Windows desktop
flutter run -d linux         # Linux desktop
flutter run -d <device-id>   # Android / iOS
```

### Static analysis

```bash
flutter analyze
```

## Architecture

The app follows MVVM (Model–View–ViewModel):

- **Views** (`views/`) build the UI and pass user actions to their view model.
- **View models** (`view_models/`) sit between the views and the service layer. `HomeViewModel`
  extends `ChangeNotifier` and holds the list, loading and error state; `HomePage` listens to it
  and rebuilds when it changes.
- **Service** (`services/`) makes the HTTP requests.
- **Model** (`models/`) converts `Lego` objects to and from JSON.

```
lib/
├── main.dart              # App entry point, theme and scroll behaviour
├── models/
│   └── lego.dart          # Lego model and JSON serialisation
├── services/
│   └── legos_service.dart # REST client
├── view_models/
│   ├── home_view_model.dart
│   ├── details_view_model.dart
│   ├── edit_view_model.dart
│   └── lego_add_view_model.dart
├── views/
│   ├── home_page.dart
│   ├── details_page.dart
│   ├── edit_page.dart
│   └── lego_add_page.dart
└── utils/
    ├── dialogs.dart       # Delete confirmation dialog
    ├── snackbar_utils.dart
    └── validators.dart    # Form field validators
```

## API

The backend is [restful-api.dev](https://restful-api.dev), using the `legos` collection.
Base URL: `https://api.restful-api.dev/collections/legos/objects`

| Operation | Method | Path |
| --- | --- | --- |
| `fetchAll` | `GET` | `/` |
| `create` | `POST` | `/` |
| `updateById` | `PUT` | `/{id}` |
| `deleteById` | `DELETE` | `/{id}` |

Example object:

```json
{
  "id": "…",
  "name": "Millennium Falcon",
  "data": { "year": 2017, "price": 849.99, "pieces": 7541, "minifigures": 8 }
}
```

## Note on the API Key

The API key in `lib/services/legos_service.dart` is committed on purpose, so the project runs
right after cloning without any setup. It only grants access to this sandbox collection. In
production, I would pass it in at build time with `--dart-define` and read it with
`String.fromEnvironment`.

restful-api.dev's free plan allows **1000 requests per day**. If the list shows
"Couldn't load Legos", the daily limit has probably been reached and it will work again once the
limit resets.
