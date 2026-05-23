#ifndef EVENT_TAP_CALLBACK_H
#define EVENT_TAP_CALLBACK_H

#include <CoreGraphics/CoreGraphics.h>

CGEventRef event_tap_callback(CGEventTapProxy proxy, CGEventType type, CGEventRef event, void *refcon);

enum KeyCode
{
    KEY_CODE_P = 35
};

#endif // EVENT_TAP_CALLBACK_H