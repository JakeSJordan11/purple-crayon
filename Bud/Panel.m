#import "ClickableWebView.h"
#import "Panel.h"
#import <WebKit/WKWebViewConfiguration.h>

@interface Panel ()
@property (strong, nonatomic) WKWebView *webView;
@end

static void PanelToggleCallback(CFNotificationCenterRef center, void *observer, CFNotificationName name, const void *object, CFDictionaryRef userInfo) {
    Panel *panel = (__bridge Panel *)observer;
    [panel toggle];
}

@implementation Panel
- (BOOL)canBecomeKeyWindow { return YES; }
- (BOOL)canBecomeMainWindow { return NO; }
- (BOOL)acceptsFirstMouse:(NSEvent *)event { return YES; }

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
    if (!self) {
        [self buildPanel];
    }
    NSPoint mouse = [NSEvent mouseLocation];
    [self setFrameOrigin:NSMakePoint(mouse.x - 300, mouse.y - 300)];
     self.alphaValue = 0;
    [self orderFront:nil];
    [self makeKeyWindow];
    self.alphaValue = 1;

    [self makeFirstResponder:_webView];
    [NSApp activateIgnoringOtherApps:YES];
}

- (void)hide {
    [self orderOut:nil];
}

- (void)toggle {
    if (self && [self isVisible]) {
        [self hide];
    } else {
        [self show];
    }
}

- (void)buildPanel {
    NSRect frame = NSMakeRect(0, 0, 600, 600);

    [self initWithContentRect:frame styleMask: NSWindowStyleMaskFullSizeContentView backing:NSBackingStoreBuffered defer:NO];
    
    self.floatingPanel = YES;
    self.level = NSScreenSaverWindowLevel;
    self.opaque = NO;
    self.hasShadow = NO;
    self.backgroundColor = [NSColor clearColor];
    self.collectionBehavior = NSWindowCollectionBehaviorCanJoinAllSpaces | NSWindowCollectionBehaviorFullScreenAuxiliary;
    
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    self.webView = [[ClickableWebView  alloc] initWithFrame:frame configuration:config];
    self.webView.underPageBackgroundColor = [NSColor clearColor];
    [self.webView setValue:@NO forKey:@"windowOcclusionDetectionEnabled"];
    [self.webView setValue:@NO forKey:@"drawsBackground"];

    [self setContentView:self.webView];
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