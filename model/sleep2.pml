#define spin_lock(mutex) \
  do \
  :: 1 -> atomic { \
      if \
      :: mutex == 0 -> \
        mutex = 1; \
        break \
      :: else -> skip \
      fi \
    } \
  od

#define spin_unlock(mutex) \
  mutex = 0

bit lock, sched, delete, delete1, delete2;

active proctype sleep_tid1()	/* can run at any time */
{
    do 
        spin_lock(lock)

        sched = 0;
        assert(delete == 0);
        delete = 1;
        //delete1 = 1;

        spin_unlock(lock);
        break;
    od;
}

active proctype sleep_tid2()	/* can run at any time */
{
    do sched == 1 ->
        spin_lock(lock)

        sched = 0;
        assert(delete == 0);
        delete = 1;
        //delete2 = 1;

        spin_unlock(lock);
        break;
    do;
}

proctype monitor()
{
    assert(!(delete1 == 1 && delete2 == 1));
}

init {
    run sleep_tid1();
    run sleep_tid2();
    //run monitor();
}
