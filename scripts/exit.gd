extends Node3D
@onready var transition: ColorRect = $"../CanvasLayer/transition"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_3d_body_entered(body: Node3D) -> void:
	if global_configs.has_the_thing:
		transition.start_transition()
		await transition.transition_over
		get_tree().change_scene_to_file("res://scenes/victory_and_shi.tscn")
	pass # Replace with function body.
