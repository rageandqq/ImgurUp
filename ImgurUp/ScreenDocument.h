//
//  NSObject+ScreenDocument.h
//  ImgurUp
//
//  Created by Sameer Chitley on 2014-11-02.
//  Copyright (c) 2014 rageandqq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <IOKit/IOKitLib.h>
#import <IOKit/graphics/IOGraphicsLib.h>

@interface ScreenDocument: NSObject {
    CGImageRef image;
}

- (void) setCGImage:(CGImageRef)newImage;
- (CGSize) imageSize;
- (BOOL) writeToFile:(NSString *)path;

@end
