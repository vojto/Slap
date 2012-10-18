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

@property (strong) NSSound *sound;
@property (assign) BOOL isBeeping;

@property (strong) NSAppleScript *tabsScript;

@property (strong) NSSet *urls;

@property (strong) SLPreferencesController *preferencesController;

- (void)setupUI;
- (void)setupScript;

- (void)startWatching;
- (void)nextWatch;

- (void)didSavePreferences:(NSNotification *)notification;
- (void)reloadURLs;

- (void)startBeep;
- (void)nextBeep;
- (void)stopBeep;

@end
