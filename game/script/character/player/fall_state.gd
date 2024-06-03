extends State
class_name PlayerFallState

@export var player: PlayerMain

var lerp_speed: float = 25.0
var direction = Vector3.ZERO

func Enter(): pass

func Update(delta: float):
	if player.is_on_floor(): state_transition.emit(self, "IdleState")

	var input_dir = Input.get_vector("left", "right", "forward", "backward")
	var to_direction = (player.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	direction = lerp(direction, to_direction, delta * lerp_speed)

	if to_direction:
		player.velocity.x = direction.x * player.current_speed * delta
		player.velocity.z = direction.z * player.current_speed * delta
