#import "PCPanel.h"
#import "PCClickablePanel.h"
#import "PCClickableWebView.h"

static void PCPanelToggleCallback(CFNotificationCenterRef center, void *observer, CFNotificationName name, const void *object, CFDictionaryRef userInfo) {
    PCPanel *panel = (__bridge PCPanel *)observer;
    [panel toggle];
}

@implementation PCPanel {
    NSPanel *_panel;
    WKWebView *_webView;
}

void PCRunLoopStart(void) {
    [NSApp run];
}

+ (void)load {
    [NSApplication sharedApplication];
    [NSApp setActivationPolicy:NSApplicationActivationPolicyAccessory];
    
    static PCPanel *shared = nil;
    shared = [[PCPanel alloc] init];
    [shared buildPanel];
    [shared registerForToggleNotification];
}

- (void)show {
    if (!_panel) {
        [self buildPanel];
    }
    NSPoint mouse = [NSEvent mouseLocation];
    [_panel setFrameOrigin:NSMakePoint(mouse.x - 300, mouse.y - 300)];
     _panel.alphaValue = 0;
    [_panel orderFront:nil];
    [_panel makeKeyWindow];
    _panel.alphaValue = 1;

    [_panel makeFirstResponder:_webView];
    [NSApp activateIgnoringOtherApps:YES];
}

- (void)hide {
    [_panel orderOut:nil];
}

- (void)toggle {
    if (_panel && [_panel isVisible]) {
        [self hide];
    } else {
        [self show];
    }
}

- (void)buildPanel {
    NSRect frame = NSMakeRect(0, 0, 600, 600);

    _panel = [[PCClickablePanel alloc] initWithContentRect:frame
    styleMask: NSWindowStyleMaskFullSizeContentView
    backing:NSBackingStoreBuffered
    defer:NO];
    
    _panel.floatingPanel = YES;
    _panel.level = NSScreenSaverWindowLevel;
    _panel.opaque = NO;
    _panel.hasShadow = NO;
    _panel.backgroundColor = [NSColor clearColor];
    _panel.collectionBehavior = NSWindowCollectionBehaviorCanJoinAllSpaces | NSWindowCollectionBehaviorFullScreenAuxiliary;
    
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    _webView = [[PCClickableWebView  alloc] initWithFrame:frame configuration:config];
    _webView.underPageBackgroundColor = [NSColor clearColor];
    [_webView setValue:@NO forKey:@"windowOcclusionDetectionEnabled"];
    [_webView setValue:@NO forKey:@"drawsBackground"];

    [_panel setContentView:_webView];
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSURL *url = [bundle URLForResource:@"index" withExtension:@"html" subdirectory:@"ui"];
    [_webView loadFileURL:url allowingReadAccessToURL:[url URLByDeletingLastPathComponent]];
}

- (void)registerForToggleNotification {
    CFNotificationCenterAddObserver(
        CFNotificationCenterGetDarwinNotifyCenter(),
        (__bridge void *)self,
        PCPanelToggleCallback,
        CFSTR("com.jakejordan.purplecrayon.toggle"),
        NULL,
        CFNotificationSuspensionBehaviorDeliverImmediately
    );
}

@end