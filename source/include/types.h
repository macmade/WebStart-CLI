#ifndef _WEBSTART_TYPES_H_
#define _WEBSTART_TYPES_H_
#pragma once

#ifndef __bool_true_false_are_defined
    #ifdef _Bool
        #define bool                        _Bool
    #else
        #define bool                        char
    #endif
    #define true                            1
    #define false                           0
    #define __bool_true_false_are_defined   1
#endif

typedef struct _cli_args
{
    bool start;
    bool stop;
    bool restart;
    bool all;
    bool apache;
    bool mysql;
    bool openldap;
    bool dyndns;
}
cli_args;

#endif /* _WEBSTART_TYPES_H_ */
