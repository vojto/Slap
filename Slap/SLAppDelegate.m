//
//  SLAppDelegate.m
//  Slap
//
//  Created by Vojtech Rinik on 10/17/12.
//  Copyright (c) 2012 Vojtech Rinik. All rights reserved.
//

#import "SLAppDelegate.h"

@implementation SLAppDelegate

#pragma mark - Lifecycle

- (id)init {
    if ((self = [super init])) {
        self.isBeeping = NO;
    }
    
    return self;
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didSavePreferences:) name:@"SLDidSavePreferences" object:nil];
    [self reloadURLs];
    [self setupUI];
    [self setupScript];
    [self startWatching];
}

- (void)setupUI {
    NSStatusBar *statusBar = [NSStatusBar systemStatusBar];
	self.statusItem = [statusBar statusItemWithLength:NSVariableStatusItemLength];
    self.statusImage = [NSImage imageNamed:@"EyeTemplate"];
	[self.statusItem setHighlightMode:YES];
	[self.statusItem setMenu:self.menu];
    [self.statusItem setImage:self.statusImage];
    
    NSString *resourcePath = [[NSBundle mainBundle] pathForResource:@"beep" ofType:@"mp3"];
    self.sound = [[NSSound alloc] initWithContentsOfFile:resourcePath byReference:YES];
}

- (void)setupScript {
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"tabs" withExtension:@"scpt"];
    self.tabsScript = [[NSAppleScript alloc] initWithContentsOfURL:url error:nil];
    [self.tabsScript compileAndReturnError:nil];
}

#pragma mark - Actions

- (IBAction)preferencesAction:(id)sender {
    if (!self.preferencesController) {
        self.preferencesController = [[SLPreferencesController alloc] initWithWindowNibName:@"SLPreferencesController"];
    }
    [self.preferencesController showWindow:self];
    [NSApp activateIgnoringOtherApps:YES];
}

- (IBAction)quitAction:(id)sender {
    [NSApp terminate:nil];
}

#pragma mark - Watching

- (void)startWatching {
    [self nextWatch];
}

- (void)nextWatch {
    NSMutableArray *openURLs = [[NSMutableArray alloc] init];
    NSMutableArray *matchedURLs = [[NSMutableArray alloc] init];
    NSDictionary *err = nil;
    NSAppleEventDescriptor *descriptor = [self.tabsScript executeAndReturnError:&err];

    for (int i = 1; i <= descriptor.numberOfItems; i++) {
        NSAppleEventDescriptor *item = [descriptor descriptorAtIndex:i];
        NSString *url = [item stringValue];
        if (!url) continue;
        [openURLs addObject:url];
    }

    for (NSString *openURL in openURLs) {
        for (NSString *url in self.urls) {
            if ([openURL rangeOfString:url].location != NSNotFound) {
                [matchedURLs addObject:openURL];
            }
        }
    }
    
    if ([matchedURLs count] > 0) {
        [self startBeep];
    } else {
        [self stopBeep];
    }
    
    
    [self performSelector:@selector(nextWatch) withObject:nil afterDelay:3];
}

#pragma mark - Reloading URLs

- (void)didSavePreferences:(NSNotification *)notification {
    [self reloadURLs];
}

- (void)reloadURLs {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *urls = [defaults objectForKey:@"urls"];
    NSMutableSet *urlSet = [[NSMutableSet alloc] init];
    for (NSDictionary *url in urls) {
        [urlSet addObject:[url objectForKey:@"url"]];
    }
    self.urls = urlSet;
}

#pragma mark - Beeping

- (void)startBeep {
    if (self.isBeeping) return;
    self.isBeeping = YES;
    [self nextBeep];
}

- (void)nextBeep {
    [self.sound play];
    [self performSelector:@selector(nextBeep) withObject:nil afterDelay:1];
}

- (void)stopBeep {
    self.isBeeping = NO;
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(nextBeep) object:nil];
}

@end
