#import <Appkit/NSPanel.h>
#import <WebKit/WKWebView.h>

@interface BUDPanel : NSPanel

@property(strong, nonatomic) WKWebView *webView;

- (void)BUDBuildPanel;
- (void)BUDTogglePanel;

@end