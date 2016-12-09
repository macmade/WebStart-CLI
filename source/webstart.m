#include "webstart.h"

int main( int argc, char * argv[] )
{
    NSAutoreleasePool * ap;
    cli_args            args;
    
    if( getuid() != 0 )
    {
        printf( "\nPlease run this program as root\n\n" );
        return EXIT_SUCCESS;
    }
    
    ap = [ NSAutoreleasePool new ];
    
    get_cli_args( argc, argv, &args );
    
    if( args.start == false && args.stop == false && args.restart == false )
    {
        print_help( argv[ 0 ] );
    }
    
    if( args.start == true && args.stop == true )
    {
        print_help( argv[ 0 ] );
    }
    
    if( args.start == true && args.restart == true )
    {
        print_help( argv[ 0 ] );
    }
    
    if( args.stop == true && args.restart == true )
    {
        print_help( argv[ 0 ] );
    }
    
    if( args.all == true )
    {
        if( args.start == true )
        {
            apache_start();
            mysql_start();
            openldap_start();
            dyndns_start();
        }
        
        if( args.stop == true )
        {
            apache_stop();
            mysql_stop();
            openldap_stop();
            dyndns_stop();
        }
        
        if( args.restart == true )
        {
            apache_restart();
            mysql_restart();
            openldap_restart();
            dyndns_restart();
        }
    }
    else if( args.start == true )
    {
        if( args.apache == true )
        {
            apache_start();
        }
        
        if( args.mysql == true )
        {
            mysql_start();
        }
        
        if( args.openldap == true )
        {
            openldap_start();
        }
        
        if( args.dyndns == true )
        {
            dyndns_start();
        }
    }
    else if( args.stop == true )
    {
        if( args.apache == true )
        {
            apache_stop();
        }
        
        if( args.mysql == true )
        {
            mysql_stop();
        }
        
        if( args.openldap == true )
        {
            openldap_stop();
        }
        
        if( args.dyndns == true )
        {
            dyndns_stop();
        }
    }
    else if( args.restart == true )
    {
        if( args.apache == true )
        {
            apache_restart();
        }
        
        if( args.mysql == true )
        {
            mysql_restart();
        }
        
        if( args.openldap == true )
        {
            openldap_restart();
        }
        
        if( args.dyndns == true )
        {
            dyndns_restart();
        }
    }
    
    [ ap release ];
    
    return EXIT_SUCCESS;
}
