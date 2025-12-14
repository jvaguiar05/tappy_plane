# Godot Physics2D Nodes - Quick Reference

## Core Physics Body Nodes

### StaticBody2D
- **Purpose**: Physics body for 2D physics which is static or moves only by script
- **Best for**: Floors, walls, immovable platforms, static obstacles
- **Key Features**:
  - Does not respond to physics forces
  - Can be moved programmatically via script
  - Excellent performance (doesn't participate in physics simulation)
  - Perfect for level geometry

### CharacterBody2D
- **Purpose**: Specialized 2D physics body node for characters moved by script
- **Best for**: Player characters, NPCs with custom movement logic
- **Key Features**:
  - Built-in movement methods like `move_and_slide()`
  - Handles collision detection and response
  - Does not use physics simulation (script-controlled)
  - Optimized for character movement with features like floor detection

### AnimatableBody2D
- **Purpose**: Physics body for 2D physics which moves only by script or animation
- **Best for**: Moving platforms, doors, elevators, kinematic objects
- **Key Features**:
  - Can be animated using Godot's animation system
  - Moves other physics bodies when it collides with them
  - Doesn't respond to physics forces
  - Perfect for scripted or animated level elements

### RigidBody2D
- **Purpose**: Physics body moved by 2D physics simulation
- **Best for**: Objects affected by gravity, pushable/throwable items, projectiles
- **Key Features**:
  - Fully simulated physics (gravity, forces, impulses)
  - Can be pushed and affected by other physics bodies
  - Supports different body modes (rigid, static, kinematic, character)
  - Mass, friction, and bounce properties

## Collision Detection Nodes

### Area2D
- **Purpose**: Detects when objects enter/exit a region
- **Best for**: Triggers, collectibles, damage zones, detection areas
- **Key Features**:
  - Does not participate in physics simulation
  - Emits signals for body_entered, body_exited, area_entered, area_exited
  - Can detect specific groups or layers
  - No physical collision response

## Essential Components

### CollisionShape2D
- **Purpose**: Defines the collision boundaries for physics bodies
- **Required for**: All physics bodies to participate in collision detection
- **Shape Options**:
  - **RectangleShape2D**: Rectangular collision boxes
  - **CircleShape2D**: Circular collision areas
  - **CapsuleShape2D**: Pill-shaped collision (good for characters)
  - **ConvexPolygonShape2D**: Custom convex shapes
  - **ConcavePolygonShape2D**: Complex shapes (static bodies only)

### CollisionPolygon2D
- **Purpose**: Alternative to CollisionShape2D using polygon points
- **Best for**: Custom shapes defined by vertices
- **Note**: Can create both convex and concave shapes

## Quick Selection Guide

| Use Case          | Recommended Node |
| ----------------- | ---------------- |
| Player character  | CharacterBody2D  |
| Ground/walls      | StaticBody2D     |
| Moving platform   | AnimatableBody2D |
| Falling objects   | RigidBody2D      |
| Collectible items | Area2D           |
| Damage zones      | Area2D           |
| Doors/elevators   | AnimatableBody2D |
| Projectiles       | RigidBody2D      |

## Common Patterns

### Player Movement (CharacterBody2D)
```gdscript
extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

func _physics_process(delta):
    # Add gravity
    if not is_on_floor():
        velocity.y += get_gravity().y * delta
    
    # Handle jump
    if Input.is_action_just_pressed("ui_accept") and is_on_floor():
        velocity.y = JUMP_VELOCITY
    
    # Handle horizontal movement
    var direction = Input.get_axis("ui_left", "ui_right")
    if direction:
        velocity.x = direction * SPEED
    else:
        velocity.x = move_toward(velocity.x, 0, SPEED)
    
    move_and_slide()
```

### Collectible Item (Area2D)
```gdscript
extends Area2D

signal collected

func _ready():
    body_entered.connect(_on_body_entered)

func _on_body_entered(body):
    if body.is_in_group("player"):
        collected.emit()
        queue_free()
```

### Moving Platform (AnimatableBody2D)
```gdscript
extends AnimatableBody2D

@export var move_distance: Vector2 = Vector2(200, 0)
@export var move_speed: float = 100.0

func _ready():
    var tween = create_tween()
    tween.set_loops()
    tween.tween_property(self, "position", position + move_distance, move_distance.length() / move_speed)
    tween.tween_property(self, "position", position, move_distance.length() / move_speed)
```

## Performance Tips

1. **Use StaticBody2D** for non-moving level geometry
2. **Limit RigidBody2D** usage to objects that truly need physics simulation
3. **CharacterBody2D** is more efficient than RigidBody2D for player characters
4. **Area2D** is very lightweight for trigger zones
5. Consider using **collision layers and masks** to optimize collision detection

## Physics Layers Best Practices

- **Layer 1**: Players
- **Layer 2**: Enemies  
- **Layer 3**: World/Static geometry
- **Layer 4**: Projectiles
- **Layer 5**: Collectibles
- **Layer 6**: Triggers/Areas

Configure collision masks to only check necessary interactions between layers.

## Conclusion

> This quick reference guide summarizes the key Godot Physics2D nodes, their purposes, best use cases, and essential features to help you choose the right node for your game development needs.
