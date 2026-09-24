#include "register_event_tap.h"
#include "initialize_bud.h"
#include <CoreFoundation/CFMachPort.h>
#include <CoreGraphics/CGEvent.h>
#include <CoreGraphics/CGEventTypes.h>
#include <CoreGraphics/CGRemoteOperation.h>

static CGEventFlags held_flags = 0;

static CGEventFlags flag_for_keycode(CGKeyCode k) {
  return k == 55   ? kCGEventFlagMaskCommand
         : k == 56 ? kCGEventFlagMaskShift
         : k == 58 ? kCGEventFlagMaskAlternate
         : k == 59 ? kCGEventFlagMaskControl
                   : 0;
}

CFMachPortRef register_event_tap(void) {
  CGEventMask mask = CGEventMaskBit(kCGEventKeyDown) |
                     CGEventMaskBit(kCGEventLeftMouseDown) |
                     CGEventMaskBit(kCGEventLeftMouseDragged) |
                     CGEventMaskBit(kCGEventLeftMouseUp);
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
  if (type != kCGEventKeyDown) {
    if (held_flags && event)
      CGEventSetFlags(event, CGEventGetFlags(event) | held_flags);
    return event;
  }

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
  CGEventFlags flag = flag_for_keycode(keyCode);
  if (flag) {
    held_flags ^= flag;
    return;
  }

  CGEventRef keyDown = CGEventCreateKeyboardEvent(NULL, keyCode, true);
  CGEventRef keyUp = CGEventCreateKeyboardEvent(NULL, keyCode, false);

  // if (keyCode == 58) {
  //   CGEventPost(kCGHIDEventTap, keyDown);
  // }

  if (keyDown && keyUp) {
    CGEventSetFlags(keyDown, CGEventGetFlags(keyDown) | held_flags);
    CGEventSetFlags(keyUp, CGEventGetFlags(keyUp) | held_flags);
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
    CGEventSetFlags(keyDown, modifiers | held_flags);
    CGEventSetFlags(keyUp, modifiers | held_flags);
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