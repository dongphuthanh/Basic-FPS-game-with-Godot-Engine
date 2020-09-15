extends KinematicBody

export var speed =50
export var acceleration=5
export var gravity=50
export var jump_power=30
export var mouse_sensitivity=0.3
export var time=0.1
onready var head=$Head
onready var camera=$Head/Camera
onready var raycast=$Head/Camera/RayCast




var velocity=Vector3()
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(deg2rad(-event.relative.x*mouse_sensitivity))
		head.rotate_x(deg2rad(-event.relative.y*mouse_sensitivity))

	if Input.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
func _physics_process(delta):
	var head_basis=head.get_global_transform().basis
	var direction=Vector3()
	direction.y-=gravity
	if Input.is_action_pressed("move_foward"):
		 direction -=head_basis.z 
	if Input.is_action_pressed("move_back"):
		 direction +=head_basis.z 
	if Input.is_action_pressed("move_right"):
		 direction +=head_basis.x
	if Input.is_action_pressed("move_left"):
		 direction -=head_basis.x 
	direction=direction.normalized()
	velocity=velocity.linear_interpolate(direction*speed, acceleration*delta)
	velocity=move_and_slide(velocity)
	if Input.is_action_pressed("fire"):
		check_collision()
	



	
func check_collision():
	if raycast.is_colliding():
		if raycast.get_collider().is_in_group("Enemies") or raycast.get_collider().is_in_group("ass"):
			raycast.get_collider().queue_free()


