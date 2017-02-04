//
//  SNSTimeLineCell.m
//  SNS
//
//  Created by Kenta Yokota on 2/4/17.
//  Copyright © 2017 Kenta Yokota. All rights reserved.
//

#import "SNSTimeLineCell.h"

@implementation SNSTimeLineCell

+ (CGFloat)cellHeightForObject:(id)object{
    return 75;
}

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier delegate:(id<SNSTimeLineCellDelegate>)delegate {
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.delegate = delegate;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _userIconButton = [UIButton new];
        _userIconButton.imageView.contentMode = UIViewContentModeScaleAspectFill;
        _userIconButton.clipsToBounds = YES;
        [_userIconButton addTarget:self action:@selector(_userIconButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_userIconButton];
        
        _nameLabel = [UILabel new];
        _nameLabel.font = [UIFont boldSystemFontOfSize:14.0f];
        _nameLabel.textColor = [UIColor blackColor]; //todo 色テーマ
        [self.contentView addSubview:_nameLabel];
        
        self.selectedBackgroundView = [[UIImageView alloc] initWithImage:
                                       [UIImage imageWithColor:[kBlackColor87 colorWithAlphaComponent:0.1f]
                                                      withSize:self.frame.size]]; //todo 色テーマ
    }
    return self;
}


@end
