extends ProgressBar


@onready var decrease_timer: Timer = $Timer
@export var decrease_speed: float = 0.1 # Units per second
@export var meltdown_video : VideoStreamPlayer


func _ready():
	decrease_timer.timeout.connect(decrease_time)

func _process(delta):
	$Label.text = str(value)	
	
func decrease_time() -> void:
	
	if value > min_value:
		
		value -= decrease_speed
		value = max(value, min_value) # Ensure value doesn't go below min_value
		#crystal.deposit_crystal.connect(_on_deposit_crystal)
		
	if value == 0:
		decrease_timer.stop()
		meltdown_video.play()
		await meltdown_video.finished
		get_tree().change_scene_to_file("res://addons/cogito/DemoScenes/COGITO_0_MainMenu.tscn")
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		
	





func _on_detection_area_body_entered(body: Node3D) -> void:
	print("Deposit")
	print(value)
	if value <= 80:
		print("add time")
		value += 20
	else:
		value = 100


func _on_deposit_area_body_entered(body: Node3D) -> void:
	print(body.name)
	print(value)
	if body.is_in_group("Crystal"):
		print("setting time")
		if value <= 80:
			value += 20
		else:
			value = 100
		body.queue_free()
