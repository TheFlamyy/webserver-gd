class_name WebRequest
extends Resource

var method: String
var uri: String
var version: String
var header: WebHeaders
var body: String

var host: String = ""

func _init(raw_data: PoolByteArray) -> void:
	var text: String = raw_data.get_string_from_utf8()
	var lines: Array = WebArrayHelper.to_array(text.split('\r\n'))
	var rq_line: Array = WebArrayHelper.to_array(lines.pop_front().split(' '))

	method = rq_line.pop_front().to_upper()
	uri = rq_line.pop_front()
	if uri.begins_with('/'):
		host = lines.pop_front().replace("Host: ", '')
	version = rq_line.pop_front()
	
	var header_string: String = ''
	for i in range(len(lines)):
		var line: String = lines.pop_front()
		if line.empty():
			break
		header_string += "%s\n" % line
	
	header = WebHeaders.new()
	header.from_header(header_string)
	body = PoolStringArray(lines).join('\n')

