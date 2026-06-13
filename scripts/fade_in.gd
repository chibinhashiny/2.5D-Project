extends ColorRect


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#self.rotation_degrees = -180
	fade_in()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func fade_in():
	var tween = create_tween()
	tween.tween_method(
		func(v):
			material.set_shader_parameter("height",v),
			1.0,
			-1.0,
			1.0
	)
