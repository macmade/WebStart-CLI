#include "webstart.h"

void get_cli_args( int argc, char ** argv, cli_args * args )
{
    int i;
    
    args->start    = false;
    args->stop     = false;
    args->restart  = false;
    args->apache   = false;
    args->mysql    = false;
    args->openldap = false;
    args->dyndns   = false;
    args->all      = false;
    
    for( i = 1; i < argc; i++ )
    {
        if( strcmp( argv[ i ], "start" ) == 0 )
        {
            args->start = true;
        }
        
        if( strcmp( argv[ i ], "stop" ) == 0 )
        {
            args->stop = true;
        }
        
        if( strcmp( argv[ i ], "restart" ) == 0 )
        {
            args->restart = true;
        }
        
        if( strcmp( argv[ i ], "apache" ) == 0 )
        {
            args->apache = true;
        }
        
        if( strcmp( argv[ i ], "mysql" ) == 0 )
        {
            args->mysql = true;
        }
        
        if( strcmp( argv[ i ], "openldap" ) == 0 )
        {
            args->openldap = true;
        }
        
        if( strcmp( argv[ i ], "dyndns" ) == 0 )
        {
            args->dyndns = true;
        }
        
        if( strcmp( argv[ i ], "all" ) == 0 )
        {
            args->all = true;
        }
    }
}
