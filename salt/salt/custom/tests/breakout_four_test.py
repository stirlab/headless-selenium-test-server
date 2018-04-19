#!/usr/bin/env python3

import signal
import sys
import time
from selenium.common.exceptions import StaleElementReferenceException
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
if hostname in user_map:
  user_id_1 = user_map[hostname]["user_id_1"]
  user_id_1_session = 1
  user_id_2 = user_map[hostname]["user_id_2"]
  user_id_2_session = 2
  user_id_3 = user_map[hostname]["user_id_3"]
  user_id_3_session = 3
  user_id_4 = user_map[hostname]["user_id_4"]
  user_id_4_session = 4
else:
  print("ERROR: %s does not map to a valid user ID" % hostname)
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
      common.manage_breakout(driver1, user_id_1_session)
      common.manage_breakout(driver2, user_id_2_session)
      common.manage_breakout(driver3, user_id_3_session)
      common.manage_breakout(driver4, user_id_4_session)
    time.sleep(config.page_wait_time)

except WebDriverException as e:
  common.clear_traffic_shaping()
  print("ERROR: Webdriver error: %s" % e)

# Wait for SIGINT.
signal.pause()
