#include "request_mach_port_rights.h"
#include <CoreGraphics/CGEvent.h>

void request_mach_port_rights()
{
    if (!CGPreflightListenEventAccess())
    {
        CGRequestListenEventAccess();
    }
}