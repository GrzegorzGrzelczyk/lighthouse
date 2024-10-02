extends Node2D

@onready var lightbeam: Sprite2D = $Lightbeam

# lightbeam_facing used later on to calculate soul collision with the beam
# https://docs.godotengine.org/en/3.1/tutorials/math/vector_math.html#facing
var lightbeam_facing := Vector2.ONE.normalized()
var lightbeam_rotation_speed: float = 40.0 # [deg]/s

var lightbeam_scale: int = 1


func _physics_process(delta: float) -> void:
	lightbeam_facing = lightbeam_facing.rotated(deg_to_rad(lightbeam_rotation_speed) * delta) # Rotates lightbeam_facing by lightbeam_rotation_speed
	lightbeam.rotation = Vector2.ONE.angle_to(lightbeam_facing) # Rotates Lightbeam Sprite2D by the same value as lightbeam_facing is rotated
	
	# !!! MAKE SIGNAL BASED IN THE FUTURE !!!
	lightbeam.scale = lightbeam_scale * Vector2.ONE # Scales Lightbeam Sprite2D with all child nodes
	
	if Engine.get_physics_frames() % 3 == 0: # Every 3 physics frames.
		for i:Node in get_tree().get_nodes_in_group("souls"): # For each node in group "souls"
			var L_to_S:Vector2 = (i.global_position - self.global_position) # Calculate Vector2 from Lighthouse to specific Soul
			# If dot product between L to S Vector2 and lightbeam facing Vector2 is bigger that 0.966 (15 deg difference)
			# AND distance L to S is smaller than beam length then:
			# In other words if the souls is in lightbeam.
			if L_to_S.normalized().dot(lightbeam_facing) > 0.966 and L_to_S.length() < 50.0 * lightbeam_scale: 
				i.queue_free() # Delete specific Soul instance
				SignalBus.soul_caught.emit(1) # Emit signal that the soul got caught by lightbeam
