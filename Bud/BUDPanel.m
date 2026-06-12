#import "BUDPanel.h"
#import "../Utilities/debug.h"
#import "../spring/initialize_bud.h"
#import "BUDWebView.h"
#import <AppKit/NSApplication.h>
#import <AppKit/NSColor.h>
#import <AppKit/NSEvent.h>
#import <Foundation/NSBundle.h>
#import <Foundation/NSURL.h>
#import <WebKit/WKWebViewConfiguration.h>

static BUDPanel *panel = nil;

void initialize_bud(void) {
  printf("initialize_bud\n");
  [NSApplication sharedApplication];
  [NSApp setActivationPolicy:NSApplicationActivationPolicyAccessory];
  panel = [[BUDPanel alloc] init];
  [panel BUDBuildPanel];
}

void toggle_bud(void) { [panel BUDTogglePanel]; }

@implementation BUDPanel

- (BOOL)canBecomeKeyWindow {
  return YES;
}

- (void)BUDBuildPanel {
  NSRect frame = NSMakeRect(0, 0, 600, 600);
  [self initWithContentRect:frame
                  styleMask:NSWindowStyleMaskFullSizeContentView |
                            NSWindowStyleMaskNonactivatingPanel
                    backing:NSBackingStoreBuffered
                      defer:NO];

  self.level = NSScreenSaverWindowLevel;
  self.hasShadow = NO;
  // self.opaque = NO;
  // self.backgroundColor = [NSColor clearColor];
  self.hidesOnDeactivate = NO;
  self.collectionBehavior = NSWindowCollectionBehaviorCanJoinAllSpaces;
  // self.ignoresMouseEvents = YES;

  // WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
  // self.webView = [[BUDWebView alloc] initWithFrame:frame
  // configuration:config]; [self.webView setValue:@NO
  // forKey:@"drawsBackground"]; [self.webView setValue:@NO
  // forKey:@"windowOcclusionDetectionEnabled"]; [self
  // setContentView:self.webView];

  // NSBundle *bundle = [NSBundle bundleForClass:[self class]];
  // NSURL *url = [bundle URLForResource:@"index" withExtension:@"html"
  // subdirectory:@"Bloom"]; [self.webView loadFileURL:url
  // allowingReadAccessToURL:[url URLByDeletingLastPathComponent]];
}

- (void)BUDTogglePanel {
  if (![self isVisible]) {
    NSPoint mouse = [NSEvent mouseLocation];
    [self setFrameOrigin:NSMakePoint(mouse.x - 300, mouse.y - 300)];
    self.alphaValue = 0;
    [self orderFront:nil];
    [self makeKeyWindow];
    self.alphaValue = 1;

    [NSApp activateIgnoringOtherApps:YES];
    [NSApp run];
    return;
  }
  [self orderOut:nil];
}

- (void)sendEvent:(NSEvent *)event {
  switch (event.type) {
  case NSEventTypeLeftMouseDown:
    print_color(BLUE, "Left Mouse Down");
    break;
  case NSEventTypeLeftMouseUp:
    printf("\033[33m Left Mouse Up | owner : %s\n",
           [NSStringFromClass([event.trackingArea.owner class]) UTF8String]);
    break;
  case NSEventTypeMouseEntered:
    printf("\033[32m Mouse Entered | owner: %s\n",
           [NSStringFromClass([event.trackingArea.owner class]) UTF8String]);
    break;
  case NSEventTypeMouseExited:
    printf("\033[31m Mouse Exited | owner: %s\n",
           [NSStringFromClass([event.trackingArea.owner class]) UTF8String]);
    break;
  default:
    break;
  }
  [super sendEvent:event];
}

@end