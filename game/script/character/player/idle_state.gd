extends State
class_name PlayerIdleState

@export var player: PlayerMain
@export var shake_animator: AnimationPlayer
@export var camera: Camera3D

func Enter(): 
	shake_animator.speed_scale = 0.1

func Update(delta: float):
	camera.rotation.z = lerp(camera.rotation.z, 0.0, 5 * delta)
	if Input.is_action_pressed("jump") and player.is_on_floor(): 
		state_transition.emit(self, "JumpState")
		return

	if Input.get_vector("left", "right", "forward", "backward").normalized():
		state_transition.emit(self, "MoveState")
		return

	player.velocity.x = move_toward(player.velocity.x * delta, 0, player.current_speed)
	player.velocity.z = move_toward(player.velocity.z * delta, 0, player.current_speed)
