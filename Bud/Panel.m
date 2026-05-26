#import "ClickableWebView.h"
#import "Panel.h"
#import <WebKit/WKWebViewConfiguration.h>

// this shouldn't be needed. Instead there should be a seperate component that handles the webview and the panel just places it as the view.
@interface Panel ()
@property (strong, nonatomic) WKWebView *webView;
@end

// this needs to be removed
static void PanelToggleCallback(CFNotificationCenterRef center, void *observer, CFNotificationName name, const void *object, CFDictionaryRef userInfo) {
    Panel *panel = (__bridge Panel *)observer;
    [panel toggle];
}

@implementation Panel
- (BOOL)canBecomeKeyWindow { return YES; }
// panels can't become main windows from what I have learned. so this is not doing anything. It was most likely from whne Panel was an NSObject, but it is now an NSPAnel.
- (BOOL)canBecomeMainWindow { return NO; }
- (BOOL)acceptsFirstMouse:(NSEvent *)event { return YES; }

// this needs to be implamented better.
void RunLoopStart(void) {
    [NSApp run];
}

// this needs to be removed. It is a hack and not good practice.
+ (void)load {
    [NSApplication sharedApplication];
    [NSApp setActivationPolicy:NSApplicationActivationPolicyAccessory];
    
    static Panel *shared = nil;
    shared = [[Panel alloc] init];
    [shared buildPanel];
    [shared registerForToggleNotification];
}

// I shouldn't need a show and a hide method. I should just have a toggle.
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
    // i should be building the panel at the mouse not moving it in show
    NSRect frame = NSMakeRect(0, 0, 600, 600);

    [self initWithContentRect:frame styleMask: NSWindowStyleMaskFullSizeContentView backing:NSBackingStoreBuffered defer:NO];
    
    self.floatingPanel = YES;
    self.level = NSScreenSaverWindowLevel;
    self.opaque = NO;
    self.hasShadow = NO;
    self.backgroundColor = [NSColor clearColor];
    self.collectionBehavior = NSWindowCollectionBehaviorCanJoinAllSpaces | NSWindowCollectionBehaviorFullScreenAuxiliary;
    
    // this should all be done in the WebView in a seperate file whatever that ends up being. it should wet up the webview and then the panel just places it as the view here.
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

// this is a global system and is not safe to use. I need to find a way to not use this.0
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