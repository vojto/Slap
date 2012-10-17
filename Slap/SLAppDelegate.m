//
//  SLAppDelegate.m
//  Slap
//
//  Created by Vojtech Rinik on 10/17/12.
//  Copyright (c) 2012 Vojtech Rinik. All rights reserved.
//

#import "SLAppDelegate.h"

@implementation SLAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    NSStatusBar *statusBar = [NSStatusBar systemStatusBar];
	self.statusItem = [statusBar statusItemWithLength:NSVariableStatusItemLength];
    
    self.statusImage = [NSImage imageNamed:@"EyeTemplate"];
	[self.statusItem setHighlightMode:YES];
	[self.statusItem setMenu:self.menu];
    [self.statusItem setImage:self.statusImage];
}

- (IBAction)preferencesAction:(id)sender {
    if (!self.preferencesController) {
        self.preferencesController = [[SLPreferencesController alloc] initWithWindowNibName:@"SLPreferencesController"];
    }
    [self.preferencesController showWindow:self];
}

- (IBAction)quitAction:(id)sender {
    [NSApp terminate:nil];
}


@end
