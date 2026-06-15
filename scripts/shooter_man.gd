extends Node3D
@onready var timer: Timer = $Timer
const LIGHT_BULLET = preload("uid://bar53c5gm6f2y")
@onready var bullet_spawn: Marker3D = $bullet_spawn


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	var bullet_instance = LIGHT_BULLET.instantiate()
	get_tree().current_scene.add_child(bullet_instance)
	
	var spawn_transform = bullet_spawn.global_transform
	
	bullet_instance.global_transform = spawn_transform
