#include <CoreGraphics/CoreGraphics.h>

int PCRunLoop(CFMachPortRef tap)
{
    CFRunLoopSourceRef source = CFMachPortCreateRunLoopSource(kCFAllocatorDefault, tap, 0);
    CFRunLoopAddSource(CFRunLoopGetCurrent(), source, kCFRunLoopCommonModes);
    CGEventTapEnable(tap, true);
    printf("Listening for hotkey...\n");
    CFRunLoopRun();
    return 0;
}