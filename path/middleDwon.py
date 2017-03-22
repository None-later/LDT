#!/usr/bin/env python
# This is my first script.


from pymouse import PyMouse
from pykeyboard import PyKeyboard

m = PyMouse()
k = PyKeyboard()

x, y = m.position()
m.press(x, y, 3)




# from pymouse import PyMouse

#m = PyMouse()
#m.position() #gets mouse current position coordinates
#m.move(1,1)
# m.click(1,1) #the third argument "1" represents the mouse button
#m.press(1,1) #mouse button press
#m.release(x,y) #mouse button release
