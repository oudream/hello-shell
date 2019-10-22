import time

from threading import Thread, Event, Timer


class MyThread(Thread):
    def __init__(self, event):
        Thread.__init__(self)
        self.stopped = event

    def run(self):
        while not self.stopped.wait(0.5):
            print("my thread: ", time.localtime(time.time()))
            # call a function


stopFlag = Event()
thread = MyThread(stopFlag)
thread.start()


# this will stop the timer
# stopFlag.set()

def stop_thread():
    # stopFlag.set()
    print(("hello %s\n" % time.localtime(time.time())))


Timer(120.0, stop_thread, []).start()
