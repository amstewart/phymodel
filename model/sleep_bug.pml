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
  do \
  :: 1 -> atomic { \
      if \
      :: mutex == 1 -> \
        mutex = 0; \
        break \
      :: else -> skip \
      fi \
    } \
  od

bit lock, delete, cs = 0;
bit sched = 1;

active proctype sleep_tid()	/* can run at any time */
{
    do 
    ::
    if :: sched == 0 -> skip;
    :: else 
 
    spin_lock(lock)
    cs = 1;

    sched = 0;
   //assert(delete == 0);
    cs = 0;
    delete = 1;

    spin_unlock(lock);

    delete = 0;

    fi
    od

}

init {
    run sleep_tid();
    run sleep_tid();
}
