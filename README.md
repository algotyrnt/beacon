# Beacon

A Swift Playgrounds emergency preparedness app that uses multipeer mesh networking to help people stay connected and safe during disasters.

## Overview

Beacon is a Swift Playgrounds app designed for emergency situations where traditional communication infrastructure may be unavailable. Built with SwiftUI, it uses peer-to-peer mesh networking to allow nearby devices to communicate directly, share locations, and access critical disaster preparedness information.

This app demonstrates practical use of Apple's MultipeerConnectivity framework and can be easily opened and modified in Swift Playgrounds or Xcode.

## Features

- **Mesh Networking**: Connect directly with nearby devices using MultipeerConnectivity framework
- **Real-time Location Sharing**: See the locations of connected peers on a map
- **Emergency Status**: Send help signals to nearby users
- **Resource Library**: Access emergency preparedness guides for various disasters:
  - Cyclone preparedness
  - Water purification techniques
  - First aid procedures
  - And more...
- **Interactive Map**: View yourself and connected peers on an interactive map interface

## Requirements

- **Swift Playgrounds 4.0+** (iPad/Mac) or **Xcode 14.0+**
- **iPadOS 15.0+** / **iOS 15.0+** / **macOS 12.0+**
- Swift 5.7+
- Device with Bluetooth and Wi-Fi capabilities
- Physical devices recommended for testing mesh networking (simulator has limited MultipeerConnectivity support)

## Installation

### Option 1: Download Latest Release (Easiest)

Download the latest pre-built version from the [Releases page](https://github.com/algotyrnt/beacon/releases):

1. Go to [Releases](https://github.com/algotyrnt/beacon/releases) and download the latest `Beacon-App.zip`
2. Extract the zip file
3. Open the `Beacon.swiftpm` folder in Swift Playgrounds or Xcode
4. Run the app on your device

### Option 2: Swift Playgrounds (Recommended for iPad/Mac)

1. Clone the repository:

   ```bash
   git clone https://github.com/algotyrnt/beacon.git
   ```

2. Open the `Beacon.swiftpm` folder in Swift Playgrounds app

3. Tap the Run button to build and launch the app

### Option 3: Xcode

1. Clone the repository:

   ```bash
   git clone https://github.com/algotyrnt/beacon.git
   cd beacon
   ```

2. Open the project in Xcode:

   ```bash
   open Beacon.swiftpm
   ```

3. Build and run the project on your device

**Note:** Mesh networking requires physical devices with Bluetooth/Wi-Fi. Simulator support is limited.

## Usage

### Getting Started

1. Launch the app on multiple devices
2. Grant location and networking permissions when prompted
3. The app will automatically discover and connect to nearby Beacon users
4. Your location will be shared with connected peers

### Sending an Emergency Signal

1. Navigate to the Beacon tab
2. Tap the emergency button to broadcast a help signal
3. Connected peers will see your status change to "HELP" on their map

### Accessing Resources

1. Navigate to the Resources tab
2. Browse through various emergency preparedness guides
3. Tap on any resource for detailed information

## Project Structure

```
Beacon.swiftpm/
├── BeaconApp.swift           # App entry point
├── Components/               # Reusable UI components
│   ├── ResourceCard.swift
│   └── StatusCard.swift
├── Data/                     # Static data and resources
│   └── ResourcesData.swift
├── Managers/                 # Core functionality managers
│   ├── BeaconEngine.swift    # Mesh networking engine
│   └── LocationManager.swift # Location services
├── Models/                   # Data models
│   ├── BeaconPacket.swift
│   └── Resource.swift
├── ViewModels/              # View models
│   └── BeaconViewModel.swift
└── Views/                   # UI views
    ├── BeaconView.swift
    ├── HomeView.swift
    ├── MainTabView.swift
    ├── ResourceDetailView.swift
    └── ResourcesView.swift
```

## How It Works

Beacon uses Apple's MultipeerConnectivity framework to create a peer-to-peer mesh network. Each device:

- Advertises its presence to nearby devices
- Browses for other Beacon users
- Establishes encrypted connections
- Exchanges beacon packets containing location and status information

This allows users to maintain communication even when cellular networks and internet are unavailable.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request. For major changes, please open an issue first to discuss what you would like to change.

1. Fork the project
2. Create your feature branch (`git checkout -b feature/<your-feature-name>`)
3. Commit your changes (`git commit -m 'Add some Feature'`)
4. Push to the branch (`git push origin feature/<your-feature-name>`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Author

**Punjitha Bandara**

## Acknowledgments

- Emergency preparedness information sourced from:
  - Federal Emergency Management Agency (FEMA)
  - Centers for Disease Control and Prevention (CDC)
  - National Weather Service (NOAA)
  - Environmental Protection Agency (EPA)

## Disclaimer

This app is intended as a supplementary tool for emergency preparedness. Always follow official guidance from local authorities and emergency services during actual emergencies.
