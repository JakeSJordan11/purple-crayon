#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>

@interface PCPanel : NSObject

- (void)show;
- (void)hide;
- (void)toggle;
- (void)registerForToggleNotification;
void PCRunLoopStart(void);

@end