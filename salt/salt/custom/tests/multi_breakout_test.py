#!/usr/bin/env python3

import signal
import socket
import sys
import time
from selenium.common.exceptions import StaleElementReferenceException
from selenium.common.exceptions import WebDriverException
import test_common as common
import test_config as config
from user_map import user_map

session_map = {
  "webrtc-test.stirlab.local": {
    "join_number": 1,
    "mute": False,
  },
  "webrtc-test-base.stirlab.net": {
    "join_number": 1,
    "mute": False,
  },
  "webrtc-test-0.stirlab.net": {
    "join_number": 1,
    "mute": False,
  },
  "webrtc-test-1.stirlab.net": {
    "join_number": 1,
    "mute": True,
  },
  "webrtc-test-2.stirlab.net": {
    "join_number": 2,
    "mute": False,
  },
  "webrtc-test-3.stirlab.net": {
    "join_number": 2,
    "mute": True,
  },
  "webrtc-test-4.stirlab.net": {
    "join_number": 3,
    "mute": False,
  },
  "webrtc-test-5.stirlab.net": {
    "join_number": 3,
    "mute": True,
  },
  "webrtc-test-6.stirlab.net": {
    "join_number": 4,
    "mute": False,
  },
  "webrtc-test-7.stirlab.net": {
    "join_number": 4,
    "mute": True,
  },
  "webrtc-test-8.stirlab.net": {
    "join_number": 5,
    "mute": False,
  },
  "webrtc-test-9.stirlab.net": {
    "join_number": 5,
    "mute": True,
  },
}

def usage():
  print("Usage: %s" % sys.argv[0])
  print("Configuration variables set in test_config.py")

if len(sys.argv) != 1:
  usage()

def exit_callback():
  try:
    driver.quit()
  except NameError:
    print("No driver instance to close")
common.setup_signal_handlers(exit_callback)

hostname = socket.gethostname()

user_id = None
if hostname in user_map:
  user_id = user_map[hostname]["user_id_1"]
else:
  print("ERROR: %s does not map to a valid user ID" % hostname)
  sys.exit(1)

options = common.setup_chrome()
driver = common.make_driver(options)

main_room_url = common.make_main_room_url(user_id)

try:
  common.shape_traffic(hostname)
  driver.get(main_room_url)
  while True:
    if not common.global_pause:
      common.manage_main_room(driver, True)
      common.manage_breakout(driver, session_map[hostname]["join_number"], session_map[hostname]["mute"])
    time.sleep(config.page_wait_time)

except WebDriverException as e:
  common.clear_traffic_shaping()
  print("ERROR: Webdriver error: %s" % e)

# Wait for SIGINT.
signal.pause()
