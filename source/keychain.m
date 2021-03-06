#import "keychain.h"

@implementation Keychain

@synthesize name;
@synthesize itemExists;
@synthesize username;
@synthesize password;

+ ( id )createWithName: ( NSString * )itemName username: ( NSString * )itemUser
{
    id keychain = [ [ self alloc ] initWithName: itemName username: itemUser ];
    
    return [ keychain autorelease ];
}

- ( id )initWithName: ( NSString * )itemName username: ( NSString * )itemUser
{
    OSStatus status;
    UInt32 passwordLength;
    void * passwordData;
    
    if( ( self = [ super init ] ) )
    {
        name     = [ itemName copy ];
        username = [ itemUser copy ];
        
        status = SecKeychainFindGenericPassword
        (
            NULL,
            ( UInt32 )[ name length ],
            [ name cStringUsingEncoding: NSUTF8StringEncoding ],
            ( UInt32 )[ username length ],
            [ username cStringUsingEncoding: NSUTF8StringEncoding ],
            &passwordLength,
            &passwordData,
            &item
        );
        
        if( status == noErr )
        {
            itemExists = YES;
            password   = [ [ NSString alloc ] initWithBytes: passwordData length: passwordLength encoding: NSUTF8StringEncoding ];
            
            SecKeychainItemFreeContent
            (
                NULL,
                passwordData
            );
        }
    }
    
    return self;
}

- ( BOOL )create
{
    OSStatus status;
    
    if( self.itemExists == YES )
    {
        return YES;
    }
    
    status = SecKeychainAddGenericPassword
    (
        NULL,
        ( UInt32 )[ name length ],
        [ name cStringUsingEncoding: NSUTF8StringEncoding ],
        ( UInt32 )[ username length ],
        [ username cStringUsingEncoding: NSUTF8StringEncoding ],
        ( UInt32 )[ password length ],
        [ password cStringUsingEncoding: NSUTF8StringEncoding ],
        &item
    );
    
    return status == noErr;
}

- ( BOOL )modify
{
    OSStatus status;
    
    if( self.itemExists == NO )
    {
        return [ self create ];
    }
    
    if( self.itemExists == NO )
    {
        return NO;
    }
    
    status = SecKeychainItemModifyAttributesAndData
    (
        item,
        NULL,
        ( UInt32 )[ password length ],
        [ password cStringUsingEncoding: NSUTF8StringEncoding ]
    );
    
    return status == noErr;
}

- ( BOOL )remove
{
    OSStatus status;
    
    if( self.itemExists == NO )
    {
        return YES;
    }
    
    status = SecKeychainItemDelete( item ); 
    
    return status == noErr;
}

- ( void )update
{
    OSStatus status;
    UInt32 passwordLength;
    void * passwordData;
    
    status = SecKeychainFindGenericPassword
    (
        NULL,
        ( UInt32 )[ name length ],
        [ name cStringUsingEncoding: NSUTF8StringEncoding ],
        ( UInt32 )[ username length ],
        [ username cStringUsingEncoding: NSUTF8StringEncoding ],
        &passwordLength,
        &passwordData,
        &item
     );
        
    if( status == noErr )
    {
        [ password release ];
        
        itemExists = YES;
        password   = [ [ NSString alloc ] initWithBytes: passwordData length: passwordLength encoding: NSUTF8StringEncoding ];
        
        SecKeychainItemFreeContent
        (
            NULL,
            passwordData
        );
    }
    else
    {
        itemExists = NO;
    }
}

- ( void )dealloc
{
    CFRelease( item );
    
    [ name release ];
    [ username release ];
    [ password release ];
    [ super dealloc ];
}

@end
