extends State
class_name PlayerMoveState

@export var player: PlayerMain
@export var shake_animator: AnimationPlayer
@export var camera: Camera3D 

var direction = Vector3.ZERO
var lerp_speed: float = 15.0
var camera_side: int = 0

func Enter(): shake_animator.speed_scale = 1.2

func Update(delta: float):
	if player.is_on_floor():
		if Input.is_action_just_pressed("jump"): state_transition.emit(self, "JumpState")
	else:
		pass

	var input_dir = Input.get_vector("left", "right", "forward", "backward")
	var to_direction = (player.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	direction = lerp(direction, to_direction, delta * lerp_speed)

	camera_side = int(Input.get_axis("right", "left"))
	camera.rotation.z = lerp(camera.rotation.z, deg_to_rad(1.8 * camera_side) , 5 * delta)

	if to_direction:
		
		shake_animator.play("walk")
		
		player.velocity.x = direction.x * player.current_speed * delta
		player.velocity.z = direction.z * player.current_speed * delta
	else:
		shake_animator.stop()
		state_transition.emit(self, "IdleState")
		shake_animator.play("idle")
