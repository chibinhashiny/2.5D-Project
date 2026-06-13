extends Node3D
var speed = 5.0
var height = 0.5
var time_accumulated = 0.0
@onready var start_y = position.y

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time_accumulated += delta
	position.y = start_y + sin(time_accumulated * speed) * height
	if global_configs.has_the_thing == true:
		self.visible = false
	else:
		self.visible = true	
	pass


func _on_area_3d_body_entered(body: Node3D) -> void:
	global_configs.has_the_thing = true
	print("entrou")
	pass # Replace with function body.
