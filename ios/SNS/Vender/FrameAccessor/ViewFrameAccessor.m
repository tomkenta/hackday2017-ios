//
//  ViewFrameAccessor.m
//  ViewFrameAccessor
//
//  Created by Alex Denisov on 18.03.12.
//  Copyright (c) 2013 okolodev.org. All rights reserved.
//

#import "ViewFrameAccessor.h"

@implementation UIView (FrameAccessor)

#pragma mark Frame

- (CGPoint)origin
{
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin
{
    CGRect newFrame = self.frame;
    newFrame.origin = origin;
    
    if(newFrame.origin.x != newFrame.origin.x){
        newFrame.origin.x = 0;
    }
    
    if(newFrame.origin.y != newFrame.origin.y){
        newFrame.origin.y = 0;
    }
    
    if(newFrame.size.width != newFrame.size.width){
        newFrame.size.width = 0;
    }
    
    if(newFrame.size.height != newFrame.size.height){
        newFrame.size.height = 0;
    }
    
    self.frame = newFrame;
}

- (CGSize)size
{
    return self.frame.size;
}

- (void)setSize:(CGSize)size
{
    CGRect newFrame = self.frame;
    newFrame.size = size;
    
    if(newFrame.origin.x != newFrame.origin.x){
        newFrame.origin.x = 0;
    }
    
    if(newFrame.origin.y != newFrame.origin.y){
        newFrame.origin.y = 0;
    }
    
    if(newFrame.size.width != newFrame.size.width){
        newFrame.size.width = 0;
    }
    
    if(newFrame.size.height != newFrame.size.height){
        newFrame.size.height = 0;
    }
    
    self.frame = newFrame;
}


#pragma mark Frame Origin

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (void)setX:(CGFloat)newX
{
    CGRect newFrame = self.frame;
    newFrame.origin.x = newX;
    
    if(newFrame.origin.x != newFrame.origin.x){
        newFrame.origin.x = 0;
    }
    
    if(newFrame.origin.y != newFrame.origin.y){
        newFrame.origin.y = 0;
    }
    
    if(newFrame.size.width != newFrame.size.width){
        newFrame.size.width = 0;
    }
    
    if(newFrame.size.height != newFrame.size.height){
        newFrame.size.height = 0;
    }
    
    self.frame = newFrame;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setY:(CGFloat)newY
{
    CGRect newFrame = self.frame;
    newFrame.origin.y = newY;
    
    if(newFrame.origin.x != newFrame.origin.x){
        newFrame.origin.x = 0;
    }
    
    if(newFrame.origin.y != newFrame.origin.y){
        newFrame.origin.y = 0;
    }
    
    if(newFrame.size.width != newFrame.size.width){
        newFrame.size.width = 0;
    }
    
    if(newFrame.size.height != newFrame.size.height){
        newFrame.size.height = 0;
    }
    
    self.frame = newFrame;
}


#pragma mark Frame Size

- (CGFloat)height
{
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)newHeight
{
    CGRect newFrame = self.frame;
    newFrame.size.height = newHeight;
    
    if(newFrame.origin.x != newFrame.origin.x){
        newFrame.origin.x = 0;
    }
    
    if(newFrame.origin.y != newFrame.origin.y){
        newFrame.origin.y = 0;
    }
    
    if(newFrame.size.width != newFrame.size.width){
        newFrame.size.width = 0;
    }
    
    if(newFrame.size.height != newFrame.size.height){
        newFrame.size.height = 0;
    }
    
    self.frame = newFrame;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)newWidth
{
    CGRect newFrame = self.frame;
    newFrame.size.width = newWidth;
    
    if(newFrame.origin.x != newFrame.origin.x){
        newFrame.origin.x = 0;
    }
    
    if(newFrame.origin.y != newFrame.origin.y){
        newFrame.origin.y = 0;
    }
    
    if(newFrame.size.width != newFrame.size.width){
        newFrame.size.width = 0;
    }
    
    if(newFrame.size.height != newFrame.size.height){
        newFrame.size.height = 0;
    }
    
    self.frame = newFrame;
}


#pragma mark Frame Borders

- (CGFloat)left
{
    return self.x;
}

- (void)setLeft:(CGFloat)left
{
    self.x = left;
}

- (CGFloat)right
{
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight:(CGFloat)right
{
    self.x = right - self.width;
}

- (CGFloat)top
{
    return self.y;
}

- (void)setTop:(CGFloat)top
{
    self.y = top;
}

- (CGFloat)bottom
{
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)bottom
{
    self.y = bottom - self.height;
}


#pragma mark Center Point

#if !IS_IOS_DEVICE
- (CGPoint)center
{
    return CGPointMake(self.left + self.middleX, self.top + self.middleY);
}

- (void)setCenter:(CGPoint)newCenter
{
    self.left = newCenter.x - self.middleX;
    self.top = newCenter.y - self.middleY;
}
#endif

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterX:(CGFloat)newCenterX
{
    self.center = CGPointMake(newCenterX, self.center.y);
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (void)setCenterY:(CGFloat)newCenterY
{
    self.center = CGPointMake(self.center.x, newCenterY);
}


#pragma mark Middle Point

- (CGPoint)middlePoint
{
    return CGPointMake(self.middleX, self.middleY);
}

- (CGFloat)middleX
{
    return self.width / 2;
}

- (CGFloat)middleY
{
    return self.height / 2;
}

@end
