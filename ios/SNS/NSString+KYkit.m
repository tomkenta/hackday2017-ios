//
//  NSString+KYkit.m
//  SNS
//
//  Created by Kenta Yokota on 2/5/17.
//  Copyright © 2017 Kenta Yokota. All rights reserved.
//

#import "NSString+KYkit.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (KYKit)

- (NSString *)urlEncodedString {
    NSString *str = (__bridge_transfer NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                                          (__bridge CFStringRef)self,
                                                                                          NULL,
                                                                                          (CFStringRef)@":/?=,!$&'()*+;[]@#",
                                                                                          CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    
    return str;
}

- (NSDictionary *)dictionaryFromQueryString {
    NSArray *arr = [self componentsSeparatedByString:@"&"];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    for (NSString *str in arr) {
        NSArray *tmp = [str componentsSeparatedByString:@"="];
        [dic setObject:[tmp objectAtIndex:1] forKey:[tmp objectAtIndex:0]];
    }
    return dic;
}

- (NSString *)md5 {
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    uint8_t digest[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(data.bytes, (unsigned int)data.length, digest);
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
    {
        [output appendFormat:@"%02x", digest[i]];
    }
    
    return output;
}

- (NSString *)sha1 {
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, (unsigned int)data.length, digest);
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for (int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
    {
        [output appendFormat:@"%02x", digest[i]];
    }
    
    return output;
}

- (NSString *)sha256 {
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    uint8_t digest[CC_SHA256_DIGEST_LENGTH];
    
    CC_SHA256(data.bytes, (unsigned int)data.length, digest);
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_SHA256_DIGEST_LENGTH * 2];
    
    for (int i = 0; i < CC_SHA256_DIGEST_LENGTH; i++)
    {
        [output appendFormat:@"%02x", digest[i]];
    }
    
    return output;
}

- (NSString *)sha512 {
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    uint8_t digest[CC_SHA512_DIGEST_LENGTH];
    
    CC_SHA512(data.bytes, (unsigned int)data.length, digest);
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_SHA512_DIGEST_LENGTH * 2];
    
    for (int i = 0; i < CC_SHA512_DIGEST_LENGTH; i++)
    {
        [output appendFormat:@"%02x", digest[i]];
    }
    
    return output;
}

- (BOOL)isAllHalfWidthCharacter {
    NSUInteger nsStringlen = [self length];
    const char *utf8 = [self UTF8String];
    size_t cStringlen = strlen(utf8);
    if (nsStringlen == cStringlen) {
        return YES;
    } else {
        return NO;
    }
}



- (float)getTextHeightWithFont:(UIFont *)font viewWidth:(CGFloat)viewWidth{
    NSDictionary *attributeDic = @{NSFontAttributeName:font};
    CGSize size = [self boundingRectWithSize:CGSizeMake(viewWidth, CGFLOAT_MAX)
                                     options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingTruncatesLastVisibleLine
                                  attributes:attributeDic
                                     context:nil].size;
    
    return size.height + 14;
}

- (float)getTextWidthWithFont:(UIFont *)font viewHeight:(CGFloat)viewHeight{
    NSDictionary *attributeDic = @{NSFontAttributeName:font};
    CGSize size = [self boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, viewHeight)
                                     options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingTruncatesLastVisibleLine
                                  attributes:attributeDic
                                     context:nil].size;
    return (size.width > kCommonDeviceWidth) ? kCommonDeviceWidth : size.width ;
}

- (NSString *)removeUnWantLineBreake{
    NSMutableString * finalString = [NSMutableString new];
    NSInteger counter = 0;
    for (int i = 0; i < self.length; i++) {
        NSString *tmp_str = [self substringWithRange:NSMakeRange(i, 1)];
        if ([tmp_str isEqualToString:@"\n"]){
            counter ++;
        }else {
            counter = 0;
        }
        if(counter < 3){
            [finalString appendString:tmp_str];
        }
    }
    NSInteger subStringCount = counter < 3 ? counter : 2;
    return [finalString substringToIndex:finalString.length - subStringCount];
}

- (NSString *)replaceLineBreakeToSpace{
    NSMutableString * finalString = [NSMutableString new];
    for (int i = 0; i < self.length; i++) {
        NSString *tmp_str = [self substringWithRange:NSMakeRange(i, 1)];
        if ([tmp_str isEqualToString:@"\n"]){
            [finalString appendString:@" "];
        }else{
            [finalString appendString:tmp_str];
        }
    }
    return finalString;
}

- (NSString *)absoluteString {
    return self;
}

NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";

+ (NSString *) randStringLength: (int) len {
    
    NSMutableString *randomString = [NSMutableString stringWithCapacity: len];
    
    for (int i=0; i<len; i++) {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random() % [letters length]]];
    }
    
    return randomString;
}


- (NSString *)capitalizeFirstLetter {
    NSString *capitalisedSentence = [self stringByReplacingCharactersInRange:NSMakeRange(0,1)
                                                                  withString:[[self  substringToIndex:1] capitalizedString]];
    return capitalisedSentence;
}
@end

