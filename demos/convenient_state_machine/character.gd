extends Node2D

# This is a very contrived and incomplete example.
# I'd probably use multiple state machines for this sort of thing:
# attacks would have their own state machine:
#   not_attacking
#   wind-up (attack is still cancelable)
#   attacking (player is committed, no cancels allowed)
#     This might even be broken up again based on whether the hitbox should be enabled
#   recovery / follow-through
# 
# jumping would almost definitely be its own state machine:
#   on_the_ground
#   grace_period (not on the ground, but still allowed to jump)
#     (aka "ghost jumping")
#   ascending
#     player can cancel by releasing jump button, otherwise there's a timer
#   descending
#
# This can get quite tricky when we need to figure out what animation the sprite
# should be playing:
#   if jump_state == on_the_ground and is_action_pressed(ui_left/ui_right)
#     and attack_state == not_attacking:
#     play running animation
#
# I think that's kind of an inherent problem in games with these kind of detailed movement systems.

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
	
	# $StateMachine.on_transition(jumping, running, self, "jumping_to_running")
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
	# we only care if it's an action
	if not event.is_action_type():
		return
	
	# DEBUG / VISIBILITY
	
	if event.is_action_pressed("ui_left"):
		$inputs/left.show()
	elif event.is_action_released("ui_left"):
		$inputs/left.hide()
	
	if event.is_action_pressed("ui_right"):
		$inputs/right.show()
	elif event.is_action_released("ui_right"):
		$inputs/right.hide()
	
	if event.is_action_pressed("ui_up"):
		$inputs/jump.show()
	elif event.is_action_released("ui_up"):
		$inputs/jump.hide()
	
	if event.is_action_pressed("ui_accept"):
		$inputs/attack.show()
	elif event.is_action_released("ui_accept"):
		$inputs/attack.hide()
	
	# Behavior
	
	match $StateMachine.current_state:
		running:
			if event.is_action_released("ui_left"):
				$StateMachine.current_state = idle
			elif event.is_action_released("ui_right"):
				$StateMachine.current_state = idle
			elif event.is_action_pressed("ui_up"):
				$StateMachine.current_state = jumping
			elif event.is_action_pressed("ui_accept"):
				$StateMachine.current_state = attacking
		
		jumping:
			if event.is_action_released("ui_up"):
				$StateMachine.current_state = falling
			elif event.is_action_pressed("ui_accept"):
				$StateMachine.current_state = attacking
		
		falling:
			if event.is_action_pressed("ui_accept"):
				$StateMachine.current_state = attacking
			
		idle:
			if event.is_action_pressed("ui_left"):
				$StateMachine.current_state = running
			elif event.is_action_pressed("ui_right"):
				$StateMachine.current_state = running
			elif event.is_action_pressed("ui_up"):
				$StateMachine.current_state = jumping
			elif event.is_action_pressed("ui_accept"):
				$StateMachine.current_state = attacking
			elif event.is_action_pressed("ui_down"):
				$StateMachine.current_state = falling
		
		
		attacking:
			if event.is_action_released("ui_accept"):
				# probably want to check if airborne at the moment
				$StateMachine.current_state = idle
		
		_:
			print("jinkies or whatever")
	

func running_to_jumping():
	print("running to jumping: horizontal leap")

func running_to_falling():
	print("running to falling: hop down")

func running_to_idle():
	print("running to idle: skid to a stop")

func running_to_attacking():
	print("running to attack: strong attack")



# doesn't exsit, no ledge grabs or anything
# func jumping_to_running():
# 	print("jumping to running: ledge grab?")

func jumping_to_falling():
	print("jumping to falling: peak leap")
	# simulate air time, then hit the ground
	$Timer.wait_time = 2.0
	$Timer.start()
	yield($Timer, "timeout")
	
	if Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right"):
		$StateMachine.current_state = running
	else:
		$StateMachine.current_state = idle

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
	# simulate air time, then hit the ground
	$Timer.wait_time = 2.0
	$Timer.start()
	yield($Timer, "timeout")
	
	if Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right"):
		$StateMachine.current_state = running
	else:
		$StateMachine.current_state = idle

func idle_to_attacking():
	print("idle_to_attacking: quick draw attack")



# func attacking_to_running doesn't exist, always idle after attack

# func attacking_to_jumping doesn't exist, always idle after attack

func attacking_to_falling():
	print("attacking_to_falling: attack finished and in the air!")

func attacking_to_idle():
	print("attacking_to_falling: standard recovery")


