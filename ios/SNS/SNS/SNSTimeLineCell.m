//
//  SNSTimeLineCell.m
//  SNS
//
//  Created by Kenta Yokota on 2/4/17.
//  Copyright © 2017 Kenta Yokota. All rights reserved.
//

#import "SNSTimeLineCell.h"

const CGSize   SNSTimeLineCellIconSize          = {50.0f, 50.0f};
const CGFloat  SNSTimeLineCellHorizontalPadding = 15.0f;
const CGFloat  SNSTimeLineCellVerticalPadding   = 15.0f;
const CGFloat  SNSTimeLineCellMargin            = 15.0f;

CGFloat const SNSTimeLineCellSpace = 5.0f;
CGFloat const SNSTimeLineCellButtonHeight   = 25.0f;
CGFloat const SNSTimeLineCellContentMargin  = 16.0f;

#define SNSTimeLineCellMessageWidth (kCommonDeviceWidth - 50 - 15 * 2 - 15)

@interface SNSTimeLineCell () {
@private
    
    UILabel *_textLabel;
    UILabel *_dateLabel;
    
}
@end

@implementation SNSTimeLineCell


- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier delegate:(id<SNSTimeLineCellDelegate>)delegate {
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.clipsToBounds = NO;
        self.delegate = delegate;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.selectedBackgroundView = [[UIImageView alloc] initWithImage:
                                       [UIImage imageWithColor:[kBlackColor87 colorWithAlphaComponent:0.1f]
                                                      withSize:self.frame.size]]; //todo 色テーマ
        
        _userIconButton = [UIButton new];
        _userIconButton.imageView.contentMode = UIViewContentModeScaleAspectFill;
        _userIconButton.layer.borderColor = [UIColor colorWithHex:0xdddddd].CGColor;
        _userIconButton.clipsToBounds = YES;
        [_userIconButton addTarget:self action:@selector(_userIconButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_userIconButton];
        
        _dateLabel = [UILabel new];
        _dateLabel.font = [UIFont systemFontOfSize:12.0f];
        _dateLabel.textColor = kBlackColor54;
        [_dateLabel setTextAlignment:NSTextAlignmentRight];
        [self.contentView addSubview:_dateLabel];
        
        _nameLabel = [UILabel new];
        _nameLabel.font = [UIFont boldSystemFontOfSize:14.0f];
        _nameLabel.textColor = [UIColor blackColor]; //todo 色テーマ
        [self.contentView addSubview:_nameLabel];
        
        _textLabel = [UILabel new];
        _textLabel.font = SNSTimeLineCellTextFont;
        _textLabel.numberOfLines = 0;
        [self.contentView addSubview:_textLabel];
        
    }
    return self;
}

//- (void)setUser:(SNSTimeLine *)user {
//    _user = user;
//    
//    [_userIconButton sd_setImageWithURL:user.profilePhoto.smallImageUrl
//                               forState:UIControlStateNormal
//                       placeholderImage:[UIImage imageNamed:@"tl_ic_placefolder"]];
//    _nicknameLabel.text = user.nickname;
//}

- (void)_userIconButtonClicked:(UIButton *)sender {
//    if ([self.delegate respondsToSelector:@selector(jumpToUserProfileWithUser:)]) {
//        [self.delegate jumpToUserProfileWithUser:_user];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _userIconButton.frame = CGRectMake(SNSTimeLineCellHorizontalPadding,
                                       SNSTimeLineCellVerticalPadding,
                                       SNSTimeLineCellIconSize.width,
                                       SNSTimeLineCellIconSize.height);
    _userIconButton.layer.cornerRadius = SNSTimeLineCellIconSize.width / 2.0f;
    
    CGFloat maxLabelWidth = kCommonDeviceWidth - _userIconButton.width - SNSTimeLineCellMargin * 2 - SNSTimeLineCellHorizontalPadding * 2;
    CGSize nicknameLabelSize = [_nameLabel sizeThatFits:CGSizeMake(maxLabelWidth, _userIconButton.height)];
    
    _nameLabel.frame = CGRectMake(_userIconButton.right + SNSTimeLineCellMargin,
                                      _userIconButton.y,
                                      nicknameLabelSize.width,
                                      nicknameLabelSize.height);
    _nameLabel.centerY = _userIconButton.centerY;
    
    _nameLabel.y -= SNSTimeLineCellIconSize.height / 4.0f;
    _dateLabel.height = 12.0f;
    _dateLabel.width = [_dateLabel.text getTextWidthWithFont:_dateLabel.font viewHeight:_dateLabel.height] + SNSTimeLineCellSpace * 2;
    _dateLabel.origin = CGPointMake(kCommonDeviceWidth - _dateLabel.width - ( SNSTimeLineCellSpace * 2 ), _nameLabel.y - SNSTimeLineCellSpace);
    
    [_textLabel setSize:CGSizeMake(SNSTimeLineCellMessageWidth, 0)];
    CGFloat height = [_textLabel.text getTextHeightWithFont:_textLabel.font viewWidth:_textLabel.width];
    _textLabel.height = height;
    _textLabel.x = _dateLabel.x;
    _textLabel.y = _userIconButton.bottom + SNSTimeLineCellSpace;
    
    self.contentView.height = _textLabel.bottom;
    
}

+ (CGFloat)cellHeightForObject:(id)object{
    return 75; // todo
}


@end
