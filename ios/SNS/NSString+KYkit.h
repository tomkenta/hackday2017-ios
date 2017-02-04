//
//  NSString+KYkit.h
//  SNS
//
//  Created by Kenta Yokota on 2/5/17.
//  Copyright © 2017 Kenta Yokota. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSString (KYkit)

- (NSString *)urlEncodedString;
- (NSDictionary *)dictionaryFromQueryString;
- (BOOL)isAllHalfWidthCharacter;
- (float)getTextHeightWithFont:(UIFont *)font viewWidth:(CGFloat)viewWidth;
- (float)getTextWidthWithFont:(UIFont *)font viewHeight:(CGFloat)viewHeight;
- (NSString *)removeUnWantLineBreake;
- (NSString *)replaceLineBreakeToSpace;

+ (NSString *) randStringLength: (int) len;

- (NSString *)md5;
- (NSString *)sha1;
- (NSString *)sha256;
- (NSString *)sha512;

- (NSString *)absoluteString;

-(NSString *)capitalizeFirstLetter;

@end
