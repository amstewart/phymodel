/*

 */

mtype = { locked, unlocked
    sched, sleep, deleted};

show mtype tid_state = sched; //can be sched or sleep (!sched) or deleted
show mtype ac_state = sched; //can be sched or sleep (!sched) or deleted
show mtype txq_state = sched; //can be locked or unlocked

active proctype sleep_tid()	/* can run at any time */
{
    //locks txq 
    atomic {txq_state == unlocked -> txq_state = locked}

    //sleep check, if sleeping, break out
    if 
    :: tid_state == sleep  -> atomic (txq_state = unlocked); break;
    fi


    /* critcal section and deletion */
    tid = sleep;

    atomic {txq_state = unlocked }

}

//lock txq

