extends ProgressBar

@onready var progress_bar: ProgressBar = $"."
@onready var decrease_timer: Timer = $"../Decrease Timer"
@export var decrease_speed: float = 0.33 # Units per second

func _process(delta: float) -> void:
	if value > min_value:
		value -= decrease_speed * delta
		value = max(value, min_value) # Ensure value doesn't go below min_value

func _on_crystal_deposited() -> void:
	progress_bar.value = 100 
