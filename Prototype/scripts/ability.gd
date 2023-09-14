class_name Card

var attack_damage: float = 0.0
var status : String = ""
var status_number: float = 0.0
var sprite_frames: SpriteFrames
var button = Button.new()
var sprite = AnimatedSprite2D.new()

func _ready():
	button.custom_minimum_size = Vector2(40,60)
	sprite.offset = Vector2(20,20)
	sprite.centered = true
	sprite.sprite_frames = sprite_frames
	button.add_child(sprite)
	

func _process(_delta):
	if button.is_hovered():
		sprite.play("active")
	else:
		if sprite_frames.get_animation_names()[0] == "active":
			sprite.play(String(sprite_frames.get_animation_names()[1]))
		else:
			sprite.play(String(sprite_frames.get_animation_names()[0]))
