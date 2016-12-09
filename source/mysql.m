#include "webstart.h"

void mysql_start( void )
{
    Process * process;
    NSTask  * task;
    NSArray * args;
    
    process = [ Process processWithPath: NSSTR( PATH_MYSQLD ) ];
    
    if( process != nil )
    {
        printf( "MySQL service is already up\n" );
        
        return;
    }
    
    printf( "Starting the MySQL service\n" );
    
    task = [ NSTask new ];
    args = [ NSArray arrayWithObject: @"--user=mysql" ];
    
    [ task setLaunchPath: NSSTR( PATH_MYSQLD_SAFE ) ];
    [ task launch ];
}

void mysql_stop( void )
{
    Process  * process;
    NSTask   * task;
    NSArray  * args;
    Keychain * keychain;
    
    keychain = [ [ Keychain alloc ] initWithName: @"WebStart MySQL root password" username: @"root" ];
    process  = [ Process processWithPath: NSSTR( PATH_MYSQLD ) ];
    
    if( process == nil )
    {
        printf( "MySQL service is already down\n" );
        
        return;
    }
    
    printf( "Stopping the MySQL service\n" );
    
    if( keychain.itemExists == YES )
    {
        args = [ NSArray arrayWithObjects: [ NSString stringWithFormat: @"--password=%@", keychain.password ], @"shutdown", nil ];
    }
    else
    {
        args = [ NSArray arrayWithObject: @"shutdown" ];
    }
    
    
    task = [ NSTask new ];
    
    [ task setLaunchPath: NSSTR( PATH_MYSQADMIN ) ];
    [ task setArguments: args ];
    [ task launch ];
}

void mysql_restart( void )
{
    Process * process;
    
    process = [ Process processWithPath: NSSTR( PATH_INADYN ) ];
    
    if( process != nil )
    {
        mysql_stop();
    }
    
    mysql_start();
}
