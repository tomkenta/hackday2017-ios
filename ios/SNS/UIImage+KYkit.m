//
//  UIImage.m
//  SNS
//
//  Created by Kenta Yokota on 2/4/17.
//  Copyright © 2017 Kenta Yokota. All rights reserved.
//

#import "UIImage+KYkit.h"

#import <AVFoundation/AVFoundation.h>
#import <Accelerate/Accelerate.h>
#import <MediaPlayer/MediaPlayer.h>

@implementation UIImage (KYKit)

+ (UIImage *)getImageWithName:(NSString *)imageName {
    NSString *retinaSuffix = [[UIScreen mainScreen] scale] == 2.0 ? @"@2x" : @"";
    NSString *type = [imageName pathExtension];
    if (type == nil || [type isEqualToString:@""]) {
        type = @"png";
    }
    NSString *path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@%@", [imageName stringByDeletingPathExtension], retinaSuffix]
                                                     ofType:type];
    if (path == nil) {
        NSString *retinaSuffix = [[UIScreen mainScreen] scale] == 2.0 ? @"" : @"@2x";
        path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@%@", [imageName stringByDeletingPathExtension], retinaSuffix]
                                               ofType:type];
    }
    return [UIImage imageWithContentsOfFile:path];
}


+ (UIImage *)maskImage:(UIImage *)image withMask:(UIImage *)maskImage {
    CGImageRef maskRef = maskImage.CGImage;
    CGImageRef mask = CGImageMaskCreate(CGImageGetWidth(maskRef),
                                        CGImageGetHeight(maskRef),
                                        CGImageGetBitsPerComponent(maskRef),
                                        CGImageGetBitsPerPixel(maskRef),
                                        CGImageGetBytesPerRow(maskRef),
                                        CGImageGetDataProvider(maskRef), NULL, false);
    
    CGImageRef masked = CGImageCreateWithMask([image CGImage], mask);
    return [UIImage imageWithCGImage:masked];
}

- (UIImage *)maskImage:(UIImage *)maskImage {
    return [[self class] maskImage:self withMask:maskImage];
}

- (UIImage *)resizeAspectFitWithSize:(CGSize)size {
    CGFloat widthRatio  = size.width  / self.size.width;
    CGFloat heightRatio = size.height / self.size.height;
    CGFloat ratio = (widthRatio < heightRatio) ? widthRatio : heightRatio;
    
    CGSize resizedSize = CGSizeMake(self.size.width * ratio, self.size.height * ratio);
    return [self resizeImageFromImageSize:resizedSize];
}

- (UIImage *)thumbnail:(CGSize)size {
    float w = self.size.width;
    float h = self.size.height;
    CGRect rect;
    
    if (h <= w) {
        float x = w / 2 - h / 2;
        float y = 0;
        rect = CGRectMake(x, y, h, h);
    } else {
        float x = 0;
        float y = h / 2 - w / 2;
        rect = CGRectMake(x, y, w, w);
    }
    
    CGImageRef cgImage = CGImageCreateWithImageInRect(self.CGImage, rect);
    return [UIImage imageWithCGImage:cgImage];
}

+ (UIImage *)imageWithColor:(UIColor *)color withSize:(CGSize)size{
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (UIImage*)imageAddingImage:(UIImage*)image offset:(CGPoint)offset
{
    CGSize size = self.size;
    CGFloat scale = self.scale;
    
    size.width *= scale;
    size.height *= scale;
    
    UIGraphicsBeginImageContext(size);
    
    [self drawInRect:CGRectMake( 0, 0, size.width, size.height)];
    
    [image drawInRect:CGRectMake(scale * offset.x, scale * offset.y, image.size.width * scale, image.size.height * scale)];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGImageRef bitmapContext = CGBitmapContextCreateImage(context);
    UIImage *destImage = [UIImage imageWithCGImage:bitmapContext scale:image.scale orientation:UIImageOrientationUp];
    UIGraphicsEndImageContext();
    CGImageRelease(bitmapContext);
    
    return destImage;
}

- (UIImage *)resizeImageFromImageSize:(CGSize)size{
    UIImage *resizedImage;
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    resizedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resizedImage;
}

//こっちはスクショとかではなく、uiimageをそのままcopyしているから、2.0scaleを意識しなくてよい。
-(UIImage * )copyImage{
    UIImage *resizedImage;
    UIGraphicsBeginImageContextWithOptions(self.size,
                                           NO,                     // Opaque
                                           1.0);
    [self drawInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    resizedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resizedImage;
}

- (UIImage*)cropInRect:(CGRect)rect {
    CGSize originalSize = self.size;
    CGRect originalRect = CGRectMake(0,
                                     0,
                                     originalSize.width,
                                     originalSize.height);
    
    UIGraphicsBeginImageContextWithOptions(originalSize, YES, 0);
    [self drawInRect:originalRect];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    CGImageRef imageRef = CGImageCreateWithImageInRect([newImage CGImage], rect);
    newImage = [UIImage imageWithCGImage:imageRef scale:self.scale orientation:self.imageOrientation];
    CGImageRelease(imageRef);
    
    return newImage;
}


- (UIImage *)generateThumbnailImage{
    UIImageView * thumbnailView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    thumbnailView.image = self;
    thumbnailView.contentMode = UIViewContentModeScaleAspectFill;
    UIGraphicsBeginImageContext(CGSizeMake(floor(170), floor(170)));
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, -15, -15);
    [thumbnailView.layer renderInContext:context];
    UIImage *capture = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    NSData * data = [[NSData alloc] initWithData:UIImageJPEGRepresentation(capture, 0.3)];
    return capture = [UIImage imageWithData:data];
}

- (UIImage *)imageTintedWithColor:(UIColor *)color
{
    // This method is designed for use with template images, i.e. solid-coloured mask-like images.
    return [self imageTintedWithColor:color fraction:0.0]; // default to a fully tinted mask of the image.
}


- (UIImage *)imageTintedWithColor:(UIColor *)color fraction:(CGFloat)fraction
{
    if (color) {
        // Construct new image the same size as this one.
        UIImage *image;
        
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_4_0
        if ([UIScreen instancesRespondToSelector:@selector(scale)]) {
            UIGraphicsBeginImageContextWithOptions([self size], NO, 0.f); // 0.f for scale means "scale for device's main screen".
        } else {
            UIGraphicsBeginImageContext([self size]);
        }
#else
        UIGraphicsBeginImageContext([self size]);
#endif
        CGRect rect = CGRectZero;
        rect.size = [self size];
        
        // Composite tint color at its own opacity.
        [color set];
        UIRectFill(rect);
        
        // Mask tint color-swatch to this image's opaque mask.
        // We want behaviour like NSCompositeDestinationIn on Mac OS X.
        [self drawInRect:rect blendMode:kCGBlendModeDestinationIn alpha:1.0];
        
        // Finally, composite this image over the tinted mask at desired opacity.
        if (fraction > 0.0) {
            // We want behaviour like NSCompositeSourceOver on Mac OS X.
            [self drawInRect:rect blendMode:kCGBlendModeSourceAtop alpha:fraction];
        }
        image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return image;
    }
    
    return self;
}

+ (UIImage *)replaceColor:(UIColor*)color inImage:(UIImage*)image withTolerance:(float)tolerance {
    CGImageRef imageRef = [image CGImage];
    
    NSUInteger width = CGImageGetWidth(imageRef);
    NSUInteger height = CGImageGetHeight(imageRef);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    NSUInteger bytesPerPixel = 4;
    NSUInteger bytesPerRow = bytesPerPixel * width;
    NSUInteger bitsPerComponent = 8;
    NSUInteger bitmapByteCount = bytesPerRow * height;
    
    unsigned char *rawData = (unsigned char*) calloc(bitmapByteCount, sizeof(unsigned char));
    
    CGContextRef context = CGBitmapContextCreate(rawData, width, height,
                                                 bitsPerComponent, bytesPerRow, colorSpace,
                                                 kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    CGColorSpaceRelease(colorSpace);
    
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), imageRef);
    
    CGColorRef cgColor = [color CGColor];
    const CGFloat *components = CGColorGetComponents(cgColor);
    float r = components[0];
    float g = components[1];
    float b = components[2];
    //float a = components[3]; // not needed
    
    r = r * 255.0;
    g = g * 255.0;
    b = b * 255.0;
    
    const float redRange[2] = {
        MAX(r - (tolerance / 2.0), 0.0),
        MIN(r + (tolerance / 2.0), 255.0)
    };
    
    const float greenRange[2] = {
        MAX(g - (tolerance / 2.0), 0.0),
        MIN(g + (tolerance / 2.0), 255.0)
    };
    
    const float blueRange[2] = {
        MAX(b - (tolerance / 2.0), 0.0),
        MIN(b + (tolerance / 2.0), 255.0)
    };
    
    int byteIndex = 0;
    
    while (byteIndex < bitmapByteCount) {
        unsigned char red   = rawData[byteIndex];
        unsigned char green = rawData[byteIndex + 1];
        unsigned char blue  = rawData[byteIndex + 2];
        
        if (((red >= redRange[0]) && (red <= redRange[1])) &&
            ((green >= greenRange[0]) && (green <= greenRange[1])) &&
            ((blue >= blueRange[0]) && (blue <= blueRange[1]))) {
            // make the pixel transparent
            //
            rawData[byteIndex] = 0;
            rawData[byteIndex + 1] = 0;
            rawData[byteIndex + 2] = 0;
            rawData[byteIndex + 3] = 0;
        }
        
        byteIndex += 4;
    }
    
    UIImage *result = [UIImage imageWithCGImage:CGBitmapContextCreateImage(context)];
    
    CGContextRelease(context);
    free(rawData);
    
    return result;
}


@end
