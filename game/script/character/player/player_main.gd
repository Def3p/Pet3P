extends CharacterBody3D
class_name PlayerMain

@export var sprinting_speed: float = 400.0
@export var sprinting_animator: float = 1.4
@export var walking_speed: float = 275.0
@export var walking_animator: float = 1.0
@export var crouching_speed: float = 150.0
@export var crouching_animator: float = 0.8
@export var jump_force: float = 4.8

var is_falling: bool = false
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var mouse_sens: float = 0.2
var current_speed: float
var gravity_percentage: float = 1

@onready var camera = $Head/Camera3D
@onready var fsm_node = $FiniteStateMachine
@onready var shake_animator = $CameraShakeAnimator
@onready var head_node = $Head

func _ready(): 
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	current_speed = walking_speed

func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(deg_to_rad(-event.relative.x * mouse_sens))
		head_node.rotate_x(deg_to_rad(-event.relative.y * mouse_sens))
		head_node.rotation.x = clamp(head_node.rotation.x, deg_to_rad(-88), deg_to_rad(88))

func _process(delta: float) -> void:
	$Control/Label.text = str(Engine.get_frames_per_second())

func _physics_process(delta):
	if !is_on_floor(): velocity.y -= gravity * delta

	falling_condition(delta)
	move_condition(delta)
	move_and_slide()

func move_condition(_delta):
	if Input.is_action_pressed("crouch"): 
		current_speed = crouching_speed
		shake_animator.speed_scale = crouching_animator
	elif Input.is_action_pressed("sprint"): 
		current_speed = sprinting_speed
		shake_animator.speed_scale = sprinting_animator
	else: 
		current_speed = walking_speed
		shake_animator.speed_scale = walking_animator

func falling_condition(delta):
	if fsm_node.current_state.name == "FallState": 
		camera.fov = lerp(camera.fov, 79.5, delta)
	elif fsm_node.current_state.name == "MoveState" and Input.is_action_pressed("sprint"):
		camera.fov = lerp(camera.fov, 84.0, delta)
	else: camera.fov = lerp(camera.fov, 75.0, delta * 1.5)

func _on_health_component_death():
	pass # Replace with function body.
