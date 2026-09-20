extends Area2D

@export var WinScreen : Control





func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		WinScreen.show();
