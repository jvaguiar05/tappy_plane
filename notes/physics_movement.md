# Physics2D Movement in Godot - Complete Guide

## Movement by Physics Body Type

### CharacterBody2D Movement

**Best for**: Player characters, NPCs with precise control

#### Basic Platform Movement

```gdscript
extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

func _physics_process(delta):
	# Apply gravity
	if not is_on_floor():
		velocity.y += get_gravity().y * delta

	# Handle jumping
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

#### Enhanced Movement with Acceleration

```gdscript
extends CharacterBody2D

@export var max_speed = 300.0
@export var acceleration = 1500.0
@export var friction = 1200.0
@export var jump_velocity = -400.0

func _physics_process(delta):
	# Apply gravity
	if not is_on_floor():
		velocity.y += get_gravity().y * delta

	# Handle jumping
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity

	# Handle horizontal movement with acceleration
	var input_direction = Input.get_axis("move_left", "move_right")

	if input_direction != 0:
		# Accelerate
		velocity.x = move_toward(velocity.x, input_direction * max_speed, acceleration * delta)
	else:
		# Apply friction
		velocity.x = move_toward(velocity.x, 0, friction * delta)

	move_and_slide()
```

#### Air Control and Coyote Time

```gdscript
extends CharacterBody2D

@export var speed = 300.0
@export var jump_velocity = -400.0
@export var air_control = 0.7
@export var coyote_time = 0.1

var coyote_timer = 0.0
var was_on_floor = false

func _physics_process(delta):
	var on_floor = is_on_floor()

	# Coyote time logic
	if was_on_floor and not on_floor:
		coyote_timer = coyote_time
	elif on_floor:
		coyote_timer = 0.0
	else:
		coyote_timer -= delta

	# Apply gravity
	if not on_floor:
		velocity.y += get_gravity().y * delta

	# Handle jumping (with coyote time)
	if Input.is_action_just_pressed("jump") and (on_floor or coyote_timer > 0):
		velocity.y = jump_velocity
		coyote_timer = 0.0

	# Handle horizontal movement with air control
	var direction = Input.get_axis("move_left", "move_right")
	var control_factor = air_control if not on_floor else 1.0

	if direction:
		velocity.x = direction * speed * control_factor
	else:
		velocity.x = move_toward(velocity.x, 0, speed * control_factor)

	move_and_slide()
	was_on_floor = on_floor
```

### RigidBody2D Movement

**Best for**: Physics-based objects, vehicles, projectiles

#### Force-Based Movement

```gdscript
extends RigidBody2D

@export var force_strength = 1000.0
@export var jump_force = 5000.0

func _physics_process(delta):
	var input_vector = Vector2.ZERO

	if Input.is_action_pressed("move_right"):
		input_vector.x += 1
	if Input.is_action_pressed("move_left"):
		input_vector.x -= 1

	# Apply horizontal force
	apply_central_force(input_vector * force_strength)

	# Jump (check if touching ground)
	if Input.is_action_just_pressed("jump") and is_touching_ground():
		apply_central_impulse(Vector2.UP * jump_force)

func is_touching_ground() -> bool:
	# Simple ground detection using raycast
	var space_state = get_world_2d().direct_space_state
	var query = PhysicsRayQueryParameters2D.create(
		global_position,
		global_position + Vector2.DOWN * 50
	)
	var result = space_state.intersect_ray(query)
	return result != null
```

#### Velocity-Based RigidBody Movement

```gdscript
extends RigidBody2D

@export var max_speed = 300.0
@export var acceleration = 20.0

func _physics_process(delta):
	var input_direction = Input.get_axis("move_left", "move_right")

	if input_direction != 0:
		# Gradually increase velocity
		var target_velocity = input_direction * max_speed
		linear_velocity.x = lerp(linear_velocity.x, target_velocity, acceleration * delta)
	else:
		# Apply friction
		linear_velocity.x = lerp(linear_velocity.x, 0.0, acceleration * delta)
```

### AnimatableBody2D Movement

**Best for**: Moving platforms, doors, elevators

#### Tween-Based Movement

```gdscript
extends AnimatableBody2D

@export var move_distance = Vector2(200, 0)
@export var move_duration = 2.0
@export var auto_start = true

var tween: Tween
var start_position: Vector2

func _ready():
	start_position = global_position
	if auto_start:
		start_moving()

func start_moving():
	tween = create_tween()
	tween.set_loops()

	# Move to end position
	tween.tween_property(self, "global_position", start_position + move_distance, move_duration)
	# Move back to start
	tween.tween_property(self, "global_position", start_position, move_duration)
```

#### Path-Based Movement

```gdscript
extends AnimatableBody2D

@export var path_points: Array[Vector2] = []
@export var movement_speed = 100.0
@export var loop_path = true

var current_target = 0
var tween: Tween

func _ready():
	if path_points.size() > 1:
		move_to_next_point()

func move_to_next_point():
	if path_points.is_empty():
		return

	var target_pos = path_points[current_target]
	var distance = global_position.distance_to(target_pos)
	var duration = distance / movement_speed

	tween = create_tween()
	tween.tween_property(self, "global_position", target_pos, duration)
	tween.tween_callback(on_reached_point)

func on_reached_point():
	current_target += 1

	if current_target >= path_points.size():
		if loop_path:
			current_target = 0
		else:
			return

	move_to_next_point()
```

## Advanced Movement Techniques

### Wall Jumping

```gdscript
extends CharacterBody2D

@export var wall_jump_force = Vector2(300, -400)
@export var wall_slide_speed = 100.0

func _physics_process(delta):
	# Standard gravity and input handling...
	if not is_on_floor():
		velocity.y += get_gravity().y * delta

	var direction = Input.get_axis("move_left", "move_right")

	# Wall sliding
	if is_on_wall_only() and velocity.y > 0:
		velocity.y = min(velocity.y, wall_slide_speed)

	# Wall jumping
	if Input.is_action_just_pressed("jump") and is_on_wall_only():
		var wall_normal = get_wall_normal()
		velocity.x = wall_normal.x * wall_jump_force.x
		velocity.y = wall_jump_force.y
	elif Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = -400.0

	# Regular movement (when not wall jumping)
	elif not is_on_wall_only():
		velocity.x = direction * 300.0

	move_and_slide()
```

### Dash Movement

```gdscript
extends CharacterBody2D

@export var dash_speed = 800.0
@export var dash_duration = 0.2
@export var dash_cooldown = 1.0

var is_dashing = false
var dash_timer = 0.0
var cooldown_timer = 0.0

func _physics_process(delta):
	# Update timers
	if is_dashing:
		dash_timer -= delta
		if dash_timer <= 0:
			is_dashing = false

	if cooldown_timer > 0:
		cooldown_timer -= delta

	# Handle dash input
	if Input.is_action_just_pressed("dash") and cooldown_timer <= 0 and not is_dashing:
		start_dash()

	if is_dashing:
		# During dash, maintain dash velocity
		pass
	else:
		# Normal movement when not dashing
		if not is_on_floor():
			velocity.y += get_gravity().y * delta

		var direction = Input.get_axis("move_left", "move_right")
		velocity.x = direction * 300.0

	move_and_slide()

func start_dash():
	var dash_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if dash_direction == Vector2.ZERO:
		dash_direction = Vector2.RIGHT if not $Sprite2D.flip_h else Vector2.LEFT

	velocity = dash_direction.normalized() * dash_speed
	is_dashing = true
	dash_timer = dash_duration
	cooldown_timer = dash_cooldown
```

### Smooth Camera Following

```gdscript
# Attach to Camera2D
extends Camera2D

@export var follow_speed = 5.0
@export var look_ahead_distance = 100.0

var target: CharacterBody2D

func _ready():
	target = get_node("../Player") # Adjust path as needed

func _process(delta):
	if target:
		var target_pos = target.global_position

		# Add look ahead based on movement direction
		if target.velocity.x != 0:
			var look_ahead = Vector2(sign(target.velocity.x) * look_ahead_distance, 0)
			target_pos += look_ahead

		# Smoothly move camera
		global_position = global_position.lerp(target_pos, follow_speed * delta)
```

## Movement Tips & Best Practices

### Performance Optimization

1. **Use `move_and_slide()`** for CharacterBody2D - it's optimized
2. **Limit RigidBody2D** to objects that need realistic physics
3. **Use `_physics_process()`** for movement code (60fps by default)
4. **Cache frequently used nodes** in `_ready()`

### Feel and Polish

1. **Add acceleration/deceleration** instead of instant speed changes
2. **Implement coyote time** for better jumping feel
3. **Use easing functions** for smooth animations
4. **Add particle effects** and sound for movement feedback
5. **Consider input buffering** for responsive controls

### Common Patterns

- **Ground detection**: Use `is_on_floor()` for CharacterBody2D
- **Wall detection**: Use `is_on_wall()` and `get_wall_normal()`
- **Smooth stopping**: Use `move_toward()` for gradual velocity changes
- **State management**: Use enums for different movement states
- **Input handling**: Use `Input.get_axis()` for smooth analog input

### Debugging Movement

```gdscript
# Add to your movement script for debugging
func _draw():
    if Engine.is_editor_hint():
        return

    # Draw velocity vector
    draw_line(Vector2.ZERO, velocity * 0.1, Color.RED, 2)

    # Draw ground detection
    if is_on_floor():
        draw_circle(Vector2.ZERO, 10, Color.GREEN)
```

This comprehensive guide covers the essential movement patterns you'll need for most 2D games in Godot!
