//
//  AppDelegate.m
//  ImgurUp
//
//  Created by Sameer Chitley on 2014-11-01.
//  Copyright (c) 2014 rageandqq. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    [NSApp setActivationPolicy: NSApplicationActivationPolicyAccessory]; //Remove from dock
    [self initVariables];
    [self getDisplays];
    
}

- (void)applicationWillTerminate:(NSNotification *)aNotification { }

- (void)initVariables {
    displays = nil;
    numDisplays = 0;
    screen = [[ScreenDocument alloc] init];
}

- (void)awakeFromNib {
    statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSSquareStatusItemLength];
    NSBundle *bundle = [NSBundle mainBundle];
    NSImage *statusImage = [[NSImage alloc] initWithContentsOfFile:[bundle pathForResource:@"icon_88" ofType:@"png"]];
    
    [statusItem setImage:statusImage];
    [statusItem setMenu:statusMenu];
    [statusItem setToolTip:@"Imgur Up"];
    
}

- (IBAction)about:(id)sender {
    NSLog(@"About Window opened");
    [self.aboutWindow makeKeyAndOrderFront:NSApp];
}

- (IBAction)uploads:(id)sender {
    NSLog(@"All Uploads window opened");
    [self.uploadsWindow makeKeyAndOrderFront:NSApp];
}

- (IBAction)newUpload:(id)sender {
    
}

- (IBAction)takeScreenshot:(id)sender {
    if (displays == nil || numDisplays <= 0) {
        NSLog(@"ERROR: Cannot take screenshot. No displays found");
        return;
    }
    if (numDisplays == 1) {
        CGImageRef screenCap = CGDisplayCreateImage(displays[0]);
        [screen setCGImage:screenCap];
    }
    else {
        //multiple displays, not yet implemented.
    }
}

- (void)getDisplays {
    CGError error = CGDisplayNoErr;
    CGDisplayCount count = 0;
    
    error = CGGetActiveDisplayList(0, NULL, &count);
    
    if (error != CGDisplayNoErr) {
        displays = nil;
        NSLog(@"ERROR: No displays found.");
    }
    else {
        displays = calloc((size_t)count, sizeof(CGDirectDisplayID));
        error = CGGetActiveDisplayList(count, displays, &count);
        if (error != CGDisplayNoErr) {
            displays = nil;
            NSLog(@"ERROR: Could not get list of active displays.");
        }
        else {
            numDisplays = count;
            for (int i = 0; i < count; i++) {
                NSLog(@"Display #%i: %@", (i+1), [self displayNameFromId:displays[i]]);
            }
        }

    }
}

- (NSString *)displayNameFromId:(CGDirectDisplayID)displayId {
    NSDictionary *info = (__bridge NSDictionary *)IODisplayCreateInfoDictionary(CGDisplayIOServicePort(displayId), kIODisplayOnlyPreferredName);
    NSDictionary *names = [info objectForKey:[NSString stringWithUTF8String:kDisplayProductName]];
    if ([names count] > 0) {
        return [names objectForKey:[[names allKeys] objectAtIndex:0]];
    }
    return nil;
}
@end
