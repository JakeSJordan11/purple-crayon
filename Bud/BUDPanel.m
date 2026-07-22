#import "BUDPanel.h"
#import "../spring/initialize_bud.h"
#import <AppKit/NSApplication.h>
#import <AppKit/NSColor.h>
#import <AppKit/NSEvent.h>
#import <CoreGraphics/CGRemoteOperation.h>
#import <Foundation/NSBundle.h>
#import <Foundation/NSURL.h>
#import <WebKit/WKScriptMessage.h>
#import <WebKit/WKUserContentController.h>
#import <WebKit/WKWebView.h>
#import <WebKit/WKWebViewConfiguration.h>

static BUDPanel *panel = nil;

void initialize_bud(void) {
  [NSApplication sharedApplication];
  [NSApp setActivationPolicy:NSApplicationActivationPolicyAccessory];
  panel = [[BUDPanel alloc] init];
  [panel BUDBuildPanel];
}

void toggle_bud() { [panel BUDTogglePanel]; }
void close_bud() { [panel BUDClosePanel]; }

@implementation BUDPanel

- (BOOL)canBecomeKeyWindow {
  return YES;
}

- (void)BUDBuildPanel {
  NSRect frame = NSMakeRect(0, 0, 500, 500);
  [self initWithContentRect:frame
                  styleMask:NSWindowStyleMaskFullSizeContentView |
                            NSWindowStyleMaskNonactivatingPanel
                    backing:NSBackingStoreBuffered
                      defer:NO];

  self.level = NSScreenSaverWindowLevel;
  self.hasShadow = NO;
  self.opaque = NO;
  self.backgroundColor = [NSColor clearColor];
  self.hidesOnDeactivate = NO;
  self.collectionBehavior = NSWindowCollectionBehaviorCanJoinAllSpaces;

  WKUserContentController *contentController =
      [[WKUserContentController alloc] init];
  [contentController addScriptMessageHandler:self name:@"buttonClicked"];
  WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
  config.userContentController = contentController;
  self.webView = [[WKWebView alloc] initWithFrame:frame configuration:config];
  [self.webView setValue:@NO forKey:@"drawsBackground"];
  [self.webView setValue:@NO forKey:@"windowOcclusionDetectionEnabled"];
  [self setContentView:self.webView];

  NSBundle *bundle = [NSBundle bundleForClass:[self class]];
  NSURL *url = [bundle URLForResource:@"index"
                        withExtension:@"html"
                         subdirectory:@"Bloom"];
  [self.webView loadFileURL:url
      allowingReadAccessToURL:[url URLByDeletingLastPathComponent]];
}

- (void)BUDTogglePanel {
  if (![self isVisible]) {
    NSPoint mouse = [NSEvent mouseLocation];
    [self setFrameOrigin:NSMakePoint(mouse.x - 250, mouse.y - 250)];
    self.alphaValue = 0;
    [self orderFront:nil];
    [self makeKeyWindow];
    self.alphaValue = 1;

    [NSApp activateIgnoringOtherApps:YES];
    [NSApp run];
    return;
  }
  [panel BUDClosePanel];
}

- (void)BUDClosePanel {
  if ([self isVisible]) {
    [self orderOut:nil];
  }
}

#pragma mark - WKScriptMessageHandler

extern void inject_hardware_key(CGKeyCode keyCode);
extern void inject_hardware_key_with_modifiers(CGKeyCode keyCode,
                                               CGEventFlags modifiers);
extern void inject_hardware_modifier_key(CGKeyCode, bool);

- (void)userContentController:(WKUserContentController *)userContentController
      didReceiveScriptMessage:(WKScriptMessage *)message {

  if ([message.name isEqualToString:@"buttonClicked"]) {
    if ([message.body isKindOfClass:[NSDictionary class]]) {
      NSDictionary *body = message.body;
      NSNumber *keyCode = body[@"keyCode"];
      NSString *modifiers = body[@"modifiers"];
      // NSString *keyDown = body[@"keyDown"];
      // NSString *keyUp = body[@"keyUp"];

      if (keyCode) {
        CGKeyCode keyCodeValue = [keyCode unsignedShortValue];

        if (modifiers && modifiers.length > 0) {
          CGEventFlags flags = 0;
          NSArray *modifierArray = [modifiers componentsSeparatedByString:@","];

          for (NSString *modifier in modifierArray) {
            NSString *trimmedModifier = [modifier
                stringByTrimmingCharactersInSet:
                    [NSCharacterSet whitespaceAndNewlineCharacterSet]];
            if ([trimmedModifier isEqualToString:@"Command"]) {
              flags |= kCGEventFlagMaskCommand;
            } else if ([trimmedModifier isEqualToString:@"Shift"]) {
              flags |= kCGEventFlagMaskShift;
            } else if ([trimmedModifier isEqualToString:@"Control"]) {
              flags |= kCGEventFlagMaskControl;
            } else if ([trimmedModifier isEqualToString:@"Alternate"]) {
              flags |= kCGEventFlagMaskAlternate;
            }
          }

          inject_hardware_key_with_modifiers(keyCodeValue, flags);
        }
        // if (keyDown) {
        //   inject_hardware_modifier_key(keyCodeValue, true);
        // }
        // if (keyUp) {
        //   inject_hardware_modifier_key(keyCodeValue, false);
        // }
        else {
          inject_hardware_key(keyCodeValue);
        }
        [self BUDTogglePanel];
        [[NSApplication sharedApplication] hide:nil];
      }
    }
  }
}

@end