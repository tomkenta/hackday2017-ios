//
//  UIImage.h
//  SNS
//
//  Created by Kenta Yokota on 2/4/17.
//  Copyright © 2017 Kenta Yokota. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (KYkit)

+ (UIImage *)getImageWithName:(NSString *)imageName;
+ (UIImage *)maskImage:(UIImage *)image withMask:(UIImage *)maskImage;
- (UIImage *)maskImage:(UIImage *)maskImage;

- (UIImage*)cropInRect:(CGRect)rect;

+ (UIImage *)imageWithColor:(UIColor *)color withSize:(CGSize)size;

- (UIImage *)resizeImageFromImageSize:(CGSize)size;
- (UIImage *)resizeAspectFitWithSize:(CGSize)size;
- (UIImage *)thumbnail:(CGSize)size;

- (UIImage *)copyImage;
- (UIImage *)generateThumbnailImage;
- (UIImage*)imageAddingImage:(UIImage*)image offset:(CGPoint)offset;

- (UIImage *)imageTintedWithColor:(UIColor *)color;
+ (UIImage *)replaceColor:(UIColor*)color inImage:(UIImage*)image withTolerance:(float)tolerance;

@end
