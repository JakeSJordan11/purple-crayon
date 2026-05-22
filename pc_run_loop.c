#include <CoreGraphics/CoreGraphics.h>
#include "pc_run_loop_start.h"
#include "pc_event_tap.h"

int PCRunLoop()
{
    CFMachPortRef tap = PCEventTap();
    CFRunLoopSourceRef source = CFMachPortCreateRunLoopSource(kCFAllocatorDefault, tap, 0);
    CFRunLoopAddSource(CFRunLoopGetCurrent(), source, kCFRunLoopCommonModes);
    CGEventTapEnable(tap, true);
    printf("Listening for hotkey...\n");
    PCRunLoopStart();
    return 0;
}