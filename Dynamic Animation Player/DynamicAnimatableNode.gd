extends Node
class_name DynamicAnimatableNode

@export var node: Node
@export var sound_effect: AudioStreamPlayer
@export var animations: Dictionary[String, DynamicAnimation]
@export var play_sound_effect: bool
var tween: Tween

func check_sound() -> void:
	if play_sound_effect:
		sound_effect.play()
		play_sound_effect = false

func play_key(key: DynamicAnimationKey):
	tween = get_tree().create_tween()
	if key.play_sound_effect:
		sound_effect.play()
	tween.tween_property(node, key.property, key.value.value, key.duration)
	if !key.neasted_mode:
		await tween.finished
	else:
		tween.finished

func play(anime_name: String):
	var animation :DynamicAnimation = animations.get(anime_name)
	for key in animation.keys:
		await play_key(key)

func stop():
	tween.stop()

func pause():
	tween.pause()

func set_speed_scale(speed_scale: int):
	tween.set_speed_scale(speed_scale)
