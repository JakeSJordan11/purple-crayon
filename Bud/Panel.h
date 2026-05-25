#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>

@interface Panel : NSPanel
@property (strong, nonatomic) Panel *panel;
@property (strong, nonatomic) WKWebView *webView;

- (void)show;
- (void)hide;
- (void)toggle;
- (void)registerForToggleNotification;
void RunLoopStart(void);

@end