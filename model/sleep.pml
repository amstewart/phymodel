/*

 */

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

bit lock, sched, delete = 0;

active proctype sleep_tid1()	/* can run at any time */
{
    do 
    ::
        if :: sched == 0 -> goto sink;
        fi

        spin_lock(lock)

        sched = 0;
        assert(delete == 0)
        delete = 1;

        spin_unlock(lock);

        assert(0)
    od;

    sink:
}

active proctype sleep_tid2()	/* can run at any time */
{
    do 
    ::
        if :: sched == 0 -> goto sink;
        fi

        spin_lock(lock)

        sched = 0;
        assert(delete == 0)
        delete = 1;

        spin_unlock(lock);
    od;

    sink:
}
