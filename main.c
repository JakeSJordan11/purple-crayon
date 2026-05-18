#include <CoreFoundation/CoreFoundation.h>
#include "pc_event_tap.h"
#include "pc_run_loop.h"

int main(void)
{
    CFMachPortRef tap = PCEventTap();
    PCRunLoop(tap);
    return 0;
}