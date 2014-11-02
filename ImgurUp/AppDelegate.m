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
}

- (void)applicationWillTerminate:(NSNotification *)aNotification { }

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
}

- (IBAction)newUpload:(id)sender {
}
@end
