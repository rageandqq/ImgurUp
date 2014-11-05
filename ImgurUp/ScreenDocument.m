//
//  NSObject+ScreenDocument.m
//  ImgurUp
//
//  Created by Sameer Chitley on 2014-11-02.
//  Copyright (c) 2014 rageandqq. All rights reserved.
//

#import "ScreenDocument.h"


@implementation ScreenDocument: NSObject

- (BOOL) writeToFile:(NSString *)path {
    CFURLRef url = (__bridge CFURLRef)[NSURL fileURLWithPath:path];
    CGImageDestinationRef destination = CGImageDestinationCreateWithURL(url, kUTTypePNG, 1, NULL);
    if (!destination) {
        NSLog(@"Failed to create CGImageDestination for %@", path);
        return NO;
    }
    
    CGImageDestinationAddImage(destination, [self currentCGImage], nil);
    
    if (!CGImageDestinationFinalize(destination)) {
        NSLog(@"Failed to write image to %@", path);
    }
    
    CFRelease(destination);
    
    return YES;
}

- (void)setCGImage:(CGImageRef)newImage {
    image = newImage;
}

- (CGImageRef)currentCGImage {
    return image;
}

- (NSData *) getNSDataFromImage {
    if (![self currentCGImage])
        return nil;
    CGImageRef currentImage = [self currentCGImage];
    NSSize imageSize = NSZeroSize;
    imageSize.height = CGImageGetHeight(currentImage);
    imageSize.width = CGImageGetWidth(currentImage);
    NSImage *imageAsNSImage = [[NSImage alloc ] initWithCGImage:currentImage size:imageSize];
    return [imageAsNSImage TIFFRepresentation];
    
}

- (void) uploadImage {

}

@end
