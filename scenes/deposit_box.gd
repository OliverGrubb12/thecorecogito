extends Node3D
@onready var deposit_area: Area3D = $"core bin/Cube_001/Deposit Area"

signal deposit_crytsal

#func _ready():
#	# Correctly connect using a callable
#	connect("body_entered", Callable(self, "_on_body_entered"))

#func _on_body_entered(body: Node) -> void:
#	# Only act on crystals
#	if body.is_in_group("crystals"):
#		body.deposit()	# calls deposit() from Crystal.gd

func _ready():
	deposit_area.area_entered.connect(_on_deposit_area_area_entered)

func _on_deposit_area_area_entered(area: Area3D) -> void:
	if area.is_in_group("Crystal"):
		var crystal_root = area.get_owner()
		if crystal_root:
			deposit_crytsal.emit()
			crystal_root.queue_free()
			
			
			
			
#	if area.is_in_group("Crystal"):
#		var crystal_root: Node = area.get_owner()
#		if crystal_root:
#			crystal_root.notify_deposit()
			
#		area.queue_free()  # remove the detection area so crystal disappears
