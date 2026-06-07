#import <Appkit/NSPanel.h>

@interface BUDPanel : NSPanel

- (void)show;
- (void)hide;
- (void)toggle;
- (void)registerForToggleNotification;
void RunLoopStart(void);

@end