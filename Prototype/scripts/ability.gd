class_name Ability


const ABILITIES_SAVE_FILE = "res://abilities/abilties.dat"

var data = {}

var name : String = "default"
var attack_damage: float = 0.0
var status : String = ""
var status_number: float = 0.0
var path: String = "res://addons/duelyst_animated_sprites/assets/spriteframes/icons/artifact_boss_frostarmor.tres"
var sprite_frames: SpriteFrames


var button = Button.new()
var sprite = AnimatedSprite2D.new()
var label = Label.new()

func _ready():
	button.custom_minimum_size = Vector2(40,60)
	
	sprite_frames = load(path)
	sprite.offset = Vector2(20,20)
	sprite.centered = true
	sprite.sprite_frames = sprite_frames
	
	label.position = Vector2(0,42)
	label.size = Vector2(40,10)
	label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	label.set("theme_override_font_sizes/font_size", 5)
	label.text = name
	
	button.add_child(sprite)
	button.add_child(label)
	
