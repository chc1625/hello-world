#! /usr/bin/python2
import multiprocessing
import time

def task(taskname,something):
# do something
        print something + str(taskname)
        time.sleep(3)
        return taskname

def main(): 
        pool = multiprocessing.Pool()
        cpus = multiprocessing.cpu_count()
        results = [] 
        print 'tasks starting'
        for i in xrange(0, 10):
                result = pool.apply_async(task, args=(i,'xxx'))
                results.append(result)
                print str(i)+' tasks started'
        pool.close()
        pool.join()
        print 'task finished'
        for result in results:
                print(result.get())

if __name__ == '__main__':
        main()
