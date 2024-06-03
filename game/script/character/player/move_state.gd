extends State
class_name PlayerMoveState

@export var player: PlayerMain
@export var animator: AnimationPlayer

var direction = Vector3.ZERO
var lerp_speed: float = 15.0

func Enter(): animator.speed_scale = 1.2

func Update(delta: float):
	if player.is_on_floor():
		if Input.is_action_just_pressed("jump"): state_transition.emit(self, "JumpState")
	else:
		pass

	var input_dir = Input.get_vector("left", "right", "forward", "backward")
	var to_direction = (player.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	direction = lerp(direction, to_direction, delta * lerp_speed)

	if to_direction:
		animator.play("walk")
		
		player.velocity.x = direction.x * player.current_speed * delta
		player.velocity.z = direction.z * player.current_speed * delta
	else:
		state_transition.emit(self, "IdleState")

