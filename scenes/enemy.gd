extends Node3D
@onready var hitbox: Area3D = $Hitbox
@export var enemy_damage = 100
@export var enemy_health = 100

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_hitbox_area_entered(area: Area3D) -> void:
	pass
	
