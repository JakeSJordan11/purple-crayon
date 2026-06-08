#import "../spring/initialize_bud.h"
#import "BUDPanel.h"

static BUDPanel *panel = nil;

void initialize_bud(void) 
{
    [NSApplication sharedApplication];
    [NSApp setActivationPolicy:NSApplicationActivationPolicyAccessory];
    panel = [[BUDPanel alloc] init];
    [panel BUDBuildPanel];
}

void toggle_bud(void) 
{ 
    [panel BUDTogglePanel];
}