extends Sprite

var original_position
var comparison = 0
var delta_sum = 0

func _ready():
	original_position = global_position

func _physics_process(delta):
	var offset = $NoiseGenerator.get_noise(delta)
	global_position.y = original_position.y + (offset * 100.0)
	
	comparison += offset # * delta
	delta_sum += delta * 0.5
	$"../Label3".text = str(comparison) # / delta_sum)

