extends LineEdit
@export var player_num = ""
@onready var text_label = get_node("../Label2")
var http_request: HTTPRequest
var api_key = "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"  # Replace with your actual API key
var url = "https://api-inference.huggingface.co/models/meta-llama/Llama-3.2-3B-Instruct"  # Replace with your chosen model endpoint
# Called when the node enters the scene tree for the first time.
var prompt_input = ""
var tank_set_1 = ["Sneak", ["1", "1"], ["B", "D"], ["A", "C"], ["D", "A"], ["B", "B"], ["A", "D"], ["C", "C"]]
var tank_set_2 = ["Surround", ["2", "1"], ["C", "A"], ["D", "D"], ["A", "B"], ["C", "C"], ["B", "A"], ["D", "B"]]
var tank_set_3 = ["Right", ["1", "2"], ["B", "B"], ["A", "A"], ["D", "C"], ["C", "D"], ["A", "B"], ["B", "C"]]
var tank_set_4 = ["Left", ["2", "2"], ["D", "C"], ["C", "A"], ["A", "D"], ["B", "B"], ["D", "A"], ["C", "D"]]
var tank_set_5 = ["Sneak", ["1", "2"], ["B", "C"], ["D", "D"], ["A", "A"], ["C", "B"], ["D", "C"], ["B", "A"]]
var tank_set_6 = ["Surround", ["2", "1"], ["C", "D"], ["A", "B"], ["B", "C"], ["D", "A"], ["C", "D"], ["A", "B"]]


func _ready():
	print(get_tree())
	text_label.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_text_submitted(new_text: String) -> void:
	prompt_input = new_text
	hide()
	text_label.show()
	
	# Create and add the HTTPRequest node
	http_request = HTTPRequest.new()
	add_child(http_request)
	http_request.connect("request_completed", Callable(self, "_on_request_completed"))
	
	# Prepare your prompt and JSON data
	var prompt = "I have a tank game, tanks have different bodies and turrets. The user will give an idea of how they want their group of 6 tanks to be. Your job is to pick what kinds of tanks they will have. Here are the types of tank bodies: \"A\" which has medium speed and is balanced. \"B\" which is fast and sneaky. \"C\" which is very strong and powerful. \"D\" has medium armour and is a bit faster. Here are the turret types: \"A\" has medium damage, range, and fire rate. \"B\" has long range, high damage, and slow firing. \"C\" has smaller range, slower fire rate, and lots of daamge. \"D\" has fast fire rate, small range, and small damage. Also pick a strategy: \"Sneak\" is more stealthy and attacks from behind. \"Surround\" is aggressive and attacks from all sides. \"Right\" puts tanks on the right side. \"Left\" puts tanks on the left. Give me six tanks and the strategy in this format, with the strategy included in the array. The body color is \"1\" if it is faster but weaker and \'2\" if stronger and slower. The turret is \"1\" if it has smaller range but faster fire rate and \"2\" for slower fire rate and longer range. Respond only with a single array formatted as given.  [\"strategy\",[\"body_color\",\"turret_color\"][\"body_class1\",\"turret_class1\"],[\"body_class2\",\"turret_class2\"],[\"body_class3\",\"turret_class3\"],[\"body_class4\",\"turret_class4\"],[\"body_class5\",\"turret_class5\"],[\"body_class6\",\"turret_class6\"]] Here is what the user wants: " + new_text
	var data = {
		"inputs": prompt
	}
	# Set up the request headers
	var headers = [
		"Authorization: Bearer " + api_key,
		"Content-Type: application/json"
	]
	# Convert the data dictionary to a JSON string
	var json_data = JSON.stringify(data)
	# The signature for HTTPRequest.request() in Godot 4 is:
	# request(url: String, custom_headers: Array, method: int, request_data: String, timeout_sec: float = 10.0, ssl_validate_domain: bool = true)
	# Use HTTPClient.METHOD_POST (an integer constant) for the method parameter.
	var error = http_request.request(url, headers, HTTPClient.METHOD_POST, json_data)
	
	if error != OK:
		print("Failed to send request, error code: ", error)
	
func _on_request_completed(result: int, response_code: int, headers: Array, body: PackedByteArray) -> void:
	if response_code == 200:
		var json = JSON.new()
		var err = json.parse(body.get_string_from_utf8())
		if err == OK:
			var response = json.get_data()
			if response is Array and response.size() > 0:
				var generated_text = response[0].get("generated_text", "No generated text")
				print("Generated text: ", generated_text)
				# Extract only the array from the generated text
				var start_index = generated_text.find("[")
				var end_index = generated_text.rfind("]")
				
				if start_index != -1 and end_index != -1:
					var clean_json_string = generated_text.substr(start_index, end_index - start_index + 1)

					# Parse the cleaned JSON string
					var clean_json = JSON.new()
					var parse_err = clean_json.parse(clean_json_string)

					if parse_err == OK:
						var extracted_array = clean_json.get_data()
						
				if player_num == "1":
					LlmResources.llm_response1=generated_text
				else:
					LlmResources.llm_response2=generated_text
				get_tree().change_scene_to_file("res://player2_input.tscn")
			else:
				print("Unexpected response structure: ", response)
		else:
			print("Error parsing JSON, error code: ", err)
	else:
		print(response_code)
	var tank_sets = [tank_set_1, tank_set_2, tank_set_3, tank_set_4, tank_set_5, tank_set_6]
	var chosen_tank_set = tank_sets[randi() % tank_sets.size()]
	if player_num == "1":
			LlmResources.llm_response1=chosen_tank_set
			get_tree().change_scene_to_file("res://World.tscn")
	else:
			LlmResources.llm_response2=chosen_tank_set
	print(LlmResources.llm_response1)
	print(LlmResources.llm_response2)
