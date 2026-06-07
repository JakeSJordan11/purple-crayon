#include "event_tap_callback.h"
#include <CoreFoundation/CFMachPort.h>
#include <CoreGraphics/CGEvent.h>
#include <CoreGraphics/CGEventTypes.h>
#include <CoreGraphics/CGRemoteOperation.h>

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
        printf("Hotkey fired!\n");
        CFNotificationCenterPostNotification(
            CFNotificationCenterGetDarwinNotifyCenter(),
            CFSTR("com.jakejordan.purplecrayon.toggle"),
            NULL,
            NULL,
            true);

        return NULL;
    }

    return event;
}