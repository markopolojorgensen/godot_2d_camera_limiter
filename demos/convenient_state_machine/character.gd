extends Node2D

enum states {
	running,
	jumping,
	falling,
	idle,
	attacking,
}

func _ready():
	configure_state_machine()
	for input_label in $inputs.get_children():
		input_label.hide()

func configure_state_machine():
	$StateMachine.on_transition(running, jumping, self, "running_to_jumping")
	$StateMachine.on_transition(running, falling, self, "running_to_falling")
	$StateMachine.on_transition(running, idle, self, "running_to_idle")
	$StateMachine.on_transition(running, attacking, self, "running_to_attacking")
	
	$StateMachine.on_transition(jumping, running, self, "jumping_to_running")
	$StateMachine.on_transition(jumping, falling, self, "jumping_to_falling")
	$StateMachine.on_transition(jumping, attacking, self, "jumping_to_attacking")
	
	$StateMachine.on_transition(falling, running, self, "falling_to_running")
	$StateMachine.on_transition(falling, idle, self, "falling_to_idle")
	$StateMachine.on_transition(falling, attacking, self, "falling_to_attacking")
	
	$StateMachine.on_transition(idle, running, self, "idle_to_running")
	$StateMachine.on_transition(idle, jumping, self, "idle_to_jumping")
	$StateMachine.on_transition(idle, falling, self, "idle_to_falling")
	$StateMachine.on_transition(idle, attacking, self, "idle_to_attacking")
	
	$StateMachine.on_transition(attacking, falling, self, "attacking_to_falling")
	$StateMachine.on_transition(attacking, idle, self, "attacking_to_idle")
	
	$StateMachine.current_state = idle

func _process(delta):
	$StateLabel.text = str(get_state_name())

func get_state_name():
	for key in states.keys():
		# print("%s - %s == %s?" % [str(key), str(states[key]), str($StateMachine.current_state)])
		if states[key] == $StateMachine.current_state:
			return key
		
	# print("unknown state: %s" % $StateMachine.current_state)

func _unhandled_input(event):
	if event.is_action_pressed("ui_left"):
		$inputs/left.show()
	elif event.is_action_released("ui_left"):
		$inputs/left.hide()
	
	if event.is_action_pressed("ui_right"):
		$inputs/right.show()
	elif event.is_action_released("ui_right"):
		$inputs/right.hide()
	
	if event.is_action_pressed("ui_page_up"):
		$inputs/jump.show()
	elif event.is_action_released("ui_page_up"):
		$inputs/jump.hide()
	
	if event.is_action_pressed("ui_accept"):
		$inputs/attack.show()
	elif event.is_action_released("ui_accept"):
		$inputs/attack.hide()


func running_to_jumping():
	print("running to jumping: horizontal leap")

func running_to_falling():
	print("running to falling: hop down")

func running_to_idle():
	print("running to idle: skid to a stop")

func running_to_attacking():
	print("running to attack: strong attack")



func jumping_to_running():
	print("jumping to running: ledge grab?")

func jumping_to_falling():
	print("jumping to falling: peak leap")

# jumping_to_idle doesn't exist, not doing anything during jump leads to falling

func jumping_to_attacking():
	print("jumping to attacking: mid-air attack")



func falling_to_running():
	print("falling to running: roll landing")

# falling_to_jumping doesn't exist, have to be touching the ground to jump

func falling_to_idle():
	print("falling to idle: three point landing")

func falling_to_attacking():
	print("falling to attacking: mid-air attack")



func idle_to_running():
	print("idle_to_running: dash forward")

func idle_to_jumping():
	print("idle_to_jumping: high jump")

func idle_to_falling():
	print("idle_to_falling: caught off guard")
	
func idle_to_attacking():
	print("idle_to_attacking: quick draw attack")



# func attacking_to_running doesn't exist, always idle after attack

# func attacking_to_jumping doesn't exist, always idle after attack

func attacking_to_falling():
	print("attacking_to_falling: attack finished and in the air!")

func attacking_to_idle():
	print("attacking_to_falling: standard recovery")


