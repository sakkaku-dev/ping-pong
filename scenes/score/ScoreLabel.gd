extends Label

signal score_change

var score = 0

func scored():
	score += 1
	text = str(score)
	emit_signal("score_change")
