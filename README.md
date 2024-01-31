# FinnAdBrowser

## Overview
FinnAdBrowser is an iOS application developed as part of a technical interview process. The app showcases various advertisements fetched from a remote service. It features a user-friendly interface for browsing and favoriting ads, providing an engaging user experience.

## Features
- **Ad Types Grid View**: Displays different types of ads in a horizontal grid layout.
- **Ad Listings**: Users can view detailed lists of ads under each ad type.
- **Favorites Management**: Users can favorite ads for easy access. The app retains these preferences across sessions.
- **Dynamic Layouts**: Depending on the ad type, ads are displayed in either grid or list format for optimal viewing.
- **Launch Screen**: Features an animated launch icon for an engaging app startup experience.
- **Ad Filtering**: Users can filter ads based on categories.
- **Clean Architecture**: The app is built using SwiftUI and follows best coding practices for maintainability and scalability.

## Technical Details
- **SwiftUI**: The app is built entirely with SwiftUI, showcasing modern iOS development practices.
- **Modular Design**: Components are designed to be reusable and easily maintainable.
- **ViewModel**: `AdsViewModel` handles data fetching, state management, and business logic.
- **Network Layer**: Custom network service for fetching data from a remote JSON endpoint.
- **Favorites Persistence**: Uses local storage to persist user's favorite ads.
- **Custom UI Components**: Includes custom views like `AdCardView` for displaying ad details.

## Installation
To run the FinnAdBrowser app:
1. Clone the repository: `git clone https://github.com/yourusername/FinnAdBrowser.git`
2. Open the project in Xcode.
3. Build and run the application on a simulator or physical device.

## Future Enhancements
- Implement more advanced filtering options.
- Integrate more dynamic data sources.
- Enhance UI/UX with animations and transitions.
- **Data Storage Upgrade**: Currently, the app uses UserDefaults for storing favorites locally. For handling larger datasets and more complex data structures, migrating to CoreData or SwiftData could enhance performance and scalability. These frameworks offer more robust data management solutions, ideal for applications with evolving data storage needs.


## License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgements
- Special thanks to the interview panel for the opportunity to demonstrate my skills.
- Icons and images used under license from respective sources.

