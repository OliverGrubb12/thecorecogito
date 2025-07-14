extends CharacterBody3D

@export var speed: float = 3.0
@export var patrol_point_a: Vector3 = Vector3(-30, 0, 0)
@export var patrol_point_b: Vector3 = Vector3(-25, 0, 0)
@export var rotation_speed: float = 5.0
@export var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")
@onready var detection_area: Area3D = $"Detection Area"

var patrol_a_global: Vector3
var patrol_b_global: Vector3
var target_position: Vector3
var is_chasing: bool = false
var player: Node3D = null

var moving_to_a: bool = false

func _ready():
	patrol_a_global = global_position + patrol_point_a
	patrol_b_global = global_position + patrol_point_b
	target_position = patrol_b_global
	moving_to_a = false

	detection_area.body_entered.connect(_on_body_entered)
	detection_area.body_exited.connect(_on_body_exited)

func _physics_process(delta):
	# Apply gravity
	if not is_on_floor():
		velocity.y -= gravity * delta
	else:
		velocity.y = 0

	var current_speed = speed

	if is_chasing and player and player.is_inside_tree():
		# Chase player on XZ plane only
		target_position = Vector3(player.global_position.x, global_position.y, player.global_position.z)
		current_speed = speed * 2  # Double speed when chasing
	else:
		# Patrol behavior
		var horizontal_pos = Vector3(global_position.x, 0, global_position.z)
		var horizontal_target = Vector3(target_position.x, 0, target_position.z)

		if horizontal_pos.distance_to(horizontal_target) < 0.3:
			# Swap patrol target
			if moving_to_a:
				target_position = patrol_b_global
				moving_to_a = false
			else:
				target_position = patrol_a_global
				moving_to_a = true

	var direction = target_position - global_position
	direction.y = 0  # Lock Y to zero for horizontal movement

	if direction.length() > 0.01:
		direction = direction.normalized()
		velocity.x = direction.x * current_speed
		velocity.z = direction.z * current_speed

		# Rotate to face movement direction smoothly
		var target_yaw = atan2(direction.x, -direction.z)
		rotation.y = lerp_angle(rotation.y, target_yaw, rotation_speed * delta)
	else:
		velocity.x = 0
		velocity.z = 0

	move_and_slide()

func _on_body_entered(body):
	if body.is_in_group("Player"):
		player = body
		is_chasing = true

func _on_body_exited(body):
	if body == player:
		player = null
		is_chasing = false
