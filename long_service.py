import sys
import time

while True:
    print("Stdout message between sleeps...")
    print("Stderr message between sleeps...", file=sys.stderr)
    time.sleep(2)
