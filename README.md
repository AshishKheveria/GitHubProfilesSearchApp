# GitHubProfilesApp

GitHubProfilesApp is an iOS application that allows users to search for GitHub profiles and view details about the selected user including their name, company, blog, location, public repositories, public gists, followers, following, hireability, bio, and more.

The application has two main screens:

Search Screen: Allows users to search for GitHub users by entering a username.
User Details Screen: Displays details about the selected user.
The application uses the GitHub API to fetch the user's information.

## Installation
To install the application, follow these steps:

Clone the repository to your local machine.
Open the GitHubProfilesApp.xcodeproj file in Xcode.
Build and run the application on your preferred device or simulator.

## Usage
To use the application, follow these steps:

Launch the application.
On the Search Screen, enter a username to search for.
Tap the "Search" button.
On the User Details Screen, view the details about the selected user.
Tap the "Followers" button to view the user's followers.

## Project Structure
The project follows the Model-View-ViewModel (MVVM) design pattern, separating the business logic from the user interface.

The application has the following files and directories:

GitHubProfilesApp directory: Contains the main application files.
AppDelegate.swift: Initializes the application and sets up the initial view controller.
SceneDelegate.swift: Handles the window and scene management.
Main.storyboard: Contains the main user interface elements.
Extensions directory: Contains extensions to existing classes.
Models directory: Contains the models used by the application.
Networking directory: Contains the networking classes used to fetch data from the GitHub API.
View Controllers directory: Contains the view controllers used by the application.
SearchVC.swift: Contains the logic for the Search Screen.
UserDetailsVC.swift: Contains the logic for the User Details Screen.
Views directory: Contains the custom views used by the application.

## Dependencies
The application uses the following dependencies:

'FireCache': Used to cache the user's profile image.

## Credits
This application was developed by Ashish Kheveria.
