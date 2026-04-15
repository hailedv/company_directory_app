# Company Directory App

A Flutter mobile application for browsing and managing a directory of companies. Users can explore company details, save favorites, and submit feedback — all backed by a REST API with local persistence.

---

## Features

- Fetch and display a live list of companies from a REST API
- View full company details (name, industry, address, country, employee count, CEO)
- Search companies by name or industry in real time
- Filter to show favorites only
- Mark/unmark companies as favorites with persistent local storage
- Dark mode with persistent preference
- Feedback form with name, email, and message validation
- Auto-fills feedback form with previously saved user info
- Pull-to-refresh company list
- Error handling with retry support
- Clean loading and empty states

---

## Tech Stack

| Layer | Technology |
|---|---|
| Framework | Flutter 3.x (Dart) |
| State Management | GetX |
| HTTP Client | http |
| Local Storage | shared_preferences |
| Architecture | MVC + Service Layer |

---

## Project Structure

```
lib/
├── controllers/
│   └── company_controller.dart   # Business logic, favorites, data loading
├── models/
│   └── company.dart              # Company data model with JSON serialization
├── screens/
│   ├── home_screen.dart          # Company list with search and favorites
│   ├── detail_screen.dart        # Full company detail view
│   └── feedback_screen.dart      # Feedback form with validation
├── services/
│   ├── api_service.dart          # REST API calls
│   └── local_storage_service.dart # Favorites and user info persistence
├── utils/
│   └── constants.dart            # App-wide constants and route names
└── main.dart
```

---

## Getting Started

### Prerequisites

- Flutter SDK `>=3.0.0`
- Dart SDK `>=3.0.0`

### Installation

```bash
# Clone the repository
git clone https://github.com/your-username/company_directory_app.git

cd company_directory_app

# Install dependencies
flutter pub get

# Run the app
flutter run
```

---

## API

Data is fetched from the [Beeceptor Mock API](https://beeceptor.com).

| Method | Endpoint | Description |
|---|---|---|
| GET | `/companies` | Fetch all companies |

Base URL: `https://fake-json-api.mock.beeceptor.com`

---

## Data Model

```dart
Company {
  int     id
  String  name
  String  address
  String  country
  int     employeeCount
  String  industry
  String  ceoName
  bool    isFavorite
}
```

---

## Screenshots

> Coming soon

---

## License

This project is open source and available under the [MIT License](LICENSE).
