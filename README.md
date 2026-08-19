# Riders Keeper Mobile

## Motorcycle Preventive Maintenance System

Riders Keeper is a Flutter mobile application designed to help motorcycle owners manage their motorcycles and preventive maintenance activities.

The application provides features for motorcycle management, maintenance scheduling, service history, reminders, and user profile management.

## Current Status

🚧 **In Development**

The initial UI implementation and application navigation have been completed.

The application currently uses **static/mock data** for UI development while the backend API is being developed and integrated.

### Completed

* [x] Flutter project setup
* [x] Application architecture setup
* [x] Feature-first project structure
* [x] Atomic Design implementation
* [x] Authentication UI
* [x] Login navigation
* [x] Sign-up navigation
* [x] Forgot password navigation
* [x] Main application navigation
* [x] Home screen UI
* [x] Motorcycle management UI
* [x] Calendar UI
* [x] Profile UI
* [x] Reusable UI components
* [x] Static/mock data for UI development

### In Progress

* [ ] Backend API development
* [ ] Database integration
* [ ] Authentication API integration
* [ ] Motorcycle API integration
* [ ] Maintenance API integration
* [ ] Replace static/mock data with API data
* [ ] Loading and error state handling
* [ ] Production testing

## Tech Stack

### Mobile

* Flutter
* Dart
* Riverpod
* GoRouter

### Backend

* Spring Boot
* PostgreSQL

## Architecture

The application follows a **feature-first architecture** combined with **Atomic Design** for building reusable UI components.

### Feature-First Architecture

Application features are organized under the `features` directory.

Each feature can contain its own presentation, data, and domain layers as development progresses.

Examples include:

* Authentication
* Home
* Calendar
* Motorcycle
* Profile

This structure keeps feature-specific code organized and makes the application easier to maintain and scale.

### Atomic Design

Reusable UI components are organized under:

```text
core/design_system/
```

The design system follows the Atomic Design methodology:

* **Atoms** — Small, reusable UI elements such as buttons, text fields, labels, icons, and other basic components.
* **Molecules** — Combinations of atoms that form reusable UI components.
* **Organisms** — More complex UI sections composed of atoms and molecules.
* **Templates** — Reusable layouts that define the structure of screens.

Feature-specific templates are kept inside their respective feature's presentation layer.

For example:

```text
core/design_system/templates/
```

contains globally reusable templates, while:

```text
features/home/presentation/templates/
```

contains templates specific to the Home feature.

## Project Structure

```text
lib/
├── app/
│   ├── app.dart
│   └── config/
│       └── router/
│
├── core/
│   ├── constants/
│   ├── design_system/
│   │   ├── atoms/
│   │   ├── molecules/
│   │   ├── organisms/
│   │   └── templates/
│   ├── enum/
│   ├── network/
│   └── types/
│
├── features/
│   ├── auth/
│   │
│   ├── calendar/
│   │   └── presentation/
│   │
│   ├── home/
│   │   └── presentation/
│   │       ├── screens/
│   │       └── templates/
│   │
│   ├── motorcycle/
│   │   └── presentation/
│   │
│   └── profile/
│
└── main.dart
```

The project structure will evolve as backend integration and additional application features are implemented.

## UI Development

The UI is built using reusable components based on the Atomic Design methodology.

The application uses:

```text
Atoms
  ↓
Molecules
  ↓
Organisms
  ↓
Templates
  ↓
Screens
```

This approach helps minimize duplicated UI code and allows common components to be reused across different screens and features.

## Development Workflow

Development is currently divided into two major phases.

### 1. UI and Navigation

The first phase focuses on establishing the application's UI and navigation foundation.

* Build application screens
* Create reusable Atomic Design components
* Create feature-specific templates
* Implement application navigation
* Establish authentication navigation
* Use static/mock data where necessary

### 2. Backend Integration

The second phase focuses on connecting the mobile application to the backend.

* Develop REST APIs
* Connect Flutter to the Spring Boot backend
* Implement authentication
* Implement motorcycle management APIs
* Implement maintenance APIs
* Replace static/mock data with API responses
* Implement loading and error states
* Persist application data
* Perform integration and production testing

## Backend Integration

The Flutter application is being developed independently from the backend so that UI development can continue using static/mock data.

Once the backend APIs are available, the static data will be replaced with API-driven data through the application's network and data layers.

## Project Status

The project is actively under development.

The **UI and navigation foundation has been completed**, including reusable Atomic Design components and feature-specific screens.

The **backend API and database integration are currently in progress**. Static/mock data is being used temporarily until the backend integration is completed.
