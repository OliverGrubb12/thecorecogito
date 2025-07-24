extends CharacterBody3D

@export var speed: float = 3.0
@export var wander_radius: float = 50.0
@export var rotation_speed: float = 5.0
@export var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")
@onready var detection_area: Area3D = $"Detection Area"
#@onready var enemy_model = $EnemyMesh
#@onready var animator = $EnemyMesh/AnimationPlayer

var origin_position: Vector3
var target_position: Vector3
var is_chasing: bool = false
var player: Node3D = null

func _ready():
	origin_position = global_position
	_set_random_target()

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
		# Wander behavior: if close to target, pick a new random target
		var horizontal_pos = Vector3(global_position.x, 0, global_position.z)
		var horizontal_target = Vector3(target_position.x, 0, target_position.z)
		if horizontal_pos.distance_to(horizontal_target) < 1.0:
			_set_random_target()

	var direction = target_position - global_position
	direction.y = 0  # Lock Y for horizontal movement

	if direction.length() > 0.01:
		direction = direction.normalized()
		velocity.x = direction.x * current_speed
		velocity.z = direction.z * current_speed

		# Adjust this angle if your model faces a different direction
		var correction_angle = -PI / 2
		var target_yaw = atan2(direction.x, direction.z) + correction_angle

		rotation.y = lerp_angle(rotation.y, target_yaw, rotation_speed * delta)
	else:
		velocity.x = 0
		velocity.z = 0

	move_and_slide()

func _set_random_target():
	var random_offset = Vector3(
		randf_range(-wander_radius, wander_radius),
		0,
		randf_range(-wander_radius, wander_radius)
	)
	target_position = origin_position + random_offset

func _on_body_entered(body):
	if body.is_in_group("Player"):
		player = body
		is_chasing = true

func _on_body_exited(body):
	if body == player:
		player = null
		is_chasing = false
		_set_random_target()
