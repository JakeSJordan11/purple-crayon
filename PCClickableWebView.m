#import "PCClickableWebView.h"

@implementation PCClickableWebView
- (NSView *)hitTest:(NSPoint)point {
    return [super hitTest:point] ?: self;
}
- (BOOL)acceptsFirstMouse:(NSEvent *)event {
    return YES;
}
@end