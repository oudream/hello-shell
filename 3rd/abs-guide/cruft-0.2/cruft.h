/*           cruft.h            */
/* include file for 'cruft pkg. */
/*        Mendel Cooper         */
/*  <thegrendel@theriver.com>   */




/*******Defines for cruft.c*************/
#define GROUP 5
#define SPACE ' '
#define MAX_INPUT_LEN 30
#define INVOCATION_ERROR 20
#define TRUE 1
#define FALSE 0
#define FILE_ERR 11
#define BUFFERSIZE 8192
#define FNAMELEN 60
#define KFNAME "/.key"
#define NULLSTRING ""
#define NULLFILE "STDIN"
#define ARGCOUNT 2
#define ISLOOP 1

/***Encoded file marker char***/
#define MARKER_CHAR 253 
/* This gives 'cruft' encoded file their characteristic signature. */

/***How many 'marker' chars written at begin of encrypted file.***/
#define MARKER_CNT 9


/****Whether to write to stdout or to target file.****/
#define EMITCHAR(x)  x?fputc(c,tptr):fputc(c,stdout)

/*******Defines for keygen.c*************/
#define ARGCOUNT 2
#define FILENAME argv[1]
#define DEFAULTKEYSIZE 1024L
#define U_MAX 65536
#define RANGE 255
/* ***        ^^^ range of random "shifts" *** */

typedef enum { ENCODE, DECODE } Codeflag;
typedef enum { False, True } Boolean;

/*******Defines for both*************/
#define CREATEFILENAME(F) sprintf(F,"%s%s",getenv("HOME"),KFNAME)
/***Macro to construct key file name.***/



/*********************Prototypes for cruft.c**********************/
int convert( int ch, Codeflag C );
long code( Codeflag Operation, char *fname, char *targetfile );
Boolean is_encrypted( char *filename );
void write_marker( char *targetfile ); 

/*******************Prototypes for keygen.c*****************/
int create_file( char *filename, long int count );
long filesize( char *filename );
