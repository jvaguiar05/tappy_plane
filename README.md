# Tappy Plane 🛩️

A 2D endless runner game inspired by Flappy Bird, built with Godot 4 for educational purposes.

## 📚 Educational Purpose

This project was created as part of my game development studies, following the comprehensive roadmap from the Udemy course:
**[Jumpstart to 2D Game Development: Godot 4 for Beginners](https://www.udemy.com/course/jumpstart-to-2d-game-development-godot-4-for-beginners/)**

The main goal is to learn fundamental game development concepts and Godot 4 engine features through hands-on practice.

## 🎮 Game Overview

Tappy Plane is a simple yet engaging game where players control a plane that must navigate through pipes by tapping/pressing space to "fly" upward. The challenge is to pass through as many pipe gaps as possible without crashing.

### Core Gameplay

- **Tap/Space** to make the plane fly upward
- **Gravity** constantly pulls the plane down
- **Avoid** hitting pipes or the ground
- **Score points** by passing through pipe gaps
- **Beat your high score** and try again!

## 🛠️ Technical Features

### Game Architecture

- **Scene Management**: Clean separation between main menu and game scenes
- **Signal System**: Decoupled communication between game objects
- **Singleton Pattern**: Global managers for game state, scoring, and scene transitions
- **Component-Based Design**: Each game object has specific responsibilities

### Key Systems

#### 1. **Physics & Movement**

- Gravity-based plane physics
- Input-responsive flight mechanics
- Smooth collision detection

#### 2. **Obstacle Generation**

- Procedural pipe spawning
- Random gap positioning
- Automatic cleanup system

#### 3. **Scoring System**

- Real-time score tracking
- High score persistence
- Score validation and formatting

#### 4. **Audio Integration**

- Engine sound effects
- Scoring audio feedback
- Game over sound cues

#### 5. **UI Management**

- Responsive game interface
- Pause/unpause functionality
- Game state transitions

### Design Patterns Implemented

- **Observer Pattern** (SignalHub): Event-driven communication
- **Singleton Pattern** (GameManager, ScoreManager): Global state management
- **Component Pattern**: Modular, maintainable code structure

## 📁 Project Structure

```
tappy_plane/
├── assets/              # Game assets (sprites, audio, fonts)
├── globals/             # Singleton managers and signal hub
├── scenes/              # Game scenes and components
│   ├── main/           # Main menu scene
│   ├── game/           # Core gameplay scene
│   ├── tappy_plane/    # Player character
│   ├── pipes/          # Obstacle system
│   ├── game_ui/        # User interface
│   └── ...             # Other components
├── notes/              # Documentation and learning notes
└── resources/          # Godot resource files
```

## 🎯 Learning Outcomes

Through this project, I gained hands-on experience with:

- **Godot 4 Engine**: Scene system, nodes, and scripting
- **Game Physics**: Gravity, collision detection, and movement
- **Software Architecture**: Clean code principles and design patterns
- **State Management**: Game states and scene transitions
- **Audio Programming**: Sound integration and management
- **UI Development**: Responsive game interfaces
- **Resource Management**: Asset organization and optimization

## 🎨 Assets & Attribution

All assets used in this project are **100% free to use** and include:

- Sprite graphics for planes, pipes, and backgrounds
- Sound effects for gameplay interactions
- Custom fonts for UI elements

_Note: This is an educational project created for learning purposes._

## 🚀 How to Run

1. **Install Godot 4.5+**
2. **Clone this repository**
3. **Open the project in Godot**
4. **Press F5 to run the game**

## 🎓 Key Takeaways

This project demonstrates:

- Clean, maintainable code architecture
- Proper separation of concerns
- Event-driven programming
- Resource management best practices
- Game development workflow in Godot

## 📖 Additional Learning Resources

- [Godot Documentation](https://docs.godotengine.org/)
- [GDScript Style Guide](https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/gdscript_styleguide.html)
- [Game Programming Patterns](https://gameprogrammingpatterns.com/)

---

_This project serves as a foundation for understanding game development concepts and can be extended with additional features like power-ups, different difficulty levels, or multiplayer functionality._

---

## 🧑🏼‍🦱 About Me

Hi! I'm João Vítor, I'm just starting to learn about game developing. I'm passionate about creating engaging experiences and learning new technologies. This project is part of my journey to master 2D game development using Godot Engine. Feel free to reach out or check out my other projects!
