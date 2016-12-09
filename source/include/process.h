#ifndef _WEBSTART_PROCESS_H_
#define _WEBSTART_PROCESS_H_
#pragma once

@interface Process: NSObject
{
    NSUInteger pid;
    NSString * name;
    NSString * path;
}

@property( readonly ) NSUInteger pid;
@property( readonly ) NSString * name;
@property( readonly ) NSString * path;

+ ( Process * )processWithPath: ( NSString * )path;

@end

@interface Process( Private )

+ ( NSString * )processInfosByPath: ( NSString * )path;

@end

@implementation Process( Private )

+ ( NSString * )processInfosByPath: ( NSString * )path
{
    NSTask       * task;
    NSPipe       * outPipe;
    NSFileHandle * output;
    NSData       * data;
    NSString     * ps;
    NSArray      * lines;
    NSString     * line;
    
    outPipe = [ NSPipe pipe ];
    task    = [ NSTask new ];
    output  = [ outPipe fileHandleForReading ];
    
    [ task setLaunchPath: @"/bin/ps" ];
    [ task setArguments: [ NSArray arrayWithObjects: @"-Arx", nil ] ];
    [ task setStandardOutput: outPipe ];
    [ task launch ];
    
    while( [ task isRunning ] )
    {}
    
    data  = [ output readDataToEndOfFile ];
    ps    = [ [ NSString alloc ] initWithData: data encoding: NSASCIIStringEncoding ];
    lines = [ ps componentsSeparatedByString: @"\n" ];
    
    for( line in lines )
    {
        @try
        {
            if( [ [ [ line substringFromIndex: 25 ] substringToIndex: [ path length ] ] isEqualToString: path ] )
            {
                return line;
            }
        }
        @catch( NSException * e )
        {
            continue;
        }
    }
    
    return nil;
}

@end

#endif /* _WEBSTART_PROCESS_H_ */
