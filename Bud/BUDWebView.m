#import "BUDWebView.h"
#import <AppKit/NSEvent.h>
#import <AppKit/NSView.h>

@implementation BUDWebView
- (NSView *)hitTest:(NSPoint)point {
    return [super hitTest:point] ?: self;
}
- (BOOL)acceptsFirstMouse:(NSEvent *)event {
    return YES;
}

@end