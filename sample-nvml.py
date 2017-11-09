#!/usr/bin/python2

from pynvml import *

try:
    nvmlInit()
except NVMLError, err:
    print "Failed to initialize NVML: ", err
    print "Exiting..."
    os._exit(1)

print "Driver Version:", nvmlSystemGetDriverVersion()
deviceCount = nvmlDeviceGetCount()
for i in range(deviceCount):
  handle = nvmlDeviceGetHandleByIndex(i)
  print "Device", i, ":", nvmlDeviceGetName(handle)
  #get GPU temperature
  temperature = nvmlDeviceGetTemperature(handle, NVML_TEMPERATURE_GPU)
  print "Device", i, "Temperature: ", temperature
  #get GPU memory total
  totalMemory = nvmlDeviceGetMemoryInfo(handle).total
  print "Device", i, "TotalMemory: ", totalMemory
  #get GPU memory used
  usedMemory = nvmlDeviceGetMemoryInfo(handle).used
  print "Device", i, "UsedMemory: ", usedMemory

try:
    nvmlShutdown()
except NVMLError, err:
    print "Error shutting down NVML:", err
    os._exit(1)
