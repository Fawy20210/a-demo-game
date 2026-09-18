extends Area2D

@export var tileMapLayer : TileMapLayer;
# Called when the node enters the scene tree for the first time.
var velocity = Vector2(500, -500)
var drag = 10
func _ready() -> void:
	if transform.x.x == -1:
		velocity.x *= -1;
		get_node("Sprite2D").flip_v = true
	print(velocity, transform)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _physics_process(delta):
	#position += transform.x * speed * delta
	velocity.y += get_gravity() * delta
	
	#velocity.x = move_toward(velocity.x, 0, drag)
	velocity.x *= 0.99
	
	position += velocity * delta; 


func _on_body_entered(body: Node2D, ) -> void:
	if body.name == "Player":
		pass
	elif body.is_class("TileMapLayer"):
		var tile = tileMapLayer.local_to_map(tileMapLayer.to_local(position)) #+ Vector2i(transform.x) +Vector2(16*transform.x.x,16)
		print(position, tile, transform)
		if tileMapLayer.get_cell_tile_data(tile):
			if tileMapLayer.get_cell_tile_data(tile).get_custom_data("Destructable"):
				tileMapLayer.erase_cell(tile)
		else:
			var p1 = Vector2((tile.x+transform.x.x)*64+32,tile.y*64+32)
			var p2 = Vector2(tile.x*64+32,(tile.y+transform.x.x)*64+32)
			var d1 = (position - p1).length()
			var d2 = (position - p2).length()
			
			if(d1 < d2):
				if tileMapLayer.get_cell_tile_data(tile + Vector2i(transform.x.x, 0)):
					if tileMapLayer.get_cell_tile_data(tile+Vector2i(transform.x.x, 0)).get_custom_data("Destructable"):
						tileMapLayer.erase_cell(tile+Vector2i(transform.x.x, 0))
			else:
				if tileMapLayer.get_cell_tile_data(tile + Vector2i(0, 1)):
					if tileMapLayer.get_cell_tile_data(tile+Vector2i(0, 1)).get_custom_data("Destructable"):
						tileMapLayer.erase_cell(tile+Vector2i(0, 1))
				
		
	else:
		queue_free()
		
	pass # Replace with function body.
