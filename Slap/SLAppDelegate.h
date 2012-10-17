//
//  SLAppDelegate.h
//  Slap
//
//  Created by Vojtech Rinik on 10/17/12.
//  Copyright (c) 2012 Vojtech Rinik. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "SLPreferencesController.h"

@interface SLAppDelegate : NSObject <NSApplicationDelegate>

@property (weak) IBOutlet NSMenu *menu;
@property (strong) NSStatusItem *statusItem;
@property (strong) NSImage *statusImage;

@property (strong) SLPreferencesController *preferencesController;

@end
