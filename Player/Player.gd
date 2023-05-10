extends CharacterBody3D

@export var speed := 250
@export var jump_height := 25
@export_range(0.0, 2.0, 0.01) var gravity
@export_range(0.0, 1.0, 0.01) var mouse_sensitivity

@onready var camera := $Camera3D

var direction_vector := Vector3.ZERO

var camera_anglev := 0
var friction := 0.1

func _physics_process(delta):
	
	if Input.is_action_just_pressed("quit"):
		
		get_tree().quit()
		
	
	# Gets user input and changes the movement vector to reflect the direction the camera
	# is facing.
	direction_vector += transform.basis.z * Input.get_axis("move_forward", "move_backwards") * delta
	direction_vector += transform.basis.x * Input.get_axis("move_left", "move_right") * delta
	
	# Normalizes the vector to have a uniform speed.
	if direction_vector.length() > 1:
		
		direction_vector.normalized()
		
	
	# Slows the player to a halt when not moving.
	direction_vector.x = lerp(direction_vector.x, 0.0, friction)
	direction_vector.z = lerp(direction_vector.z, 0.0, friction)
	
	# If the player is on the floor, stops gravity from being applied
	# and checks for jump input.
	if is_on_floor():
		
		direction_vector.y = 0
		
		if Input.is_action_pressed("jump"):
			
			direction_vector.y += jump_height * delta
			
		
	# Applies gravity when in air.
	elif not is_on_floor():
		
		direction_vector.y -= gravity * delta
		
	
	# Moves the player with correct direction and speed.
	var velocity := direction_vector * speed
	set_velocity(velocity)
	set_up_direction(Vector3.UP)
	move_and_slide()
	

func _unhandled_input(event):
	
	# Hides and keeps mouse cursor in the game window.
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	if event is InputEventMouseMotion:
		
		# Ties the left/right camera movment to the player, and
		# ties the up/down movement to the camera itself.
		rotate_y(deg_to_rad(-event.relative.x * mouse_sensitivity))
		var changev = -event.relative.y * mouse_sensitivity
		if camera_anglev + changev > -50 and camera_anglev + changev < 50:
			
			camera_anglev += changev
			camera.rotate_x(deg_to_rad(changev))
			
		
	

