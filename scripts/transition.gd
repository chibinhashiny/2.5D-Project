extends ColorRect
@onready var shader := material as ShaderMaterial
signal transition_over

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	material.set_shader_parameter("height", -1.0)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("continue") and get_tree().current_scene.name == "VictoryAndShi":
		start_transition()

func start_transition():
	var tween = create_tween()
	tween.tween_method(
		func(v):
			material.set_shader_parameter("height",v),
			-1.0,
			1.0,
			1.0
	)
	await tween.finished
	transition_over.emit()
