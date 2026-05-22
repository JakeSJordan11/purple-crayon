#import "PCClickablePanel.h"

@implementation PCClickablePanel
- (BOOL)canBecomeKeyWindow { return YES; }
- (BOOL)canBecomeMainWindow { return NO; }
- (BOOL)acceptsFirstMouse:(NSEvent *)event { return YES; }
@end
