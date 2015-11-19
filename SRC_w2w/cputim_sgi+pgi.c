/* wien2wannier/SRC_w2w/cputim_sgi+pgi.c                   	*
 *                                                         	*
 * $Id: cputim_sgi+pgi.c 385 2015-06-01 13:08:18Z assmann $	*/

#include <sys/types.h>
#include <sys/times.h>
#include <sys/time.h>
#include <stdio.h>
#include <unistd.h>

void cputim_(dsec)
double *dsec;
{
      struct tms buffer;

      times(&buffer);
      *dsec = (double)buffer.tms_utime/100.0;
/*      fprintf(stderr,"inside cputim: %lf\n",dsec);*/
}


void walltim_(dsec)
double * dsec;
{       struct timeval tv;
        struct timezone tz;
        gettimeofday(&tv, &tz);
        *dsec = (double) tv.tv_sec + tv.tv_usec/1000000.0;
}


/* Local Variables:                           */
/* End:                                       */

/* Time-stamp: <2015-05-23 20:37:20 elias>    */
