#include <CoreFoundation/CoreFoundation.h>
#include <CoreGraphics/CoreGraphics.h>
#include "register_event_tap.h"
#include "run_loop.h"
#include "run_loop_start.h"

int RunLoop()
{
    CFMachPortRef tap = register_event_tap();
    CFRunLoopSourceRef source = CFMachPortCreateRunLoopSource(kCFAllocatorDefault, tap, 0);
    CFRunLoopAddSource(CFRunLoopGetCurrent(), source, kCFRunLoopCommonModes);
    CGEventTapEnable(tap, true);
    RunLoopStart();
    return 0;
}