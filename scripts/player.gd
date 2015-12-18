extends RigidBody2D

var input_states = preload("res://scripts/input_states.gd")

export var player_speed = 200
export var acel = 5
export var extra_gravity = 400
export var jump_force = 2000
var raycast_down = null

var cur_speed = Vector2(0,0)

var btn_right = input_states.new("btn_right")
var btn_left = input_states.new("btn_left")
var btn_up = input_states.new("btn_up")
#var btn_down = Input.is_action_pressed("btn_down")

func is_on_ground():
	if raycast_down.is_colliding():
		return true
	else:
		return false
	

func move(vel, acel, delta):
	cur_speed.x = lerp(cur_speed.x, vel, acel * delta)
	set_linear_velocity( Vector2(cur_speed.x, get_linear_velocity().y))

func _ready():
	raycast_down = get_node("raycast_down_player")
	raycast_down.add_exception(self) 
	set_applied_force(Vector2(0, extra_gravity))
	set_fixed_process(true)
	
func _fixed_process(delta):
#	set_gravity_scale(20)
#	btn_right = Input.is_action_pressed("btn_right")
#	btn_left = Input.is_action_pressed("btn_left")
#	btn_up = Input.is_action_pressed("btn_up")
#	btn_down = Input.is_action_pressed("btn_down")
	
	
	if btn_left.check() == 2:
		move(-player_speed, acel, delta)
#		set_linear_velocity(Vector2(-player_speed, get_linear_velocity().y))
	elif btn_right.check() == 2:
		move(player_speed, acel, delta)
#		set_linear_velocity(Vector2(player_speed, get_linear_velocity().y))
	
#	elif btn_down:
#		set_linear_velocity(Vector2(get_linear_velocity().x, player_speed))
	else:
		move(0, acel, delta)
#		set_linear_velocity(Vector2(0, player_speed))
	if btn_up.check() == 1:
#		print("cima")
		if is_on_ground():
#			print("tira o pe do chao")
			set_axis_velocity(Vector2(0, -jump_force))
#		set_linear_velocity(Vector2(get_linear_velocity().x, -player_speed))

