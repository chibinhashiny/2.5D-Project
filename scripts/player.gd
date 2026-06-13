extends CharacterBody3D
@export var speed = 15
@export var fall_acceleration = 76
@export var jump_speed = 20
var target_velocity = Vector3.ZERO
@export var player_sprite : AnimatedSprite2D
var is_moving = false
var last_dir
var is_jumping = false
@onready var spring_cam : SpringArm3D = $SpringArm3D
@onready var has_the_thing_text: Label = $has_the_thing_text
@onready var coyote_timer: Timer = $coyote_timer

var coyote_frames = 4
var coyote = false
var last_floor = false

func _ready() -> void:
	coyote_timer.wait_time = coyote_frames / 60.0
	
func _process(delta: float) -> void:
	if global_configs.has_the_thing == true:
		has_the_thing_text.text = "has the thing"
	else:
		has_the_thing_text.text = "doesnt have the thing"
	
	if global_configs.died:
		self.position.x = 0
		self.position.y = 0
		self.position.z = 0
		global_configs.has_the_thing = false
		global_configs.died = false		

func _physics_process(delta: float) -> void:
	var direction = Vector3.ZERO
	#print(is_jumping)
	#if is_on_floor():
		#is_jumping = false
		#return
	
	if !is_on_floor() and last_floor and !is_jumping:
		coyote = true
		coyote_timer.start()
		
	if Input.is_action_just_pressed("jump") and (is_on_floor() or coyote):
		#is_jumping = true
		target_velocity.y = jump_speed
		
	
	if Input.is_action_pressed("right"):
		last_dir = "RIGHT"
		direction.x += 1
		
	if Input.is_action_pressed("left"):
		last_dir = "LEFT"
		direction.x -= 1
		
	if Input.is_action_pressed("down"):
		last_dir = "BACK"
		direction.z += 1
		
	if Input.is_action_pressed("up"):
		last_dir = "UP"
		direction.z -= 1		
	
	if direction.x or direction.z != 0:
		is_moving = true
	else:
		is_moving = false	
	
		
	if direction != Vector3.ZERO:
		direction = direction.normalized()
		#$SpringArm3D.basis = Basis.looking_at(direction)
	
	#////////// ANIMAÇÕES PARA IDLE ///////////
	if direction == Vector3.ZERO:		
		if last_dir == "RIGHT":
			player_sprite.animation = "idle_right"
			player_sprite.flip_h = false
			
		if last_dir == "LEFT":
			player_sprite.animation = "idle_right"
			player_sprite.flip_h = true
			
		if last_dir == "BACK":
			player_sprite.animation = "idle"
			
		if last_dir == "UP":
			player_sprite.animation = "idle_up"		
		
		if last_dir == "RIGHT_UP":
			player_sprite.flip_h = false
			player_sprite.animation = "idle_right_up"	
		
		if last_dir == "LEFT_UP":
			player_sprite.flip_h = true
			player_sprite.animation = "idle_right_up"	
			
		if last_dir == "RIGHT_DOWN":
			player_sprite.flip_h = false
			player_sprite.animation = "idle_down_right"
			
		if last_dir == "LEFT_DOWN":
			player_sprite.flip_h = true
			player_sprite.animation = "idle_down_right"	
				
	#////////// ANIMAÇÕES PARA CORRER ///////////
	if  direction == Vector3.RIGHT:
		player_sprite.flip_h = false
		player_sprite.animation = "run_right"	
				
	if direction == Vector3.LEFT:
		player_sprite.flip_h = true
		player_sprite.animation = "run_right"	
		
	if direction == Vector3.FORWARD:
		player_sprite.animation = "run_up"	
	
	if direction == Vector3.BACK:
		player_sprite.animation = "run_down"
	
	if direction.x > 0 and direction.z < 0:
		last_dir = "RIGHT_UP"
		player_sprite.flip_h = false
		player_sprite.animation = "run_right_up"
		
	if direction.x < 0 and direction.z < 0:
		last_dir = "LEFT_UP"
		player_sprite.flip_h = true
		player_sprite.animation = "run_right_up"
		
	if direction.x > 0 and direction.z > 0:
		last_dir = "RIGHT_DOWN"
		player_sprite.flip_h = false
		player_sprite.animation = "run_down_right"
		
	if direction.x < 0 and direction.z > 0:
		last_dir = "LEFT_DOWN"
		player_sprite.flip_h = true
		player_sprite.animation = "run_down_right"
		
	
	#////////// ANIMAÇÕES PARA PULO ///////////	
	#if last_dir == "BACK" and is_jumping:
		
		
	target_velocity.x = direction.x * speed
	target_velocity.z = direction.z * speed	
	
	if not is_on_floor():
		target_velocity.y = target_velocity.y - (fall_acceleration * delta)
	
	#print(player_sprite.animation)
	velocity = target_velocity
	last_floor = is_on_floor()
	move_and_slide()	

	


func _on_coyote_timer_timeout() -> void:
	coyote = false
