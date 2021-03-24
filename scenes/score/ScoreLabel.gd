extends Label

var score = 0

func scored():
	score += 1
	text = str(score)
