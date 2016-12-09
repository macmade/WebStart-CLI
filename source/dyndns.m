#include "webstart.h"

void dyndns_start( void )
{
    Process * process;
    NSTask  * task;
    
    process = [ Process processWithPath: NSSTR( PATH_INADYN ) ];
    
    if( process != nil )
    {
        printf( "DynDNS service is already up\n" );
        
        return;
    }
    
    printf( "Starting the DynDNS service\n" );
    
    task = [ NSTask new ];
    
    [ task setLaunchPath: NSSTR( PATH_INADYN ) ];
    [ task launch ];
}

void dyndns_stop( void )
{
    Process * process;
    NSTask  * task;
    NSArray * args;
    
    process = [ Process processWithPath: NSSTR( PATH_INADYN ) ];
    
    if( process == nil )
    {
        printf( "DynDNS service is already down\n" );
        
        return;
    }
    
    printf( "Stopping the DynDNS service\n" );
    
    task    = [ NSTask new ];
    args    = [ NSArray arrayWithObject: [ NSString stringWithFormat: @"%li", ( long )( process.pid ) ] ];
    
    [ task setLaunchPath: NSSTR( PATH_KILL ) ];
    [ task setArguments: args ];
    [ task launch ];
}

void dyndns_restart( void )
{
    Process * process;
    
    process = [ Process processWithPath: NSSTR( PATH_INADYN ) ];
    
    if( process != nil )
    {
        dyndns_stop();
    }
    
    dyndns_start();
}
