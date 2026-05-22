#include <CoreGraphics/CoreGraphics.h>

#define kPCKeyCodeP 35

CGEventRef eventCallback(CGEventTapProxy proxy, CGEventType type, CGEventRef event, void *refcon)
{
    CGKeyCode keyCode = (CGKeyCode)CGEventGetIntegerValueField(event, kCGKeyboardEventKeycode);
    CGEventFlags flags = CGEventGetFlags(event);

    if (type == kCGEventKeyDown &&
        keyCode == kPCKeyCodeP &&
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

CFMachPortRef PCEventTap(void)
{
    if (!CGPreflightListenEventAccess())
    {
        CGRequestListenEventAccess();
        printf("Requesting Input Monitoring permission...\n");
        return NULL;
    }
    CGEventMask mask = CGEventMaskBit(kCGEventKeyDown);
    CFMachPortRef tap = CGEventTapCreate(
        kCGSessionEventTap,
        kCGHeadInsertEventTap,
        kCGEventTapOptionListenOnly,
        mask,
        eventCallback,
        NULL);
    if (!tap)
    {
        printf("Failed to create event tap\n");
        return NULL;
    }
    return tap;
}