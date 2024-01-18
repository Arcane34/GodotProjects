extends Node2D

@onready var poly = $StaticBody2D/Polygon2D
@onready var collider = $StaticBody2D/CollisionPolygon2D
var fnl = FastNoiseLite.new()

var sizeOfScreen = DisplayServer.window_get_size()
func _ready():
	fnl.seed = randi()
	var points = []
	var prevV = 0
	
	
#	points.append(Vector2(0, sizeOfScreen[1]))
#	for pos in range(sizeOfScreen[0]+1):
#		prevV = (sizeOfScreen[1] * abs(fnl.get_noise_1d(pos)) /2) + sizeOfScreen[1]/2
#		points.append(Vector2(pos, prevV))
#	points.append(Vector2(sizeOfScreen[0], sizeOfScreen[1]))
	
	points.append(Vector2(0, sizeOfScreen[1]))
	for pos in range(sizeOfScreen[0]+1):
		prevV += (fnl.get_noise_1d(pos/2) *5)
		if prevV < -sizeOfScreen[1]/2:
			prevV = -sizeOfScreen[1]/2 +1
		if prevV > sizeOfScreen[1]/2:
			prevV = sizeOfScreen[1]/2 -1
		points.append(Vector2(pos, prevV + sizeOfScreen[1]/2))
	points.append(Vector2(sizeOfScreen[0], sizeOfScreen[1]))
	
	
	print(points)
	poly.polygon = PackedVector2Array(points)
	collider.polygon = PackedVector2Array(points)
	poly.uv = PackedVector2Array(points)
