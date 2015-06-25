#The network Driver ATLANTIC component
########################################################################
#This component is reponsible to contact the (set of) network controller 
#and extract traffic flow information such as flow counters and flow 
#identifiers
#######################################################################

import os
import json
import math
import time
from collections import Counter

#global variables descriptors
flow_id = ( ("sw_id", 0), ("tp_src", 1), ("tp_dst", 2), ("nw_src", 3),("nw_dst", 4), ("nw_proto", 5), ("dl_src", 6), ("dl_dst", 7) )
flow_stats = ( ("pkt_count", 8), ("byte_count", 9), ("duration", 10) )
counters_index = 8

#get the index of the flow counter
def get_flow_counter_index():
	return statistics_index

#Get all rules (flow entries) in data plane
def get_all_flows(restIp):
	#get all flow tables:
	command = "curl -s http://%s/wm/core/switch/all/flow/json" % restIp
	command_output = os.popen(command).read()
	newFeatures = json.loads(command_output)
	#organize the information retrieved
	flows = dict()
	switches =  newFeatures.keys()
	for sw in switches:
		switchFeatures =  newFeatures[sw]
		for info in switchFeatures:
			if info["match"]["transportDestination"]==0:
				continue
			flows[( repr(sw),repr(info["match"]["transportSource"]), repr(info["match"]["transportDestination"]), repr(info["match"]["networkSource"]), repr(info["match"]["networkDestination"]), repr(info["match"]["networkProtocol"]), repr(info["match"]["dataLayerSource"]),  repr(info["match"]["dataLayerDestination"]))] = ( repr(info["packetCount"]), repr(info["byteCount"]), repr(info["durationSeconds"]) )
	return flows
