import board
import neopixel
import RPi.GPIO as GPIO
import time

# set GPIO Pin mode  
GPIO.setmode(GPIO.BCM)

# define BCM Pin number of each componeant
GPIO.setup(12, GPIO.OUT) # LED
GPIO.output(12, True)

# define neopixel object
pixels = neopixel.NeoPixel(board.D12, 1) # 1: number of Neopixel

for i in range(3):
	pixels[0] = (255,0,0)
	time.sleep(0.25)
	pixels[0] = (0,255,0)
	time.sleep(0.25)
	pixels[0] = (0,0,255)
	time.sleep(0.25)
	pixels[0] = (0,0,0)

