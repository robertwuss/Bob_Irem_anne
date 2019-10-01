

import tobii_research as tr
import time
import argparse
import random
from osc4py3.as_eventloop import *
from osc4py3 import oscbuildparse

found_eyetrackers = tr.find_all_eyetrackers()

my_eyetracker = found_eyetrackers[0]
print("Address: " + my_eyetracker.address)
print("Model: " + my_eyetracker.model)
print("Name (It's OK if this is empty): " + my_eyetracker.device_name)
print("Serial number: " + my_eyetracker.serial_number)


osc_startup()
osc_udp_client("127.0.0.1", 12000, "tobiiSend")


def oscOut(gaze_left_eye):
	#gaze_left_eye = list(gaze_left_eye)
	
	print (gaze_left_eye)
	msg = oscbuildparse.OSCMessage("/test/me", None,(gaze_left_eye))
	osc_send(msg, "tobiiSend")
	osc_process()
	

def gaze_data_callback(gaze_data):
 
	gaze_left_eye=gaze_data['left_gaze_point_on_display_area']
	gaze_right_eye=gaze_data['right_gaze_point_on_display_area']
	oscOut(gaze_left_eye)

my_eyetracker.subscribe_to(tr.EYETRACKER_GAZE_DATA, gaze_data_callback, as_dictionary=True)
time.sleep(5)
my_eyetracker.unsubscribe_from(tr.EYETRACKER_GAZE_DATA, gaze_data_callback)












