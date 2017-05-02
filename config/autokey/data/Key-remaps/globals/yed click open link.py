# F2
#keyboard.send_keys("<f2>")

# Ctrl+c
#keyboard.send_keys("<ctrl>+c")
#keyboard.send_keys("<ctrl>+c")
#keyboard.send_keys("<ctrl>+c")

# grep clipboard for http, open ff with grep output
system.exec_command('getclip  | grep http | xargs firefox', getOutput=True)