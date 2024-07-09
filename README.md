# EVENT_PLANNER
<h4>This is a flutter project with a firebase database</h4>

### Check the [CREDITS](assets/credits)


## GETTING STARTED
### In VS Code:

- Open the command palette (Ctrl + Shift + P).
- Create a new Flutter project by typing Flutter: New Project.
- Choose Application as the project type.


### On Google:

- Visit Firebase at firebase.google.com.
- Sign in to your account.
- Go to the Firebase console at console.firebase.google.com.
- Add a new project by selecting Add Project.
- Enter the name of your project.
- Enable Google Analytics for the project and continue.

### Linking the App with Firebase:

- In the Firebase console, go to the web development icon.
- Enter the name of your project.
- Use the script tag provided by Firebase.
- Copy the script text.
- Paste the script inside the <body> tag of the index.html file in the web directory of your project. (you should put it in the main.dart too)

### Enabling Data Access:

In the Firebase console:
- Add authentication methods (email, social networks).
- Add Cloud Firestore in test mode for now.

In VS Code:

- Navigate to the pubspec.yaml file.
- Add the Firebase dependencies:
- 
        dependencies:
        firebase_auth: ^4.17.5
        cloud_firestore: ^4.15.5
        firebase_core: ^2.25.4
        firebase_storage: ^11.6.6
        flutter:
            sdk: flutter


> **possible gradle error:** if you get a gradle error trying to work with android, check out this [solution on stackoverflow](https://stackoverflow.com/questions/77820915/cant-use-java-21-0-1-and-gradle-8-1-1-to-import-gradle-project-android) (I'm using java 21 and gradle 8.5)




PS C:\~\event_planner> gradle init                                                                                           
Select all defaults
                 
BUILD SUCCESSFUL in 1m 24s

PS C:\~\event_planner> gradle wrapper                                    
BUILD SUCCESSFUL in 6s

PS C:\~\event_planner> .\gradlew.bat --version                                               

>Gradle 8.5

>Kotlin:       1.9.20

>Groovy:       3.0.17

>Ant:          Apache Ant(TM) version 1.10.13 compiled on January 4 2023
JVM:          21.0.2 (Oracle Corporation 21.0.2+13-LTS-58)
OS:           Windows 11 10.0 amd64

PS C:\~\event_planner> .\gradlew.bat build

Root project 'event_planner'

BUILD SUCCESSFUL in 790ms




to use the where when fetching the events from a specific user, i had to create indexes on the firestora database on forebase, i created one for the collection events, fields: userId and title.


