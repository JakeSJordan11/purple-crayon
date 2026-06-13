#ifndef REGISTER_EVENT_TAP_H
#define REGISTER_EVENT_TAP_H

#include <CoreFoundation/CFMachPort.h>
#include <CoreGraphics/CGEventTypes.h>

CFMachPortRef register_event_tap(void);
CGEventRef event_tap_callback(CGEventTapProxy proxy, CGEventType type,
                              CGEventRef event, void *efcon);

enum KeyCode {
  KEY_CODE_A = 0,
  KEY_CODE_B = 11,
  KEY_CODE_C = 8,
  KEY_CODE_D = 2,
  KEY_CODE_E = 12,
  KEY_CODE_F = 3,
  KEY_CODE_G = 5,
  KEY_CODE_H = 4,
  KEY_CODE_I = 34,
  KEY_CODE_J = 38,
  KEY_CODE_K = 40,
  KEY_CODE_L = 37,
  KEY_CODE_M = 46,
  KEY_CODE_N = 45,
  KEY_CODE_O = 31,
  KEY_CODE_P = 35,
  KEY_CODE_Q = 12,
  KEY_CODE_R = 15,
  KEY_CODE_S = 1,
  KEY_CODE_T = 17,
  KEY_CODE_U = 32,
  KEY_CODE_V = 9,
  KEY_CODE_W = 13,
  KEY_CODE_X = 7,
  KEY_CODE_Y = 16,
  KEY_CODE_Z = 6,
};

#endif