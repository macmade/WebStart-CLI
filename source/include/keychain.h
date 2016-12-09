#include "webstart.h"

@interface Keychain: NSObject
{
@protected
    
    SecKeychainItemRef item;
    BOOL               itemExists;
    NSString          * name;
    NSString          * username;
    NSString          * password;
    
@private
    
    id r1;
    id r2;
}

@property( readonly )        BOOL       itemExists;
@property( readonly )        NSString * name;
@property( readonly )        NSString * username;
@property( copy, readwrite ) NSString * password;

+ ( id )createWithName: ( NSString * )itemName username: ( NSString * )itemUser;
- ( id )initWithName: ( NSString * )itemName username: ( NSString * )itemUser;
- ( BOOL )create;
- ( BOOL )modify;
- ( BOOL )remove;
- ( void )update;

@end
