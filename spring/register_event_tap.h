#ifndef REGISTER_EVENT_TAP_H
#define REGISTER_EVENT_TAP_H

#include <CoreFoundation/CFMachPort.h>
#include <CoreGraphics/CGEventTypes.h>

CFMachPortRef register_event_tap(void);
CGEventRef event_tap_callback(CGEventTapProxy proxy, CGEventType type, CGEventRef event, void *efcon);

enum KeyCode
{
    KEY_CODE_P = 35
};

#endif