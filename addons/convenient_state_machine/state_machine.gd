extends Node

export(bool) var debug = false

var current_state setget set_current_state

var transitions = {
}

func on_transition(from_state, to_state, object, method):
	if not transitions.has(from_state):
		transitions[from_state] = {}
	
	transitions[from_state][to_state] = [object, method]

func set_current_state(new_state):
	# initial state, don't bother with transitioning from null
	if current_state == null:
		current_state = new_state
		return
	
	if not transitions.has(current_state):
		if debug:
			var message = "no transitions out of state %s (to %s or anything), not transitioning"
			print(message % [str(current_state), str(new_state)])
		return
	
	if not transitions[current_state].has(new_state):
		if debug:
			var message = "no transition from %s to %s specified"
			print(message % [str(current_state), str(new_state)])
		return
	
	var object = transitions[current_state][new_state][0]
	var method = transitions[current_state][new_state][1]
	
	if not object.has_method(method):
		# always complain about this
		print("%s doesn't have method %s" % [str(object), method])
		return
	else:
		object.call(method)
		if debug:
			print("transitioned from %s to %s" % [str(current_state), str(new_state)])
		current_state = new_state


