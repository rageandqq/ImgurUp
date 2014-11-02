//
//  NSObject+ScreenDocument.m
//  ImgurUp
//
//  Created by Sameer Chitley on 2014-11-02.
//  Copyright (c) 2014 rageandqq. All rights reserved.
//

#import "ScreenDocument.h"

@implementation ScreenDocument: NSObject

/* Modified from Apple's ScreenSnapshot
    https://developer.apple.com/library/mac/samplecode/ScreenSnapshot/Introduction/Intro.html */
- (BOOL)writeToURL:(NSURL *)absoluteURL ofType:(NSString *)typeName error:(NSError **)outError
{
    BOOL status = NO;
    
    CFStringRef utiRef = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, (__bridge CFStringRef) typeName,kUTTypeData);
    if (utiRef == nil) {
        return status;
    }
    
    CGImageDestinationRef dest = CGImageDestinationCreateWithURL((CFURLRef)absoluteURL, utiRef, 1, nil);
    CFRelease(utiRef);
    
    if (dest == nil) {
        goto bail;
    }
    
    CGImageRef docImage = [self currentCGImage];
    if (docImage == nil) {
        goto bail;
    }
    
    CGImageDestinationAddImage(dest, docImage, NULL);
    status = CGImageDestinationFinalize(dest);

bail:
    if(dest)
        CFRelease(dest);
    return status;
}

- (void)setCGImage:(CGImageRef)newImage {
    image = newImage;
}

- (CGImageRef)currentCGImage {
    return image;
}

- (CGSize)imageSize {
    if (image) {
        return CGSizeMake(CGImageGetWidth(image), CGImageGetHeight(image));
    }
    return CGSizeMake(0, 0); //no image set, returned 0x0
}


@end
