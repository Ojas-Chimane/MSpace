# MSpace

MSpace is an innovative platform that helps students and faculty find available seating around a university campus in real time. The platform uses **Raspberry Pi** devices with sensors, **Firebase** for real-time data management, and an **iOS application** for seamless user interaction. This project aims to reduce the time and effort spent searching for vacant seats, making campus spaces more accessible and efficient to use.

### Raspberry Pi Wiring Diagram
Add a wiring diagram to illustrate how the Raspberry Pi is connected to various sensors and components. This helps clarify the hardware setup for other developers or users.

![Image 4-10-19 at 6 31 pm](https://github.com/user-attachments/assets/b7aa41cb-a793-4f46-bcee-a7ea6f0b5971)

### Sensor Setup View
Include images of the Raspberry Pi and sensor setup at a seating area to give a visual idea of the hardware configuration.  
| External  | Internal |
|-----------------------------|-------------------------|
| ![tempImageRMr4fX](https://github.com/user-attachments/assets/ddd86f05-e052-4c06-a0aa-eb107548a3bb) | ![tempImagePENNIm](https://github.com/user-attachments/assets/0763bf8e-25e8-4fa8-a72d-f1d1d4f8d106) |

## Table of Contents

- [Overview](#overview)
- [Components](#components)
  - [Raspberry Pi Setup](#raspberry-pi-setup)
  - [Firebase Integration](#firebase-integration)
  - [iOS Application](#ios-application)
- [System Architecture](#system-architecture)
- [Installation](#installation)
- [Features](#features)
- [Contributing](#contributing)
- [License](#license)

---

## Overview

MSpace utilizes a network of IoT-enabled Raspberry Pi devices to detect seat availability across campus seating areas. The availability data is sent to Firebase in real-time, where it is synced and made accessible to all connected devices. Through the MSpace iOS app, users can check the availability of seating areas across campus, view seating layouts, and even receive notifications for specific areas they’re interested in.

## Components

### 1. Raspberry Pi Setup

The **Raspberry Pi** devices are the backbone of the MSpace platform, responsible for detecting and reporting seat occupancy. Each Raspberry Pi is equipped with occupancy sensors and positioned in various seating areas across campus.

- **Sensors**: Proximity sensor was used to monitor seat occupancy. This sensor detect the presence of a person by sensing physical occupancy (proximity).
- **Data Transmission**: The Raspberry Pi devices periodically send occupancy data to Firebase via a network connection.
- **Setup**:
  - Configure the sensors to detect occupancy status.
  - Program each Raspberry Pi to transmit data to Firebase using a simple Python script or Node.js.

### 2. Firebase Integration

**Firebase** is the real-time backend used in MSpace, handling data storage and synchronization.

- **Real-time Database**: Firebase’s real-time database stores and updates seat availability status across the platform. Every seat’s status is tracked and updated instantaneously.
- **Data Syncing**: Firebase enables seamless syncing of data between the Raspberry Pi devices and the iOS application. This ensures that users always see up-to-date seating information.
- **Authentication (Optional)**: Firebase authentication could be implemented to restrict access to only authorized users (e.g., university students and staff).

### 3. iOS Application

The **MSpace iOS app** serves as the main interface for users to check seat availability.

- **Real-time Updates**: The app fetches seat availability data from Firebase in real-time and displays it to the users.
- **Map View**: Users can view a map of campus with markers for each seating area. Each marker indicates the number of vacant and occupied seats.
- **Notifications**: Users can set notifications for specific seating areas, receiving alerts when a seat becomes available.
- **User Interface**: A user-friendly interface allows quick access to seating availability, making the app intuitive and efficient.

## System Architecture

The following diagram shows a high-level view of the MSpace system architecture:

1. **Sensors**: Each seating area has sensors connected to a Raspberry Pi to monitor seat occupancy.
2. **Raspberry Pi**: The Pi collects data from the sensors and sends it to Firebase.
3. **Firebase**: Acts as the real-time database, storing seat availability data and syncing it across all connected devices.
4. **iOS App**: The iOS application fetches and displays the data to the user, allowing real-time seat tracking and notifications.

## Installation

### 1. Raspberry Pi Setup

1. Install necessary libraries and dependencies on Raspberry Pi:
   ```bash
   sudo apt-get update
   sudo apt-get install python3-pip
   pip3 install firebase-admin
2. Configure sensors and write a Python script to detect seat occupancy and send data to Firebase.
3. Schedule the script to run on Raspberry Pi startup.

## Firebase Setup
1. Create a Firebase project and configure a real-time database.
2. Set up rules to allow read and write access as needed.
   Note the database URL and Firebase credentials, which will be needed in both Raspberry Pi and iOS configurations.
3. iOS Application Setup
- Install Firebase SDK in your iOS project.
- Configure Firebase credentials within the app.
- Design a UI for displaying seating areas and availability information.
- Use Firebase listeners to keep data in sync in real-time.
  
## Features

- **Real-Time Seat Availability**: Users can view the current status of seating areas across campus in real-time.
- **Efficient Usage of Campus Resources**: By making seating availability data readily accessible, MSpace helps students find seats quickly and enhances campus resource utilization.

## Contributing

Contributions are welcome! Please submit issues and pull requests for any improvements, bug fixes, or additional features you would like to see. Be sure to follow the repository’s code style and guidelines.

## License

This project is licensed under the MIT License. 
