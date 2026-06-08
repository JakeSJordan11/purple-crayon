#include "initialize_bud.h"
#include "register_event_tap.h"
#include <CoreFoundation/CFMachPort.h>
#include <CoreGraphics/CGEvent.h>
#include <CoreGraphics/CGEventTypes.h>
#include <CoreGraphics/CGRemoteOperation.h>

CFMachPortRef register_event_tap(void)
{
    CGEventMask mask = CGEventMaskBit(kCGEventKeyDown);
    CFMachPortRef tap = CGEventTapCreate(
        kCGSessionEventTap,
        kCGHeadInsertEventTap,
        kCGEventTapOptionDefault,
        mask,
        event_tap_callback,
        NULL);
    if (!tap)
    {
        return NULL;
    }
    return tap;
}

CGEventRef event_tap_callback(CGEventTapProxy proxy, CGEventType type, CGEventRef event, void *refcon)
{
    CGKeyCode keyCode = (CGKeyCode)CGEventGetIntegerValueField(event, kCGKeyboardEventKeycode);
    CGEventFlags flags = CGEventGetFlags(event);

    if (type == kCGEventKeyDown &&
        keyCode == KEY_CODE_P &&
        (flags & kCGEventFlagMaskCommand) &&
        (flags & kCGEventFlagMaskAlternate) &&
        (flags & kCGEventFlagMaskControl))
    {
        toggle_bud();
        return NULL;
    }

    return event;
}
