# 8 Club Assignment

A Flutter-based onboarding application with interactive experience selection and multimedia question-answering capabilities.

## 🚀 Features

### 1. Experience Selection Screen
- **Clean UI Design**: Modern interface with proper spacing and styling
- **Interactive Experience Cards**: 
  - Background images from `image_url`
  - Grayscale filter for unselected cards
  - Multi-selection capability
- **State Management**: Stores selected experience IDs and text
- **Smooth Navigation**: Automatic redirection to next screen

### 2. Onboarding Question Screen
- **Multi-line Text Input**: 
  - Character limit of 600
  - Dynamic layout adjustments
- **Multimedia Recording**:
  - **Audio Recording**: 
    - Real-time waveform visualization
    - Cancel recording option
    - Delete recorded audio
    - Audio playback support
  - **Video Recording**:
    - Cancel recording option
    - Delete recorded video
    - Video playback support
- **Dynamic UI**: 
  - Recording buttons disappear after media capture
  - Responsive layout handling
  - Keyboard-aware animations

## 🛠 Technical Implementation

### Architecture & State Management
- **BLoC/Cubit**: For efficient state management
- **Dio**: HTTP client for API communications
- **GetIt**: Dependency injection for singleton management

### UI/UX Excellence
- **Pixel-Perfect Design**: Faithful implementation of Figma specifications
- **Responsive Design**: Adapts to various screen sizes and orientations
- **Keyboard Handling**: Smooth animations when keyboard opens/closes

### Animations
- **Next Button Animation**: Dynamic width changes when recording buttons disappear
- **Screen Transitions**: Smooth PageView-based navigation

## 📱 Screens

### Screen 1: Experience Selection
- Grid of experience cards with image backgrounds
- Multi-select functionality with visual feedback
- State persistence for selected items

### Screen 2: Question & Answer
- Text input with character counter
- Audio recording with waveform visualization
- Video recording capabilities
- Dynamic button visibility based on recording state

## 🎯 Brownie Points Achieved

### UI/UX
- ✅ Pixel-perfect implementation from Figma
- ✅ Responsive design handling viewport changes
- ✅ Keyboard-aware layout animations

### State Management
- ✅ BLoC/Cubit implementation
- ✅ Dio for API management
- ✅ GetIt for dependency injection

### Animations
- ✅ Next button width animations
- ✅ Smooth screen transitions
