#include "webstart.h"

void openldap_start( void )
{
    Process * process;
    NSTask  * task;
    
    process = [ Process processWithPath: NSSTR( PATH_SLAPD ) ];
    
    if( process != nil )
    {
        printf( "OpenLDAP service is already up\n" );
        
        return;
    }
    
    printf( "Starting the OpenLDAP service\n" );
    
    task = [ NSTask new ];
    
    [ task setLaunchPath: NSSTR( PATH_SLAPD ) ];
    [ task launch ];
}

void openldap_stop( void )
{
    Process * process;
    NSTask  * task;
    NSArray * args;
    
    process = [ Process processWithPath: NSSTR( PATH_SLAPD ) ];
    
    if( process == nil )
    {
        printf( "OpenLDAP service is already down\n" );
        
        return;
    }
    
    printf( "Stopping the OpenLDAP service\n" );
    
    task    = [ NSTask new ];
    args    = [ NSArray arrayWithObject: [ NSString stringWithFormat: @"%li", ( long )( process.pid ) ] ];
    
    [ task setLaunchPath: NSSTR( PATH_KILL ) ];
    [ task setArguments: args ];
    [ task launch ];
}

void openldap_restart( void )
{
    Process * process;
    
    process = [ Process processWithPath: NSSTR( PATH_SLAPD ) ];
    
    if( process != nil )
    {
        openldap_stop();
    }
    
    openldap_start();
}
