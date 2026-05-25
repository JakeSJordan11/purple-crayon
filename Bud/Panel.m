#import "ClickablePanel.h"
#import "ClickableWebView.h"
#import "Panel.h"

static void PanelToggleCallback(CFNotificationCenterRef center, void *observer, CFNotificationName name, const void *object, CFDictionaryRef userInfo) {
    Panel *panel = (__bridge Panel *)observer;
    [panel toggle];
}

@implementation Panel

void RunLoopStart(void) {
    [NSApp run];
}

+ (void)load {
    [NSApplication sharedApplication];
    [NSApp setActivationPolicy:NSApplicationActivationPolicyAccessory];
    
    static Panel *shared = nil;
    shared = [[Panel alloc] init];
    [shared buildPanel];
    [shared registerForToggleNotification];
}

- (void)show {
    if (!_panel) {
        [self buildPanel];
    }
    NSPoint mouse = [NSEvent mouseLocation];
    [self.panel setFrameOrigin:NSMakePoint(mouse.x - 300, mouse.y - 300)];
     self.panel.alphaValue = 0;
    [self.panel orderFront:nil];
    [self.panel makeKeyWindow];
    self.panel.alphaValue = 1;

    [self.panel makeFirstResponder:_webView];
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

    self.panel = [[ClickablePanel alloc] initWithContentRect:frame
    styleMask: NSWindowStyleMaskFullSizeContentView
    backing:NSBackingStoreBuffered
    defer:NO];
    
    self.panel.floatingPanel = YES;
    self.panel.level = NSScreenSaverWindowLevel;
    self.panel.opaque = NO;
    self.panel.hasShadow = NO;
    self.panel.backgroundColor = [NSColor clearColor];
    self.panel.collectionBehavior = NSWindowCollectionBehaviorCanJoinAllSpaces | NSWindowCollectionBehaviorFullScreenAuxiliary;
    
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    self.webView = [[ClickableWebView  alloc] initWithFrame:frame configuration:config];
    self.webView.underPageBackgroundColor = [NSColor clearColor];
    [self.webView setValue:@NO forKey:@"windowOcclusionDetectionEnabled"];
    [self.webView setValue:@NO forKey:@"drawsBackground"];

    [self.panel setContentView:_webView];
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSURL *url = [bundle URLForResource:@"index" withExtension:@"html" subdirectory:@"Bloom"];
    [self.webView loadFileURL:url allowingReadAccessToURL:[url URLByDeletingLastPathComponent]];
}

- (void)registerForToggleNotification {
    CFNotificationCenterAddObserver(
        CFNotificationCenterGetDarwinNotifyCenter(),
        (__bridge void *)self,
        PanelToggleCallback,
        CFSTR("com.jakejordan.purplecrayon.toggle"),
        NULL,
        CFNotificationSuspensionBehaviorDeliverImmediately
    );
}

@end