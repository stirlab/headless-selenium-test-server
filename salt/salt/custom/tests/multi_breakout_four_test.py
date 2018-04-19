#!/usr/bin/env python3

import signal
import sys
import time
from selenium.common.exceptions import StaleElementReferenceException
from selenium.common.exceptions import WebDriverException
import test_common as common
import test_config as config
from user_map import user_map

session_map = {
  "webrtc-test-0.stirlab.net": {
    "join_number_1": 1,
    "join_number_2": 2,
    "join_number_3": 3,
    "join_number_4": 4,
    "mute": False,
  },
  "webrtc-test-1.stirlab.net": {
    "join_number_1": 1,
    "join_number_2": 2,
    "join_number_3": 3,
    "join_number_4": 4,
    "mute": True,
  },
  "webrtc-test-2.stirlab.net": {
    "join_number_1": 5,
    "join_number_2": 6,
    "join_number_3": 7,
    "join_number_4": 8,
    "mute": False,
  },
  "webrtc-test-3.stirlab.net": {
    "join_number_1": 5,
    "join_number_2": 6,
    "join_number_3": 7,
    "join_number_4": 8,
    "mute": True,
  },
  "webrtc-test-4.stirlab.net": {
    "join_number_1": 9,
    "join_number_2": 10,
    "join_number_3": 11,
    "join_number_4": 12,
    "mute": False,
  },
  "webrtc-test-5.stirlab.net": {
    "join_number_1": 9,
    "join_number_2": 10,
    "join_number_3": 11,
    "join_number_4": 12,
    "mute": True,
  },
  "webrtc-test-6.stirlab.net": {
    "join_number_1": 13,
    "join_number_2": 14,
    "join_number_3": 15,
    "join_number_4": 16,
    "mute": False,
  },
  "webrtc-test-7.stirlab.net": {
    "join_number_1": 13,
    "join_number_2": 14,
    "join_number_3": 15,
    "join_number_4": 16,
    "mute": True,
  },
  "webrtc-test-8.stirlab.net": {
    "join_number_1": 17,
    "join_number_2": 18,
    "join_number_3": 19,
    "join_number_4": 20,
    "mute": False,
  },
  "webrtc-test-9.stirlab.net": {
    "join_number_1": 17,
    "join_number_2": 18,
    "join_number_3": 19,
    "join_number_4": 20,
    "mute": True,
  },
}

def usage():
  print("Usage: %s" % sys.argv[0])
  print("Configuration variables set in test_config.py")

if len(sys.argv) > 2:
  usage()

data = None
if len(sys.argv) > 1:
    data = sys.argv[1]

def exit_callback():
  try:
    driver1.quit()
    driver2.quit()
    driver3.quit()
    driver4.quit()
  except NameError:
    print("No driver instance to close")
common.setup_signal_handlers(exit_callback)

hostname = common.hostname_slug()

user_id_1 = None
user_id_2 = None
user_id_3 = None
user_id_4 = None
user_id_1_session = None
user_id_2_session = None
user_id_3_session = None
user_id_4_session = None
if hostname in user_map and hostname in session_map:
  user_id_1 = user_map[hostname]["user_id_1"]
  user_id_1_session = session_map[hostname]["join_number_1"]
  user_id_2 = user_map[hostname]["user_id_2"]
  user_id_2_session = session_map[hostname]["join_number_2"]
  user_id_3 = user_map[hostname]["user_id_3"]
  user_id_3_session = session_map[hostname]["join_number_3"]
  user_id_4 = user_map[hostname]["user_id_4"]
  user_id_4_session = session_map[hostname]["join_number_4"]
else:
  print("ERROR: %s does not map to a valid user ID or session" % hostname)
  sys.exit(1)

options = common.setup_chrome()
driver1 = common.make_driver(options)
driver2 = common.make_driver(options)
driver3 = common.make_driver(options)
driver4 = common.make_driver(options)

main_room_url_1 = common.make_main_room_url(user_id_1, data)
main_room_url_2 = common.make_main_room_url(user_id_2, data)
main_room_url_3 = common.make_main_room_url(user_id_3, data)
main_room_url_4 = common.make_main_room_url(user_id_4, data)

try:
  common.shape_traffic(hostname)
  driver1.get(main_room_url_1)
  driver2.get(main_room_url_2)
  driver3.get(main_room_url_3)
  driver4.get(main_room_url_4)

  while True:
    if not common.global_pause:
      common.manage_main_room(driver1, True)
      common.manage_main_room(driver2, True)
      common.manage_main_room(driver3, True)
      common.manage_main_room(driver4, True)
      common.manage_breakout(driver1, user_id_1_session, session_map[hostname]["mute"])
      common.manage_breakout(driver2, user_id_2_session, session_map[hostname]["mute"])
      common.manage_breakout(driver3, user_id_3_session, session_map[hostname]["mute"])
      common.manage_breakout(driver4, user_id_4_session, session_map[hostname]["mute"])
    time.sleep(config.page_wait_time)

except WebDriverException as e:
  common.clear_traffic_shaping()
  print("ERROR: Webdriver error: %s" % e)

# Wait for SIGINT.
signal.pause()
