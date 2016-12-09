#include "webstart.h"

@implementation Process

@synthesize pid;
@synthesize name;
@synthesize path;

+ ( Process * )processWithPath: ( NSString * )path
{
    Process * process;
    NSString  * processInfos;
    
    processInfos = [ self processInfosByPath: path ];
    
    if( processInfos == nil )
    {
        return nil;
    }
    
    process       = [ Process new ];
    process->pid  = [ [ processInfos substringToIndex: 5 ] integerValue ];
    process->name = [ [ path lastPathComponent ] copy ];
    process->path = [ path copy ];
    
    return process;
}

- ( NSString * )description
{
    NSString * desc;
    
    desc = [ super description ];
    
    return [ NSString stringWithFormat: @"%@ - %@ (%lu) - %@", desc, name, ( unsigned long )pid, path ];
}

- ( void )dealloc
{
    [ name release ];
    [ path release ];
    
    [ super dealloc ];
}

@end
