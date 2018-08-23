/*****************************************************************************/
/*                                   Cruft                                   */
/*                          File Encryption Package                          */
/*                                                                           */
/*                                  author:                                  */
/*                               Mendel Cooper                               */
/*                        <thegrendel@theriver.com>                          */
/*****************************************************************************/


#include <unistd.h>
#include <stdio.h>
#include <ctype.h>
#include <stdlib.h>
#include <string.h>
#include "cruft.h"




int main( int argc, char **argv )
{
   char fname [FNAMELEN],
        tname [FNAMELEN];
     
      if( argc < ARGCOUNT )
          strcpy( fname, NULLFILE );  /***Default to stdin.***/
      else
	  {
          strcpy( fname, *(argv+1) );

           if( access( fname, R_OK ) )
               {
               printf( "\n\nFile \"%s\" not readable!\n\n", fname );
               exit( INVOCATION_ERROR );
               }	  
	  }
  
     
     if( argc > ARGCOUNT ) 
	 strcpy( tname, *(argv+2) );
     else
	 strcpy( tname, NULLSTRING ); /*No target file, then null string.*/
      
      if( !is_encrypted( fname ) )
          {    
          write_marker( tname );
	  code( ENCODE, fname, tname );
	  }
      else
          code( DECODE, fname, tname );
      
   
   return ( 0 );

}




long code( Codeflag Operation, char *Filename, char *targetf )
{

   register int c;
   register int ck;
   int t = FALSE;
   long flength,
        number = 0L;  /* Number of characters operated on. */
   char Fname [FNAMELEN],
        keyfilename [FNAMELEN];
   Boolean isfile;

   FILE *ptxt,
        *codekey,
        *fptr,
        *tptr;

      if( !strcmp( Filename, NULLFILE ) )
	      isfile = False;
      else
	      isfile = True;
      

	CREATEFILENAME(keyfilename);

   if( NULL == ( codekey = fopen( keyfilename, "rb" ) ) )
          {
          printf( "\nKey file not accessible!\n" );
          exit ( FILE_ERR );
          }
   if( setvbuf( codekey, NULL, _IOFBF, BUFFERSIZE ) )
	 {
         printf( "\nCan't set buffer up for key file!\n" );
         exit( FILE_ERR );
	 }
         

      if( isfile )
          {		      
          if( NULL == ( ptxt = fopen( Filename, "rb" ) ) )
              {
              printf( "\nPlain text file not accessible!\n" );
              exit( FILE_ERR );
	      }
          if( setvbuf( ptxt, NULL, _IOFBF, BUFFERSIZE ) )
	      {
              printf( "\nCan't set up buffer for plain text file!\n" );
              exit( FILE_ERR );
	      }
	  }

      if( *targetf )
          {  
          t = TRUE;

          if( NULL == ( tptr = fopen( targetf, "ab" ) ) )
	      {
	      printf( "\nCan't open encrypted file!\n" );
              exit( FILE_ERR );
	      }
          if( setvbuf( tptr, NULL, _IOFBF, BUFFERSIZE ) )
	      {
	      printf( "\nCan't open buffer for encrypted file!\n" );
              exit( FILE_ERR );
	      }
	  }

      if( !isfile )
	      fptr = stdin;
      else
              fptr = ptxt;

	 
	  if( Operation == DECODE )
	      if( isfile )
                  fseek( fptr, MARKER_CNT, SEEK_SET ); /*Skip markers.*/
	      else;
	  else   /* Encode */
              if( !isfile )
                  fseek( fptr, 0, SEEK_SET );
	  
	  

/*****Main coding/decoding loop*****/ 
    while( ISLOOP )
	   {
      c = fgetc( fptr ); /*Get a character to encode or decode...*/
      if( feof( fptr ) ) /*as long as there's something left in the file.*/
          break;	      
	   number++;

      if( feof( codekey ) )
          rewind( codekey ); /*If used up all of key file, wrap around.*/

	   ck = fgetc( codekey ); /*Get shift value from the key file.*/

	   if( Operation == ENCODE )
		 c += ck; /*If encoding, shift right.*/
	   else /*If decoding...*/
		 c -= ck; /*shift left.*/

	   EMITCHAR(t); /*Output a char, whether to file or stdout.*/
	   }
/************************************/
    


      fclose( codekey );
   
      if( isfile )
           fclose( fptr );

      if( t )
          fclose( tptr );

      return( number );

}


/***Checks whether file is encrypted or plain text by looking for marker chars.***/
Boolean is_encrypted( char *filename )
{
   FILE *fp;
   register i;
   int c;
   Boolean isfile;
   
      if( !strcmp( filename, NULLFILE ) )
	      isfile = False;
      else
	      isfile = True;
      
      if( isfile )
          fp = fopen( filename, "r" );
      else 
	  fp = stdin;

      
      for( i = 0; i < MARKER_CNT; i++ )
         {
         c = fgetc( fp );
	 if( c != MARKER_CHAR )
             {
             if( isfile )
                 fclose( fp );

             return( False );
	     }
	 }
     
      if( isfile ) 
          fclose( fp );

      return( True );

}


/***Writes MARKER_CNT markers at beginning of file to be encrypted.***/
void write_marker( char *targetname )
{
   register i;   
   int c = MARKER_CHAR,
       t = FALSE;
   FILE *tptr;
      
   
   if( *targetname )
          {  
          t = TRUE;

          if( NULL == ( tptr = fopen( targetname, "wb" ) ) )
              exit( FILE_ERR );
	  }
   
      for( i = 0; i < MARKER_CNT; i++ )
	      EMITCHAR(t);
      
   if( t )
       fclose( tptr );
   
       return;
}      
