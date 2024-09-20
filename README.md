# Event Planner - Flutter Mobile App
[screeshots here](assets/images/appScreenshots.md) and main code [here](lib)

## Description

Event Planner is a mobile application built with Flutter and integrated with Firebase. It aims to assist users in efficiently organizing events by providing essential features like event creation, task management, budget tracking, and visual analytics.

With Event Planner, users can:
- **Create and manage events**: Add essential details, including title, date, and location.
- **Add and track tasks**: Associate tasks with specific events or create standalone tasks that aren't tied to any event.
- **Manage budget**: Set an event budget and track expenses in real-time, helping users stay within their financial limits.
- **Event Calendar**: View a calendar that highlights all events for a given month, and easily navigate to daily event lists.
- **Login and secure data**: Secure access through user authentication, ensuring only the logged-in user can view or manage their events.
- **Event Analytics**: Gain insights into event types with graphical analysis of the most planned events.
- **User profile**: View personal information such as name and email in a dedicated user profile page.

## Features

1. **User Authentication**: 
   - Secure login and registration system.
   - Each user can only view their own events and tasks.

2. **Event Creation and Management**: 
   - Create events with essential details like title, description, and date.
   - Edit and delete events easily.
   
3. **Task Management**:
   - Add tasks linked to specific events or create independent tasks not associated with any event.
   - Manage all tasks from a dedicated task management page.

4. **Budget Tracking**:
   - Define event budgets and track expenses.
   - Monitor remaining funds to ensure you stay within your budget.

5. **Calendar View**:
   - Display events in a monthly calendar.
   - Navigate through the calendar to view events by day and month.
   - View a list of events for a specific day and access detailed event information with just a tap.

6. **Data Analytics**:
   - Visual graphs displaying the most frequently organized event types.

7. **User Profile**:
   - View user information such as name and email in a profile page.

## Screenshots

Screenshots of the application can be found [here](assets/images/appScreenshots.md).

## Getting Started

### Prerequisites
- Install [Flutter](https://flutter.dev/docs/get-started/install).
- Set up [Firebase](https://firebase.google.com/) and link it with your project.

### Installation

1. **Setting up Flutter**:
    - Open Visual Studio Code and navigate to the command palette (Ctrl + Shift + P).
    - Create a new Flutter project by typing **Flutter: New Project**.
    - Choose **Application** as the project type.

2. **Setting up Firebase**:
    - Visit the Firebase console at [console.firebase.google.com](https://console.firebase.google.com).
    - Add a new project, enable Google Analytics (optional), and configure Firebase for web and mobile.

3. **Linking Firebase to the App**:
    - Copy the Firebase web script into the `<body>` tag of your `index.html` file in the `web` directory.
    - Add Firebase initialization in your `main.dart` file.

4. **Enable Firebase Services**:
    - Set up **Authentication** (email, Google, etc.) and **Firestore** in test mode for data access.
    
5. **Add Dependencies**:
    - In your `pubspec.yaml` file, add the following Firebase dependencies:
      ```yaml
      dependencies:
        firebase_auth: ^4.17.5
        cloud_firestore: ^4.15.5
        firebase_core: ^2.25.4
        firebase_storage: ^11.6.6
        flutter:
          sdk: flutter
      ```

6. **Gradle Configuration (for Android)**:
    - Run the following commands to configure Gradle:
      ```bash
      PS C:\~\event_planner> gradle init
      PS C:\~\event_planner> gradle wrapper
      PS C:\~\event_planner> .\gradlew.bat --version
      PS C:\~\event_planner> .\gradlew.bat build
      ```

> **Possible Gradle error**: If you encounter any Gradle errors, refer to [this StackOverflow solution](https://stackoverflow.com/questions/77820915/cant-use-java-21-0-1-and-gradle-8-1-1-to-import-gradle-project-android).

## Credits
Please check the [CREDITS](assets/credits) for a list of contributors.

---

Feel free to add more customization or extend the features based on your event-planning needs!
