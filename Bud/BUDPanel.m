#import "BUDPanel.h"
#import <AppKit/NSApplication.h>
#import <AppKit/NSColor.h>
#import <AppKit/NSEvent.h>
#import <Foundation/NSBundle.h>
#import <Foundation/NSURL.h>
#import <WebKit/WKWebViewConfiguration.h>

@implementation BUDPanel

- (BOOL)canBecomeKeyWindow 
{ 
    return YES; 
}

- (void)BUDBuildPanel 
{
    NSRect frame = NSMakeRect(0, 0, 600, 600);
    [self initWithContentRect:frame styleMask: NSWindowStyleMaskFullSizeContentView backing:NSBackingStoreBuffered defer:NO];
    
    self.level = NSScreenSaverWindowLevel;
    self.hasShadow = NO;
    self.backgroundColor = [NSColor clearColor];
    
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    self.webView = [[WKWebView  alloc] initWithFrame:frame configuration:config];
    [self.webView setValue:@NO forKey:@"drawsBackground"];

    [self setContentView:self.webView];
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSURL *url = [bundle URLForResource:@"index" withExtension:@"html" subdirectory:@"Bloom"];
    [self.webView loadFileURL:url allowingReadAccessToURL:[url URLByDeletingLastPathComponent]];
}

- (void)BUDTogglePanel 
{
    if (![self isVisible]) 
    {
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

@end