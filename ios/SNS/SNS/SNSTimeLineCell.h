//
//  SNSTimeLineCell.h
//  SNS
//
//  Created by Kenta Yokota on 2/4/17.
//  Copyright © 2017 Kenta Yokota. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SNSTimeLineCellDelegate <NSObject>
//@optional
@end


@interface SNSTimeLineCell : UITableViewCell

extern const CGSize   SNSTimeLineCellIconSize;
extern const CGFloat  SNSTimeLineCellHorizontalPadding;
extern const CGFloat  SNSTimeLineCellVerticalPadding;
extern const CGFloat  SNSTimeLineCellMargin;

@property (weak) id <SNSTimeLineCellDelegate> delegate;

@property (nonatomic, strong) UIButton *userIconButton;
@property (nonatomic, assign) CGFloat cornerRadius;
@property (nonatomic, assign) CGFloat borderWidth;
@property (nonatomic, strong) UIColor *borderColor;
@property (nonatomic, strong) UILabel *nameLabel;

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier delegate:(id<SNSTimeLineCellDelegate>)delegate;
- (void)configureWithPost:(NSDictionary *)post;
+ (CGFloat)cellHeightForObject:(id)object;

@end
