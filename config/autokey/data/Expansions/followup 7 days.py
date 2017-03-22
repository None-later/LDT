date = system.exec_command("date +'%Y-%m-%d' -d '+7 days'", getOutput=True)
keyboard.send_keys("followup:%s" % date)
