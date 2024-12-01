# DayView

DayView is a calendar and event management application designed to help users organize their schedules efficiently. The app allows users to view and manage events, assign personnel, track weather information, and navigate through months in an intuitive and streamlined interface.

---

## Features

### 1. **User Authentication**
- Log in and log out functionality for users using Firebase Authentication.
- Secure user authentication to manage personalized events and data.

### 2. **Calendar View**
- Displays a monthly calendar grid with highlighted dates that have scheduled events.
- Users can navigate between months using intuitive buttons.
- A minimalist design with event indicators (dots) for easier navigation.

### 3. **Event Management**
- View events for any selected day.
- Add, edit, and delete events with details like:
  - Event name.
  - Description.
  - Start and end time.
  - Assigned personnel.
- All event data is dynamically fetched from Firebase Firestore.

### 4. **Personnel Management**
- Add personnel to assign them to events.
- Each personnel is associated with a unique color, making events easy to identify visually.

### 5. **Weather Information**
- Integrated with the WeatherStack API to display weather details for any entered location.
- Information includes temperature, weather description, humidity, and wind speed.

### 6. **Intuitive Bottom Navigation**
- A simplified navigation bar at the bottom of the app for:
  - Adding personnel.
  - Viewing weather information.
  - Logging out.

---

## Technologies Used

- **SwiftUI**: For building a clean and responsive user interface.
- **Firebase**:
  - **Authentication**: Handles secure user login and logout.
  - **Firestore**: Stores and retrieves event and personnel data.
- **WeatherStack API**: Provides weather information based on user-entered locations.
- **MVVM Architecture**: Ensures a clean separation of logic, views, and models for maintainability.

---

## Installation

### Prerequisites
- macOS with Xcode installed.
- A Firebase project set up for authentication and Firestore.
- A WeatherStack API key.

### Steps

1. **Clone the repository**:
    - Open a terminal and run:
      ```bash
      git clone https://github.com/Pvines2/DayView.git
      cd DayView
      ```

2. **Open the project in Xcode**:
    - Run:
      ```bash
      open DayView.xcodeproj
      ```

3. **Install Firebase dependencies**:
    - Open the `Podfile` (if applicable) and ensure Firebase is set up.
    - Run:
      ```bash
      pod install
      ```

4. **Add your Firebase configuration**:
    - Replace `GoogleService-Info.plist` with your Firebase project’s configuration file.

5. **Add your WeatherStack API key**:
    - Replace the placeholder `YOUR_API_KEY` in the `WeatherViewModel` file with your actual API key.

6. **Build and run the project**:
    - Select a simulator or device and press **Cmd + R** to run the app.


---

## Usage

### **Log In**
- Use your email and password to log in or sign up for an account.

### **View Calendar**
- Navigate through months and view days with scheduled events.
- Tap on a day to view all events for that date.

### **Manage Events**
- Add, edit, or delete events with detailed information.

### **View Weather**
- Access the weather information for any entered location.

### **Log Out**
- Use the log-out button to exit your session securely.

---

## Project Structure

### **Folders**
- **Models**: Contains data structures for events and personnel.
- **ViewModels**: Includes logic for interacting with Firebase and APIs.
- **Views**: All SwiftUI views, such as the calendar, event management, and weather pages.

### **Key Files**
- `ContentView.swift`: The entry point that handles user authentication and navigation.
- `CalendarView.swift`: Displays the monthly calendar and allows navigation through months.
- `DayDetailView.swift`: Shows the list of events for a selected day.
- `EditEventView.swift`: Allows users to edit an event.
- `WeatherView.swift`: Displays weather information fetched from WeatherStack.

---

## Known Issues

- **Back Button Duplication**: Navigating deeper into the view hierarchy may show duplicate back buttons. This is a minor UI issue and does not affect functionality.
- **Weather Location Accuracy**: The weather location must be entered manually. Future versions may integrate geolocation services.

---

## Future Enhancements
- **Recurring Events**: Support for scheduling events on a recurring basis.
- **Geolocation Integration**: Automatically detect user location for weather data.
- **UI Improvesments**: Various UI changes to create a cleaner look.
- **Week at a glance**: Shows a weekly view beneath the Calendar view.

---

## Contributors

- **Parker Vines** - Developer and designer of DayView.

---

## License

This project is licensed under the MIT License. See the `LICENSE` file for more details.
