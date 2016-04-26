import os
import json
class firewall:
	def __init__(self, switches, ip):
		command = "curl -s http://%s/wm/firewall/module/enable/json" % (ip)
		command_output = os.popen(command).read()
		parsed_output = json.loads(command_output)

		#ENABLE ALL TRAFFIC IN THE NETWORK
		for sw in switches:
			command ="curl -X POST -d '{\"switchid\": \""+ sw +"\"}' http://localhost:8080/wm/firewall/rules/json"	
			command_output = os.popen(command).read()
			parsed_output = json.loads(command_output)


	def block_switch(self, data_to_block):
		data = data_to_block.split(" ")
		sw = data[0].replace("u'", "")
		sw = sw.replace("'", "")
		command ="curl -X POST -d '{\"switchid\": \""+ sw +"\", \"action\": \"DENY\"}' http://localhost:8080/wm/firewall/rules/json"	
		#print command
		command_output = os.popen(command).read()
		parsed_output = json.loads(command_output)

	def unable_firewall():
		for sw in switches:
			command ="curl -X POST -d '{\"switchid\": \""+ sw +"\"}' http://localhost:8080/wm/firewall/rules/json"	
			command_output = os.popen(command).read()
			parsed_output = json.loads(command_output)	
