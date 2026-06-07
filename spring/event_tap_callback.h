#ifndef EVENT_TAP_CALLBACK_H
#define EVENT_TAP_CALLBACK_H

#include <CoreGraphics/CGEventTypes.h>

CGEventRef event_tap_callback(CGEventTapProxy proxy, CGEventType type, CGEventRef event, void *efcon);

enum KeyCode
{
    KEY_CODE_P = 35
};

#endif