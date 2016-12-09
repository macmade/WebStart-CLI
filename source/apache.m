#include "webstart.h"

void apache_start( void )
{
    Process * process;
    NSTask  * task;
    NSArray * args;
    
    process = [ Process processWithPath: NSSTR( PATH_HTTPD ) ];
    
    if( process != nil )
    {
        printf( "Apache service is already up\n" );
        
        return;
    }
    
    printf( "Starting the Apache service\n" );
    
    task    = [ NSTask new ];
    args    = [ NSArray arrayWithObject: @"start" ];
    
    [ task setLaunchPath: NSSTR( PATH_APACHECTL ) ];
    [ task setArguments: args ];
    [ task launch ];
}

void apache_stop( void )
{
    Process * process;
    NSTask  * task;
    NSArray * args;
    
    process = [ Process processWithPath: NSSTR( PATH_HTTPD ) ];
    
    if( process == nil )
    {
        printf( "Apache service is already down\n" );
        
        return;
    }
    
    printf( "Stopping the Apache service\n" );
    
    task    = [ NSTask new ];
    args    = [ NSArray arrayWithObject: @"stop" ];
    
    [ task setLaunchPath: NSSTR( PATH_APACHECTL ) ];
    [ task setArguments: args ];
    [ task launch ];
}

void apache_restart( void )
{
    NSTask  * task;
    NSArray * args;
    
    printf( "Restarting the Apache service\n" );
    
    task    = [ NSTask new ];
    args    = [ NSArray arrayWithObject: @"restart" ];
    
    [ task setLaunchPath: NSSTR( PATH_APACHECTL ) ];
    [ task setArguments: args ];
    [ task launch ];
}
