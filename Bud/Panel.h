#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>

@interface Panel : NSObject

- (void)show;
- (void)hide;
- (void)toggle;
- (void)registerForToggleNotification;
void RunLoopStart(void);

@end