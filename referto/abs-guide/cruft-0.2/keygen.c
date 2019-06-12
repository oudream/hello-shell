/*************************************************************************/
/*                              keygen                                   */
/*          CREATES RANDOM CODE.KEY FILE FOR BINARY FILE ENCODING        */
/*                   range of random numbers 0 - 255                     */
/*                                                                       */
/*                              author:                                  */
/*                           Mendel Cooper                               */
/*                     <thegrendel@theriver.com>                         */
/*************************************************************************/

#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <sys/types.h>
#include <sys/stat.h>
#include "cruft.h"


int main( int argc, char **argv )
{
   long len;
   char fname [FNAMELEN];

	 if( argc < ARGCOUNT || access ( *( argv + 1 ) , R_OK ) )
		 len = DEFAULTKEYSIZE;
         else				 
                 len = filesize( *(argv + 1) );

	 if( argc >= ARGCOUNT && isdigit( **( argv + 1 ) ) )
				 len = atol( *( argv + 1 ) );
	 
	 CREATEFILENAME(fname);

	 printf( "\n\nCreating a KEY file \"%s\" %ld bytes long.\n",
                  fname, len );
	 create_file( fname, len );

	 return ( 0 );


}

int create_file( char *filename, long int count )
{
   register int r;
   long n;
   time_t secs;
   unsigned seed;
   FILE *fp;
  

         secs = time( NULL );
         seed = secs % U_MAX;


	 srand( seed );

	 if( NULL == ( fp = fopen( filename, "w" ) ) )
	   {
	   printf( "\nCannot open file %s\n", filename );         
	   exit ( FILE_ERR );
	   }


      if( setvbuf( fp, NULL, _IOFBF, BUFFERSIZE ) )
         exit( FILE_ERR );

	 for( n = 0; n < count; n++ )
	    {
	    r = random() % RANGE;
	    /* Whoops, random() not really all that random.*/
	    fputc( r, fp );
	    }

	 fclose( fp );
	 
	 chmod( filename, 00600 );  /*Owner access only to key-file.*/ 

	 return ( n );

}


long filesize( char *filename )
{
	
   int filehandle;
   long fsize;
   FILE *fp;
   struct stat fstatistics;
		         
      fp = fopen( filename, "r" );
      filehandle = fileno( fp );      
				
      if( !fstat( filehandle, &fstatistics ) )
           fsize = fstatistics.st_size;
      else
           fsize = -1L;
		    
      fclose( fp );
						         
      return( fsize );
}

