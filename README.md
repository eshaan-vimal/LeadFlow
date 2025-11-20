# LeadFlow - Mini Lead Management App

**📲 Download & Run Immediately:**
You do not need to set up Flutter to test this application.
**[Click here to download the Release APK](./LeadFlow.apk)** to your Android device.

---

A robust, offline-first CRM application built with Flutter and SQLite. Designed to manage sales leads efficiently with features like status filtering, search, and theme persistence.

Built as a submission for the Flutter Internship Assignment.

## App Overview

LeadFlow allows users to track potential clients through a sales pipeline. It features a clean, responsive UI that adheres to Material 3 design principles.

**Key Features:**

* **Dashboard:** View leads with color-coded status indicators.
* **Smart Filtering:** Filter leads by status (New, Contacted, Converted, Lost).
* **Search:** Dedicated search interface for finding leads by name across the database.
* **CRUD Operations:** Create, Read, Update, and Delete leads.
* **Theme Support:** Light and Dark mode support with persistent user preference.
* **Offline Storage:** All data is stored locally using SQLite, ensuring privacy and offline access.

## Tech Stack & Packages

* **Framework:** Flutter (Dart)
* **State Management:** flutter_bloc (BLoC Pattern)
* **Value Equality:** equatable
* **Local Database:** sqflite (SQLite)
* **Theme Persistence:** shared_preferences
* **Typography:** google_fonts

## Architecture

The project follows Clean Architecture principles to ensure scalability, testability, and separation of concerns.

### Layer Breakdown

1.  **Presentation Layer (lib/presentation)**
    * Contains all UI components (Screens, Widgets).
    * The UI is passive; it displays data and sends events to the Business Logic layer.
    * Connects to the BLoC to listen for state changes.

2.  **Business Logic Layer (lib/logic)**
    * **BLoC:** Acts as the bridge between data and UI. It handles complex logic like CRUD operations and filtering.
    * **Cubit:** Used for simpler global state, specifically for toggling and persisting the application theme.

3.  **Data Layer (lib/data)**
    * **Repositories:** The single source of truth for the app. It abstracts the data source from the business logic.
    * **Data Providers:** The raw database implementation executing SQL commands.
    * **Models:** Data classes with JSON serialization logic.

### Project Structure

```
lib/ 
├── data/
│   ├── dataproviders/ # Raw SQLite database logic 
│   ├── models/ # Data models (Lead) 
│   └── repositories/ # Repository pattern implementation 
├── logic/ 
│   └── bloc/ # BLoC (Lead logic) and Cubit (Theme logic) 
├── presentation/ 
│   ├── screens/ # Full application screens 
│   └── widgets/ # Reusable UI components 
└── main.dart # Entry point and Dependency Injection
```

## How to Run

1.  **Prerequisites**
    Ensure you have the Flutter SDK installed and configured.

2.  **Clone the repository**
    ```
    git clone [YOUR_REPO_LINK_HERE]
    ```

3.  **Install Dependencies**
    Navigate to the project directory and run:
    ```
    flutter pub get
    ```

4.  **Run the App**
    Connect a device or start an emulator, then run:
    ```
    flutter run
    ```