#
#Module that monitorates all flow existing in the network accordingly with the monitoration modules
#
from network_manager import *
from entropy import *
import rpy2.robjects as ro
import subprocess
import os
import re
import sys

def monitoring(maliciousModel):
	snapshot = 1
	entropy_sum = 0
	entropy_squared_sum = 0
	entropy_mean = 0
	entropy_sd = 0 #standard deviation
	while (True):
		#polling the network to find all flows that are stored in the network
		flows = get_all_flows("192.168.56.101:8080") #all switches
		print len(flows)

		#Save these statistics to R use
		save_statistics(flows.values(), snapshot)
		snapshot = snapshot + 1
		
		#determines the entropy
		entropy = network_entropy(flows, 0)
		print network_entropy(flows,0), ";",network_entropy(flows, 1),";",network_entropy(flows, 2),";",network_entropy(flows, 3),";",network_entropy(flows, 4),";",network_entropy(flows, 5),";",network_entropy(flows, 6),";",network_entropy(flows, 7), "\n"
		with open("sampleText.txt", "a") as myfile:
   			 myfile.write(repr(snapshot) + "," + repr(entropy)+ "\n")
		

		#test if there is entropy change:
		entropy_sum = entropy_sum + entropy
		entropy_squared_sum  = entropy_squared_sum + entropy*entropy
		entropy_mean = float(entropy_sum) / float(snapshot)
		entropy_sd = float(snapshot * entropy_squared_sum - (entropy_sum)*(entropy_sum) ) / float(snapshot*(snapshot-1))
		
		#print "Mean:",entropy_mean
		#print "Sd",entropy_sd
		if entropy > (entropy_mean + entropy_sd) or entropy < (entropy_mean - entropy_sd):
			print "Anomaly!!!!!!"
			#call filter mode



		#classify all flow with a set of machine learning algorithms
		#> Support Vector Machines:
		if sys.argv[1] == "svm":
			command = "cd machine_learning; R --slave -f svm.R"
			command_output = os.popen(command).read()
			command_output = re.sub("[0-9]", "",command_output)
			command_output = re.sub(" ", "",command_output)
			command_output = re.sub("\n", "",command_output)
			print command_output,"\n"
			#list(x) transforma a string x em uma lista or access x[3] to the 3 character 
			print "---------------"
		#classification with naive Bayes
		elif sys.argv[1] == "nb":
			command = "cd machine_learning; R --slave -f naiveBayes.R"
			command_output = os.popen(command).read()
			command_output = re.sub("[0-9]", "",command_output)
		        command_output = re.sub(" ", "",command_output)
		        command_output = re.sub("\n", "",command_output)
		        command_output = re.sub("\[", "",command_output)
		        command_output = re.sub("\]", "",command_output)
		        print command_output,"\n"
		elif sys.argv[1] == "km":
			command = "cd machine_learning; R --slave -f optimalKValue.R"
			command_output = os.popen(command).read()
			print "Please look at file 'wssK.pdf' and choose a properly K value"
			k = raw_input("k value:") #wait to plot with k information
			command = "cd machine_learning; R --slave -f kmeans.R --args 20"
			command_output = os.popen(command).read()
			print "kmeans clustering saved in 'kmeansClustering.pdf'"
	 		print command_output,"\n"

		elif sys.argv[1] == "kmd":
			command = "cd machine_learning; R --slave -f kmedoids.R"
			command_output = os.popen(command).read()
			print command_output,"\n"
		
		elif sys.argv[1] == "na":
			print "The network is running... no action specified"
		else:
			print "No valid action specified. System will turn off..."
			GUI_print_actions()
			sys.exit()

		time.sleep(2)


def save_statistics(statistics, num):
	#file_statistics = open("./machine_learning/flow_features" +repr(num) + ".csv", "w")
	file_statistics = open("./machine_learning/flow_features.csv", "w")
	file_statistics.write("packetCount; byteCount; duration\n")
	for data in statistics:
		data_char = repr(data)
		data_char = data_char.replace("(", "")
		data_char = data_char.replace(")", "")
		data_char = data_char.replace("'", "")
		data_char = data_char.replace(",", ";")
		data_char = data_char + "\n"
		file_statistics.write(data_char)
		
	file_statistics.close()

def GUI_print_actions():
	print "Usage: python flowManager.py [action]"
	print "Actions available:"
	print "svm -> to classify flows with Support Vetor Machine"
	print "nb -> to classify flows with Naive Bayes"
	print "na -> no action, just generate traffic in network"
	print "km -> kmeans clusterization"
	print "kmd -> kmedoids clusterization"

def is_abnormal_entropy(entropy, entropy_mean, entropy_standard_deviation):
	#verify if the entropy is abnormal
	if entropy > entropy_mean + entropy_standard_deviation and entropy < entropy_mean - entropy_standard_deviation:
		return False
	else:
		return True

#def filterMode(malicious_flows):




if __name__ == "__main__":	
	if len(sys.argv) < 2:
		print "ERROR, no monitoring action specified"
		GUI_print_actions()
	else:
		#run the entropy graphic to show entropy changes to user
		open("sampleText.txt", 'w').close()		
		subprocess.call('python plotEntropy.py &', shell=True)
		#open the malicious model
		maliciousModel = open("./machine_learning/database.csv", "r").readlines()
		maliciousModel.sort() # to enable effient query for malicious samples 
		#run the monitoring system
		monitoring(maliciousModel)
