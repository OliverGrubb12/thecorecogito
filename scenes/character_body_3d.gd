extends CharacterBody3D

@onready var player = get_tree().get_first_node_in_group("Player")
@onready var isChasing: bool
@onready var isSearching: bool

@onready var radar: int = 0

@onready var nav: NavigationAgent3D = $NavigationAgent3D

@onready var randomPos = Vector3(randf_range(-75, 50), position.y, randf_range(-85, 20))

var lastPos
var hasSeen : bool

@onready var walkingSpeed = 4
@onready var chasingSpeed = 8
@onready var speed = chasingSpeed
@onready var screwed := false

@onready var wanderTimer = 60.0

func _process(delta):
	if isChasing:
		chase()
		speed = chasingSpeed
	else:
		speed = walkingSpeed
		wandering(delta)
	
	var direction = nav.get_next_path_position()-global_position
	direction = direction.normalized()
	
	velocity = velocity.lerp(direction * speed, delta * 10)
	
	move_and_slide()


func chase():
	look_at(player.position)
	nav.target_position = player.global_position
	

func wandering(delta):
	look_at(global_transform.origin + velocity)
	hasSeen = false
	nav.target_positon = randomPos
	if (abs(randomPos.x - global_position.x) <= 5 and abs(randomPos.z - global_positon.z) <= 5) or wanderTimer <=0:
		randomPos = Vector3(randf_range(player.global_position.x-40, player.global_position.x-40), position.y, randf_range(player.global_position.z-40, player.global_position.z+40))
		clamp(randomPos.x, -75, 50)
		clamp(randomPos.z, -85, 20)
		wanderTimer = 60
	wanderTimer -=delta


func _on_hitbox_body_entered(body: Node3D) -> void:
	if body.is_in_group("Player"):
		isChasing = true
	


func _on_detector_body_entered(body: Node3D) -> void:
	pass # Replace with function body.
