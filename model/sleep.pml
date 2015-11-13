/*

 */

#include "lock.h"

bit lock, sched, delete;

active proctype sleep_tid()	/* can run at any time */
{
    do 
    ::
s0:   /*** STATE 0 ***/
        
        if :: sched == 0 -> goto sink;
        :: else goto s1;
        fi

s1:
        spin_lock(lock)
s2:


s3:

        sched = 0;
        delete = 1;

s4:
        spin_unlock(lock);


sink: 
    od;

}
