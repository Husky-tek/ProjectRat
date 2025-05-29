extends Node2D

class_name Player

@export var attack: float
@export var defence: float
@export var crit_rate: float
@export var speed: int

func setAll (atk,def,crit,run):
	attack = atk
	defence = def
	crit_rate = crit
	speed = run

func setAtk (atk):
	attack = atk
	
func setDef (def):
	defence = def
	
func setcrit (crit):
	crit_rate = crit

func setSpeed (run):
	speed = run

func getAtk():
	return attack

func getDef():
	return defence

func getCrit():
	return crit_rate

func getSpeed():
	return speed
