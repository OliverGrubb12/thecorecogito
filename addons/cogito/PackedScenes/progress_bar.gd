extends ProgressBar

@onready var progress_bar: ProgressBar = $"."
@onready var decrease_timer: Timer = $"../Decrease Timer"

func _ready() -> void:
	progress_bar.max_value = 100
	progress_bar.min_value = 0
	
	if decrease_timer.timeout:
		progress_bar.value - 10
