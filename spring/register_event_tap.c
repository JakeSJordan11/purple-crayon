#include "register_event_tap.h"
#include "initialize_bud.h"
#include <CoreFoundation/CFMachPort.h>
#include <CoreGraphics/CGEvent.h>
#include <CoreGraphics/CGEventTypes.h>
#include <CoreGraphics/CGRemoteOperation.h>

CFMachPortRef register_event_tap(void) {
  CGEventMask mask = CGEventMaskBit(kCGEventKeyDown);
  CFMachPortRef tap = CGEventTapCreate(
      kCGSessionEventTap, kCGHeadInsertEventTap, kCGEventTapOptionDefault, mask,
      event_tap_callback, NULL);
  if (!tap) {
    return NULL;
  }
  return tap;
}

CGEventRef event_tap_callback(CGEventTapProxy proxy, CGEventType type,
                              CGEventRef event, void *refcon) {
  CGKeyCode keyCode =
      (CGKeyCode)CGEventGetIntegerValueField(event, kCGKeyboardEventKeycode);
  CGEventFlags flags = CGEventGetFlags(event);

  if (type == kCGEventKeyDown && keyCode == 35 &&
      (flags & kCGEventFlagMaskCommand) &&
      (flags & kCGEventFlagMaskAlternate) &&
      (flags & kCGEventFlagMaskControl)) {
    toggle_bud();
    return NULL;
  }
  if (type == kCGEventKeyDown && keyCode == 53) {
    close_bud();
    return event;
  }
  return event;
}

void inject_hardware_key(CGKeyCode keyCode) {
  CGEventRef keyDown = CGEventCreateKeyboardEvent(NULL, keyCode, true);
  CGEventRef keyUp = CGEventCreateKeyboardEvent(NULL, keyCode, false);

  // if (keyCode == 58) {
  //   CGEventPost(kCGHIDEventTap, keyDown);
  // }

  if (keyDown && keyUp) {
    CGEventPost(kCGHIDEventTap, keyDown);
    CGEventPost(kCGHIDEventTap, keyUp);
  }

  if (keyDown)
    CFRelease(keyDown);
  if (keyUp)
    CFRelease(keyUp);
}

void inject_hardware_key_with_modifiers(CGKeyCode keyCode,
                                        CGEventFlags modifiers) {
  CGEventRef keyDown = CGEventCreateKeyboardEvent(NULL, keyCode, true);
  CGEventRef keyUp = CGEventCreateKeyboardEvent(NULL, keyCode, false);

  if (keyDown && keyUp) {
    CGEventSetFlags(keyDown, modifiers);
    CGEventSetFlags(keyUp, modifiers);
    CGEventPost(kCGHIDEventTap, keyDown);
    CGEventPost(kCGHIDEventTap, keyUp);
  }

  if (keyDown)
    CFRelease(keyDown);
  if (keyUp)
    CFRelease(keyUp);
}

void inject_hardware_modifier_key(CGKeyCode keyCode, bool keyDownValue) {
  CGEventRef keyDown = CGEventCreateKeyboardEvent(NULL, keyCode, keyDownValue);
}