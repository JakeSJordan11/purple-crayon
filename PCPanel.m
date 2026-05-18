#import "PCPanel.h"

static void PCPanelToggleCallback(CFNotificationCenterRef center, void *observer, CFNotificationName name, const void *object, CFDictionaryRef userInfo) {
    PCPanel *panel = (__bridge PCPanel *)observer;
    [panel toggle];
}

@implementation PCPanel {
    NSPanel *_panel;
    WKWebView *_webView;
}

+ (void)load {
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
    [_panel orderFront:nil];
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
    
    _panel = [[NSPanel alloc] initWithContentRect:frame
        styleMask:NSWindowStyleMaskNonactivatingPanel | NSWindowStyleMaskFullSizeContentView
        backing:NSBackingStoreBuffered
        defer:NO];
    
    _panel.floatingPanel = YES;
    _panel.level = NSScreenSaverWindowLevel;
    _panel.backgroundColor = [NSColor clearColor];
    _panel.opaque = NO;
    _panel.hasShadow = NO;
    
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    _webView = [[WKWebView alloc] initWithFrame:frame configuration:config];
    _webView.underPageBackgroundColor = [NSColor clearColor];
    
    [_panel setContentView:_webView];
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://localhost:3000"]]];
    [_webView setValue:@NO forKey:@"windowOcclusionDetectionEnabled"];
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