#include <CoreGraphics/CoreGraphics.h>
#include <stdio.h>

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
    }

    return event;
}

int main(void)
{
    if (!CGPreflightListenEventAccess())
    {
        CGRequestListenEventAccess();
        printf("Requesting Input Monitoring permission...\n");
        return 1;
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
        return 1;
    }

    CFRunLoopSourceRef source = CFMachPortCreateRunLoopSource(kCFAllocatorDefault, tap, 0);
    CFRunLoopAddSource(CFRunLoopGetCurrent(), source, kCFRunLoopCommonModes);
    CGEventTapEnable(tap, true);
    printf("Listening for hotkey...\n");
    CFRunLoopRun();

    return 0;
}