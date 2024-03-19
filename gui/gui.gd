extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_pistol_button_pressed():
	Globals.weapon_type = Globals.weapontype.PISTOL
func _on_blaster_button_pressed():
	Globals.weapon_type = Globals.weapontype.BLASTER
