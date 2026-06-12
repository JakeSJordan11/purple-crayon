#import <Appkit/NSPanel.h>
#import <WebKit/WKScriptMessageHandler.h>
#import <WebKit/WKWebView.h>

@interface BUDPanel : NSPanel <WKScriptMessageHandler>

@property(strong, nonatomic) WKWebView *webView;

- (void)BUDBuildPanel;
- (void)BUDTogglePanel;

@end