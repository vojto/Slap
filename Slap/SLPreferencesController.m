//
//  SLPreferencesController.m
//  Slap
//
//  Created by Vojtech Rinik on 10/17/12.
//  Copyright (c) 2012 Vojtech Rinik. All rights reserved.
//

#import "SLPreferencesController.h"

@interface SLPreferencesController ()

@end

@implementation SLPreferencesController

- (id)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}
- (IBAction)okAction:(id)sender {
    [self close];
    NSNotification *notification = [NSNotification notificationWithName:@"SLDidSavePreferences" object:nil];
    [[NSNotificationCenter defaultCenter] postNotification:notification];
}

@end
