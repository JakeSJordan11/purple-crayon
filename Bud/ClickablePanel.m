#import "ClickablePanel.h"

@implementation ClickablePanel
- (BOOL)canBecomeKeyWindow { return YES; }
- (BOOL)canBecomeMainWindow { return NO; }
- (BOOL)acceptsFirstMouse:(NSEvent *)event { return YES; }
@end
