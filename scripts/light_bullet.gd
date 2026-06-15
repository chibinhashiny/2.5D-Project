extends Node3D
const SPEED = 10

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_tree().create_timer(2.0).timeout.connect(queue_free)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += transform.basis * Vector3(0,0,SPEED) * delta
	pass


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.name == "Player":
		global_configs.died = true
	pass # Replace with function body.
