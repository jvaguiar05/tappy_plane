# Design Patterns in Tappy Plane

This document explains the key design patterns implemented in the `globals` directory and how they contribute to a clean, maintainable game architecture.

## 1. Observer Pattern (SignalHub)

**Location**: `globals/signal_hub.gd`

**Purpose**: Provides decoupled communication between game objects without direct references.

### How it Works

```gdscript
# SignalHub acts as a central event broadcaster
extends Node

signal on_plane_died
signal on_point_scored

func emit_on_plane_died() -> void:
    on_plane_died.emit()

func emit_on_point_scored() -> void:
    on_point_scored.emit()
```

### Benefits

- **Loose Coupling**: Components don't need direct references to each other
- **Scalability**: Easy to add new listeners without modifying existing code
- **Single Responsibility**: Each component focuses on its own logic

### Usage Example

```gdscript
# Publisher (TappyPlane)
func die() -> void:
    SignalHub.emit_on_plane_died()  # Broadcasts event

# Subscriber (GameUI)
func _ready() -> void:
    SignalHub.on_plane_died.connect(on_plane_died)  # Listens for event
```

## 2. Singleton Pattern (GameManager)

**Location**: `globals/game_manager.gd`

**Purpose**: Provides a single, globally accessible instance for managing game state and scene transitions.

### How it Works

```gdscript
# Godot AutoLoad creates a singleton automatically
extends Node

func load_main_scene() -> void:
    get_tree().change_scene_to_file("res://scenes/main/main.tscn")

func load_game_scene() -> void:
    get_tree().change_scene_to_file("res://scenes/game/game.tscn")
```

### Benefits

- **Global Access**: Available from anywhere in the game
- **Centralized Control**: Single point for scene management
- **State Persistence**: Can maintain data across scenes

### Usage Example

```gdscript
# From any script
func go_to_main_menu():
    GameManager.load_main_scene()
```

## 3. Singleton Pattern (ScoreManager)

**Location**: `globals/score_manager.gd`

**Purpose**: Manages persistent score data with validation logic.

### How it Works

```gdscript
extends Node

var high_score := 0:
    get: return high_score
    set(value):
        if value > high_score:
            high_score = value  # Only updates if new score is higher
```

### Benefits

- **Data Encapsulation**: Protects score data with validation
- **Automatic Logic**: High score updates only when beaten
- **Global Access**: Available throughout the game

### Usage Example

```gdscript
# Setting a new score (only updates if higher)
ScoreManager.high_score = current_points

# Reading the high score
high_score_label.text = "%03d" % ScoreManager.high_score
```

## 4. Component Pattern (Separation of Concerns)

**Implementation**: Throughout the project, each component has a single responsibility.

### Examples

- **Laser**: Handles scoring detection and sound
- **Pipes**: Handles collision detection and cleanup
- **GameUI**: Handles UI display and user input
- **TappyPlane**: Handles player movement and physics

### Benefits

- **Maintainability**: Easy to modify one feature without affecting others
- **Testability**: Each component can be tested independently
- **Reusability**: Components can be reused in different contexts

## Best Practices Demonstrated

### 1. Clear Naming Conventions

```gdscript
# Signal names clearly indicate their purpose
signal on_plane_died
signal on_point_scored

# Method names describe actions
func emit_on_plane_died()
func load_main_scene()
```

### 2. Consistent Architecture

- All global systems follow the same singleton pattern
- All events go through SignalHub
- All scene changes go through GameManager

### 3. Validation and Safety

```gdscript
# Score validation prevents invalid high scores
set(value):
    if value > high_score:
        high_score = value
```

### 4. Process Mode Management

```gdscript
# Components that need to work during pause
process_mode = Node.PROCESS_MODE_ALWAYS
```

## Pattern Benefits Summary

| Pattern                  | Primary Benefit | Use Case            |
| ------------------------ | --------------- | ------------------- |
| Observer (SignalHub)     | Decoupling      | Event communication |
| Singleton (GameManager)  | Global Access   | Scene transitions   |
| Singleton (ScoreManager) | Data Management | Persistent scores   |
| Component                | Maintainability | Feature separation  |

## Conclusion

These patterns work together to create a robust, maintainable game architecture:

- **SignalHub** enables clean communication
- **GameManager** provides reliable scene control
- **ScoreManager** ensures data integrity
- **Component separation** keeps code organized

This architecture makes it easy to add new features, fix bugs, and maintain the codebase as the project grows.
