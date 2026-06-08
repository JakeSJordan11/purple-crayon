#include "spring.h"
#include "register_event_tap.h"
#include <CoreFoundation/CFMachPort.h>
#include <CoreFoundation/CFRunLoop.h>
#include <CoreGraphics/CGEvent.h>

void spring()
{
    CFMachPortRef tap = register_event_tap();
    if (!tap)
    {
        return;
    }
    CFRunLoopSourceRef source = CFMachPortCreateRunLoopSource(kCFAllocatorDefault, tap, 0);
    CFRunLoopAddSource(CFRunLoopGetCurrent(), source, kCFRunLoopCommonModes);
    CGEventTapEnable(tap, true);
    CFRunLoopRun();
}