extends Node3D

@export var id := -1
@export var damage := 1
@export_range(0.0, 2, 0.01) var fire_rate # (float, 0.0, 2, 0.01)

@onready var fire_rate_timer := $FireRateTimer

var selected := false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	fire_rate_timer.wait_time = fire_rate
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta) -> void:
	
	if not selected:
		
		return
		
	
	if Input.is_action_pressed("fire_weapon") and fire_rate_timer.is_stopped():
		
		fire_rate_timer.start()
		fire()
		
	


func fire() -> void:
	
	print("Weapon number ", id, " fired!")
	
