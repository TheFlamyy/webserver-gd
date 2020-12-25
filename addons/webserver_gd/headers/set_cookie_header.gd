class_name SetCookieHeader
extends Resource

var cookies: Dictionary = {}
var options: Dictionary = {}

func _init(http: String) -> void:
	var semicolon: PoolStringArray = http.split(';')
	for pair in semicolon[0].split(','):
		var p: PoolStringArray = pair.split('=')
		cookies[p[0]] = p[1]
	
	semicolon.remove(0)
	for pair in semicolon:
		var p: PoolStringArray = pair.split('=')
		if p.size() > 1:
			options[p[0]] = p[1]
		else:
			options[p[0]] = null


func _to_string() -> String:
	var string: String = ''
	for cookie in cookies:
		string += "%s=%s," % [cookie, cookies[cookie]]
	
	string = string.trim_suffix(',') + ';'
	
	for option in options:
		var value = options.get(option, null)
		string += option
		if value:
			string += "=%s" % value
		string += ';'
	
	return string.trim_suffix(';')
