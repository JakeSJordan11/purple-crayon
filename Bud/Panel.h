#import <Appkit/NSPanel.h>

@interface Panel : NSPanel

- (void)show;
- (void)hide;
- (void)toggle;
- (void)registerForToggleNotification;
void RunLoopStart(void);

@end