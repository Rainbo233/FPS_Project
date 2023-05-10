extends Node3D

@onready var guns := get_children()

var current_gun := 0


# Called when the node enters the scene tree for the first time.
func _ready():
	
	for gun in guns:
		
		gun.hide()
		
	
	guns[0].show()
	guns[0].selected = true
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if Input.is_action_just_pressed("swap_weapon_forward"):
		
		change_weapon(1)
		
	if Input.is_action_just_pressed("swap_weapon_backward"):
		
		change_weapon(-1)
		
	

func change_weapon(index: int) -> void:
	
	guns[current_gun].hide()
	guns[current_gun].selected = false
	current_gun += index
	
	if current_gun < 0:
		
		current_gun = guns.size() - 1
		
	elif current_gun >= guns.size():
		
		current_gun = 0
		
	
	guns[current_gun].show()
	guns[current_gun].selected = true
	

func _input(event)-> void:
	
	pass
	
