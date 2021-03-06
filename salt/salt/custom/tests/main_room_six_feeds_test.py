#!/usr/bin/env python3

import signal
import sys
import time
from selenium.common.exceptions import WebDriverException
import test_common as common
import test_config as config
from user_map import user_map

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
    driver5.quit()
    driver6.quit()
  except NameError:
    print("No driver instance to close")
common.setup_signal_handlers(exit_callback)

hostname = common.hostname_slug()

user_id_1 = None
user_id_2 = None
user_id_3 = None
user_id_4 = None
user_id_5 = None
user_id_6 = None
if hostname in user_map:
  user_id_1 = user_map[hostname]["user_id_1"]
  user_id_2 = user_map[hostname]["user_id_2"]
  user_id_3 = user_map[hostname]["user_id_3"]
  user_id_4 = user_map[hostname]["user_id_4"]
  user_id_5 = user_map[hostname]["user_id_5"]
  user_id_6 = user_map[hostname]["user_id_6"]
else:
  print("ERROR: %s does not map to a valid user ID" % hostname)
  sys.exit(1)

options = common.setup_chrome()
driver1 = common.make_driver(options)
driver2 = common.make_driver(options)
driver3 = common.make_driver(options)
driver4 = common.make_driver(options)
driver5 = common.make_driver(options)
driver6 = common.make_driver(options)

main_room_url_1 = common.make_main_room_url(user_id_1, data)
main_room_url_2 = common.make_main_room_url(user_id_2, data)
main_room_url_3 = common.make_main_room_url(user_id_3, data)
main_room_url_4 = common.make_main_room_url(user_id_4, data)
main_room_url_5 = common.make_main_room_url(user_id_5, data)
main_room_url_6 = common.make_main_room_url(user_id_6, data)

try:
  common.shape_traffic(hostname)
  driver1.get(main_room_url_1)
  driver2.get(main_room_url_2)
  driver3.get(main_room_url_3)
  driver4.get(main_room_url_4)
  driver5.get(main_room_url_5)
  driver6.get(main_room_url_6)
  common.wait_for_main_room_mute(driver1)
  common.wait_for_main_room_mute(driver2)
  common.wait_for_main_room_mute(driver3)
  common.wait_for_main_room_mute(driver4)
  common.wait_for_main_room_mute(driver5)
  common.wait_for_main_room_mute(driver6)

except WebDriverException as e:
  common.clear_traffic_shaping()
  print("ERROR: Webdriver error: %s" % e)

# Wait for SIGINT.
signal.pause()
