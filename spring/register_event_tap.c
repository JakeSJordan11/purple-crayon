#include "event_tap_callback.h"
#include "request_mach_port_rights.h"
#include <CoreFoundation/CFMachPort.h>
#include <CoreGraphics/CGEventTypes.h>
#include <CoreGraphics/CGEvent.h>

CFMachPortRef register_event_tap(void)
{
    request_mach_port_rights();
    CGEventMask mask = CGEventMaskBit(kCGEventKeyDown);
    CFMachPortRef tap = CGEventTapCreate(
        kCGSessionEventTap,
        kCGHeadInsertEventTap,
        kCGEventTapOptionListenOnly,
        mask,
        event_tap_callback,
        NULL);
    if (!tap)
    {
        return NULL;
    }
    return tap;
}