# CineScope 🎬

CineScope is an iOS application currently in development that allows users to discover and explore movies. The app integrates with the [TMDB (The Movie Database) API](https://www.themoviedb.org/) to fetch and display up-to-date movie information.

## 🚀 Current Status & Features (Work in Progress)
This project is actively being developed. The core foundation has been established, and the current repository includes:

* **Movie Discovery:** Fetching and displaying categorized movie lists (e.g., Popular, Top Rated, Upcoming).
* **Project Architecture:** A clean and organized folder structure (Models, Views, Controllers, Networking) to ensure scalable and maintainable code.
* **Networking Foundation:** A custom `NetworkManager` is set up to handle API requests efficiently.
* **UI Components:** Custom programmatic UI elements, such as `CircularProgressView`, `SectionHeaderView`, and custom cells (`MovieCell`), are being integrated alongside Storyboards.
* **Data Models:** Core Swift models (`Movie.swift`) are implemented to parse and manage JSON responses from the TMDB API.

## 🛠 Tech Stack
* **Language:** Swift
* **UI:** UIKit (Storyboards & Programmatic UI combination)
* **Architecture:** MVC 
* **API:** TMDB API

## 🔜 Upcoming Features
As the development continues, the following features will be added:
* **User System:** A complete user authentication system (Login/Register).
* **Custom Watchlist:** A personalized space for users to save and track their favorite movies.
* **Movie Details:** Detailed movie screens including synopsis, ratings, and cast information.
* **Search:** Search functionality to find specific movies.

---
*Developed by Semih*