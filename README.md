# 🍳 Tabkhah - Flutter Cooking Application
A comprehensive Flutter application that helps users discover, save, and manage their favorite recipes. Built with modern Flutter architecture and Firebase integration, this app provides a seamless cooking experience with social features and personalized recommendations.

## 📱 Features

### Core Features
- **Recipe Discovery**: Browse popular recipes and get random recipe suggestions
- **Category Browsing**: Explore recipes by different food categories
- **Detailed Recipe View**: Access complete cooking instructions, ingredients, and nutritional information
- **External Resources**: Direct links to source websites and YouTube cooking videos
- **Refresh & Explore**: Get new random recipe suggestions with a simple refresh

### User Management & Personalization
- **User Authentication**: Secure login/logout system with Firebase Auth
- **User Profiles**: Personal profile management with user data storage
- **Theme Customization**: Light/dark theme toggle for better user experience
- **Password Management**: Change password functionality with visibility toggle

### Social & Interactive Features
- **Favorites System**: Save favorite recipes for quick access
- **Likes System**: Like recipes with real-time like counters
- **Global Like Counter**: Community-driven recipe popularity tracking
- **Fast UI Updates**: Optimized like/favorite operations with background sync

### Practical Tools
- **Smart Shopping List**: Auto-generated shopping lists from recipe ingredients
- **Shopping List Management**: Add, remove, and toggle items with intuitive UI
- **Ingredient Tracking**: Keep track of needed ingredients across multiple recipes

## 🛠️ Tech Stack

- **Framework**: Flutter
- **Backend**: Firebase (Firestore, Authentication)
- **API**: [TheMealDB API](https://www.themealdb.com/api.php) - Free recipe database
- **State Management**: Cubit, Provider

## 🏗️ Architecture

The app follows a structured approach with:
- **User Collection**: Stores user profiles and authentication data
- **Likes Subcollection**: Individual user likes for personalized experience
- **Global Likes Collection**: Community-wide like counters for recipes
- **Shopping Lists**: User-specific ingredient management
- **Real-time Sync**: Background operations for seamless user experience

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (version 3.32.7 or higher)
- Dart SDK
- Firebase project setup
- Android Studio / VS Code

### Installation

1. Clone the repository
```bash
git clone https://github.com/ZakariaAshraf/Tabkhah.git
cd tabkhah
```

2. Install dependencies
```bash
flutter pub get
```

3. Configure Firebase
   - Add your `google-services.json` (Android) and `GoogleService-Info.plist` (iOS)
   - Update Firebase configuration

4. Run the app
```bash
flutter run
```

## 🔧 Configuration

### API Setup
The app uses TheMealDB free API. No API key required for basic functionality.

### Firebase Setup
1. Create a Firebase project
2. Enable Authentication (Email/Password)
3. Setup Firestore database
4. Configure security rules

## 📋 Current Status

### ✅ Completed Features
- User authentication and profile management
- Recipe browsing and search functionality
- Favorites and likes system with subcollections
- Global like counters
- Shopping list generation and management
- Theme switching
- Password visibility toggle
- URL launcher with proper Android manifest
- Auth guards and logout functionality

### 🚧 In Development
- UI improvements for shopping list
- Performance optimizations

### 🔮 Future Enhancements
- **Ingredient Shop Integration**: Direct ingredient purchasing
- **Chef Booking System**: Connect with professional chefs
- **Recipe Sharing**: Share recipes with chefs and restaurants
- **Comments System**: Community recipe discussions
- **Monetization Features**: Premium chef consultations

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request. For major changes, please open an issue first to discuss what you would like to change.

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 📞 Contact

**Zakaria Ashraf** - za14948@gmail.com - https://www.linkedin.com/in/zakaria-ashraf/

Project Link: [https://github.com/yourusername/recipe-explorer](https://github.com/yourusername/recipe-explorer)

## 🙏 Acknowledgments

- [TheMealDB](https://www.themealdb.com/) for providing the free recipe API
- Flutter team for the amazing framework
- Firebase for backend services
- The Flutter community for continuous support and inspiration

---

*Built with ❤️ using Flutter*
