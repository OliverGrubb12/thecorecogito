extends ProgressBar

@onready var progress_bar: ProgressBar = $"."
@onready var decrease_timer: Timer = $"../Decrease Timer"
@export var decrease_speed: float = 0.33 # Units per second

func _process(delta: float) -> void:
	if progress_bar.value > min_value:
		progress_bar.value -= decrease_speed * delta
		progress_bar.value = max(value, min_value) # Ensure value doesn't go below min_value
		#crystal.deposit_crystal.connect(_on_deposit_crystal)

func _on_deposit_crystal():
	if progress_bar.value <= 80:
		progress_bar.value + 20
	else:
		progress_bar.value = 100
		


func _on_detection_area_body_entered(body: Node3D) -> void:
	if progress_bar.value <= 80:
		progress_bar.value + 20
	else:
		progress_bar.value = 100
