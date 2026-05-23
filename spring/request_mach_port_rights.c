#include "request_mach_port_rights.h"

void request_mach_port_rights()
{
    if (!CGPreflightListenEventAccess())
    {
        CGRequestListenEventAccess();
    }
}