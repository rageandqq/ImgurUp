//
//  AppDelegate.h
//  ImgurUp
//
//  Created by Sameer Chitley on 2014-11-01.
//  Copyright (c) 2014 rageandqq. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <IOKit/IOKitLib.h>
#import <IOKit/graphics/IOGraphicsLib.h>
#import "ScreenDocument.h"

@interface AppDelegate : NSObject <NSApplicationDelegate> {

    IBOutlet NSMenu *statusMenu;
    NSStatusItem *statusItem;
    
    CGDirectDisplayID *displays;
    int numDisplays;
    
    ScreenDocument *screen;
    
}

@property (weak) IBOutlet NSWindow *aboutWindow;
@property (weak) IBOutlet NSWindow *uploadsWindow;

- (IBAction)about:(id)sender;
- (IBAction)uploads:(id)sender;
- (IBAction)newUpload:(id)sender;
- (IBAction)takeAndSaveScreenshot:(id)sender;

- (void) getDisplays;
- (NSString *) displayNameFromId:(CGDirectDisplayID)displayId;

@end

