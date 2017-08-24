//
//  SNSTimeLineCell.m
//  SNS
//
//  Created by Kenta Yokota on 2/4/17.
//  Copyright © 2017 Kenta Yokota. All rights reserved.
//

#import "SNSTimeLineCell.h"
#import "SNSPost.h"


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
    
    UIView  *_baseContentsView;
    UILabel *_textLabel;
    
    UILabel *_dateLabel;
    
}
@end

@implementation SNSTimeLineCell


- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier delegate:(id<SNSTimeLineCellDelegate>)delegate {
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.clipsToBounds = YES;
        self.contentView.clipsToBounds = NO;
        self.delegate = delegate;
        self.selectionStyle = UITableViewCellSelectionStyleNone;

        
        
        self.selectedBackgroundView = [[UIImageView alloc] initWithImage:
                                       [UIImage imageWithColor:[kBlackColor87 colorWithAlphaComponent:0.1f]
                                                      withSize:self.frame.size]]; //todo 色テーマ
        _baseContentsView = [UIView new];
        _baseContentsView.backgroundColor = [UIColor whiteColor];
        _baseContentsView.layer.borderWidth = 0.5f;
        _baseContentsView.layer.borderColor = kSNSBlackColor.CGColor;
        _baseContentsView.layer.cornerRadius = 3.0f;

        [self.contentView addSubview:_baseContentsView];
        self.contentView.backgroundColor = [UIColor clearColor];
        
        _userIconButton = [UIButton new];
        _userIconButton.imageView.contentMode = UIViewContentModeScaleAspectFill;
        _userIconButton.layer.borderColor = [UIColor colorWithHex:0xdddddd].CGColor;
        _userIconButton.clipsToBounds = YES;
        _userIconButton.backgroundColor = [UIColor grayColor];
//        [_userIconButton sd_setImageWithURL:nil
//                                            forState:UIControlStateNormal
//                                    placeholderImage:[UIImage imageNamed:@"tl_ic_placefolder"]];
        
        [_userIconButton addTarget:self action:@selector(_userIconButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [_baseContentsView addSubview:_userIconButton];
        
        _dateLabel = [UILabel new];
        _dateLabel.font = [UIFont systemFontOfSize:12.0f];
        _dateLabel.textColor = kBlackColor54;
        [_dateLabel setTextAlignment:NSTextAlignmentRight];
        [_baseContentsView addSubview:_dateLabel];
        
        _nameLabel = [UILabel new];
        _nameLabel.font = [UIFont boldSystemFontOfSize:14.0f];
        _nameLabel.textColor = [UIColor blackColor]; //todo 色テーマ
        [_baseContentsView addSubview:_nameLabel];
        
        _textLabel = [UILabel new];
        _textLabel.font = SNSTimeLineCellTextFont;
        _textLabel.numberOfLines = 0;

        [_baseContentsView addSubview:_textLabel];
        
        
//        [self addSubview:self.contentView];
        
    }
    return self;
}

- (void)configureWithPost:(SNSPost *)post{
    [_userIconButton sd_setImageWithURL:[NSURL URLWithString:[post picture_url]]
                                   forState:UIControlStateNormal
                           placeholderImage:[UIImage imageNamed:@"tl_ic_placefolder"]];
    _nameLabel.text = [post name];
    _textLabel.text = [post text];    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM-dd hh:mm"];
    NSString *date_converted = [formatter stringFromDate:[post time]];
    _dateLabel.text = date_converted;
    
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
    
    _baseContentsView.frame = CGRectMake(kMargin8,
                                         kMargin8,
                                         kCommonDeviceWidth - kMargin8 * 2,
                                         0);
    
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
    _textLabel.x = _nameLabel.x + SNSTimeLineCellSpace;
    _textLabel.y = _nameLabel.bottom;
    
    self.contentView.height = _textLabel.bottom;
}

+ (CGFloat)cellHeightForObject:(id)object{
    SNSPost * post = object;
    CGFloat textHeight = post.text.length > 0 ? [post.text getTextHeightWithFont:SNSTimeLineCellTextFont viewWidth:SNSTimeLineCellMessageWidth] : 0;
    
    CGFloat minHeight = SNSTimeLineCellIconSize.height + textHeight;
    
    return minHeight;
//    return 75; // todo
}


@end
