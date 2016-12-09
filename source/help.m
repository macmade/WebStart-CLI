#include "webstart.h"

void print_help( char * exec )
{
    printf
    (
        "\n"
        "Usage: %s ACTION SERVICE [SERVICE...]\n"
        "    \n"
        "Available actions:\n"
        "    - start\n"
        "    - stop\n"
        "    - restart\n"
        "    \n"
        "Available services:\n"
        "    - all\n"
        "    - apache\n"
        "    - mysql\n"
        "    - openldap\n"
        "    - dyndns\n"
        "\n"
        "Examples:\n"
        "    Restart all services:              %s restart all\n"
        "    Start the MySQL service:           %s start mysql\n"
        "    Stop the HTTP and DynDNS services: %s stop apache dyndns\n"
        "\n",
        exec,
        exec,
        exec,
        exec
    );
}
