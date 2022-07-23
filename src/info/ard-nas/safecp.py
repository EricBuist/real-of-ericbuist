#!/usr/bin/python3

from select import select;
import time
import sys

if len(sys.argv) != 4:
    print("Usage: record.py src-device target-file time-in-seconds")
    exit(1)

srcFile = sys.argv[1]
targetFile = sys.argv[2]
recordingTime = int(sys.argv[3])

src = open(srcFile, "rb")
target = None

targetBase = targetFile
targetCount = 1

startTime = time.time()
done = False
while not done:
    timeout=1
    if target == None:
       timeout=10
    res = select([src], [], [], timeout)
    if len(res[0]) == 1:
        buf = src.read1(4096)
        if len(buf) == 0:
            done = True
        else:
            if target == None:
                target = open(targetFile, "wb")
            target.write(buf)
    else:
        print("Read failure encountered, resetting input")
        src.close()
        if target != None:
            target.close()
            target = None
            idx = targetBase.rfind('.')
            if idx == -1:
                targetFile = targetBase + count
            else:
                targetFile = targetBase[0:idx] + "-" + str(targetCount) + targetBase[idx:]
            targetCount = targetCount + 1
        src = open(srcFile, "rb")
    copyTime = time.time() - startTime
    if copyTime &gt;= recordingTime:
        done = True
            
src.close()
if target != None:
    target.close()
