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
    driver.quit()
  except NameError:
    print("No driver instance to close")
common.setup_signal_handlers(exit_callback)

hostname = common.hostname_slug()

user_id = None
if hostname in user_map:
  user_id = user_map[hostname]["user_id_1"]
else:
  print("ERROR: %s does not map to a valid user ID" % hostname)
  sys.exit(1)

options = common.setup_chrome()
driver = common.make_driver(options)

main_room_url = common.make_main_room_url(user_id, data)

try:
  common.shape_traffic(hostname)
  driver.get(main_room_url)
  common.wait_for_main_room_mute(driver)

except WebDriverException as e:
  common.clear_traffic_shaping()
  print("ERROR: Webdriver error: %s" % e)

# Wait for SIGINT.
signal.pause()
