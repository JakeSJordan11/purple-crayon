#import <Cocoa/Cocoa.h>
#import "AppDelegate.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSApplication *app = [NSApplication sharedApplication];
        PCAppDelegate *delegate = [[PCAppDelegate alloc] init];
        app.delegate = delegate;
        [app run];
    }
    return 0;
}