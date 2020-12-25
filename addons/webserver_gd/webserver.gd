extends Node

var _server: TCP_Server = TCP_Server.new()
var _connections: Array = []
var _routing: Dictionary = {}

func _ready() -> void:
	set_physics_process(false)


func is_running() -> bool:
	return _server.is_listening()


func listen(port: int = 8080) -> void:
	print("Started listening on port ", port, "...")
	_server.listen(port)
	set_physics_process(true)


func stop() -> void:
	print("Stopped listening...")
	_server.stop()
	set_physics_process(false)


func _connection_loop(debug: bool = false) -> void:
	if _server.is_connection_available():
		var connection: StreamPeerTCP = _server.take_connection()
		_connections.append([connection, []])
		print("Received new connection from: ", connection.get_connected_host(), ":", connection.get_connected_port())


func _request_loop(debug: bool = false) -> void:
	for i in range(len(_connections)):
		if _connections.size() <= i:
			break
		
		var c: Array = _connections[i]
		var connection: StreamPeerTCP = c[0]
		if !connection.is_connected_to_host():
			_connections.remove(i)
			continue
		
		var length: int = connection.get_available_bytes()
		if length > 0:
			var result: Array = connection.get_data(length)
			if result[0] != OK:
				push_error("Received error code: %s" % result[0])
				return
			
			c[1].append(WebRequest.new(result[1]))
			
			if debug:
				print("Received data (length: ", length, ") with error code ", result[0], ": ")
				print((result[1] as PoolByteArray).get_string_from_utf8())


func _response_loop() -> void:
	for c in _connections:
		var connection: StreamPeerTCP = c[0]
		for r in c[1]:
			var request: WebRequest = r as WebRequest
			var path: PoolStringArray = request.uri.split('/')
			path[0] = ''# todo fix pathing
			
			var route: String = path.join('/')
			
			var handled: bool = false
			for route_key in _routing.keys():
				if route.begins_with(route_key):
					var handler: Object = _routing[route_key]
					var method_signature: String = "web_%s" % request.method.to_lower()
					if handler.has_method(method_signature):
						var result: Array = handler.call(method_signature, route_key, route, request) # todo reduce
						if !result.empty():
							connection.put_data((result[0] as WebResponse).to_data())
							handled = true
							break
			
			if !handled:
				var response: WebResponse = WebResponse.new("HTTP/1.0", 501)
				response.body += "<h1>501 Service Not implemented</h1>"
				connection.put_data(response.to_data())
			
		connection.disconnect_from_host()



func _physics_process(delta: float) -> void:
	_connection_loop(false)
	_request_loop(false)
	_response_loop()
