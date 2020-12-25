class_name StaticRoute
extends Resource

var local_path: String = ""

func _init(path: String) -> void:
	local_path = path

# https://www.tutorialspoint.com/http/http_header_fields.htm
func web_get(route: String, relative: String, request: WebRequest) -> Array:
	var path: String = relative.trim_prefix(route)
	var file: File = File.new()
	
	if !file.file_exists(local_path.plus_file(path)):
		if path.empty():
			path += '/'
		
		if path.ends_with('/'):
			path += "index"
		
		if !path.ends_with('.html'):
			path += ".html"
	
	if !file.file_exists(local_path.plus_file(path)):
		var response: WebResponse = WebResponse.new("HTTP/1.0", 404)
		response.body += "<h1>404 File not found</h1>"
		return [response]
	
	file.open(local_path.plus_file(path), File.READ)
	var response: WebResponse = WebResponse.new("HTTP/1.1", 200)
	response.body += file.get_as_text()
	
#	response.headers.add_field("Content-Type", ContentTypeHeader.new("text/html"))
	var date_header: DateHeader = DateHeader.new()
	date_header.date = OS.get_datetime(true)
	response.headers.add_field("Date", date_header)
	file.close()
	return [response]
