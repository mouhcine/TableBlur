//
//  EAMBlurredCell.m
//  TableBlur
//
//  Created by Mouhcine El Amine on 15/10/13.
//  Copyright (c) 2013 Mouhcine El Amine. All rights reserved.
//

#import "EAMBlurredCell.h"
#import "UIImage+REFrostedViewController.h"

static CGFloat const EAMBlurredCellPadding = 10.0f;
static CGFloat const EAMBlurredCellBlurRadius = 10.0f;
static CGFloat const EAMBlurredCellSaturationDeltaFactor = 1.8f;

@interface EAMBlurredCell ()

@property (nonatomic, strong) UIScrollView *blurredScrollView;
@property (nonatomic, strong) UIScrollView *normalScrollView;

@end

@implementation EAMBlurredCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self.contentView addSubview:self.normalScrollView];
        [self.contentView addSubview:self.blurredScrollView];
    }
    return self;
}

-(UIScrollView *)normalScrollView
{
    if (!_normalScrollView) {
        _normalScrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _normalScrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _normalScrollView.scrollEnabled = NO;
        UIImageView *imageView =[[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        imageView.contentMode = UIViewContentModeScaleToFill;
        imageView.image = [EAMBlurredCell normalImage];
        _normalScrollView.contentSize = imageView.frame.size;
        [_normalScrollView addSubview:imageView];
    }
    return _normalScrollView;
}

-(UIScrollView *)blurredScrollView
{
    if (!_blurredScrollView) {
        _blurredScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(EAMBlurredCellPadding, EAMBlurredCellPadding,
                                                                            self.bounds.size.width - 2.0f * EAMBlurredCellPadding,
                                                                            self.bounds.size.height - 2.0f * EAMBlurredCellPadding)];
        _blurredScrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _blurredScrollView.scrollEnabled = NO;
        _blurredScrollView.contentOffset = CGPointMake(EAMBlurredCellPadding, EAMBlurredCellPadding);
        UIImageView *imageView =[[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        imageView.contentMode = UIViewContentModeScaleToFill;
        imageView.image = [EAMBlurredCell blurredImage];
        _blurredScrollView.contentSize = imageView.frame.size;
        [_blurredScrollView addSubview:imageView];
    }
    return _blurredScrollView;
}

-(void)setBlurredContentOffset:(CGFloat)offset
{
    self.normalScrollView.contentOffset = CGPointMake(self.normalScrollView.contentOffset.x, offset);
    self.blurredScrollView.contentOffset = CGPointMake(self.blurredScrollView.contentOffset.x, offset + EAMBlurredCellPadding);
}

+(UIImage *)normalImage
{
    static dispatch_once_t onceToken;
    static UIImage *_normalImage;
    dispatch_once(&onceToken, ^{
        _normalImage = [UIImage imageNamed:@"bg.png"];
    });
    return _normalImage;
}

+(UIImage *)blurredImage
{
    static dispatch_once_t onceToken;
    static UIImage *_blurredImage;
    dispatch_once(&onceToken, ^{
        _blurredImage = [[UIImage imageNamed:@"bg.png"] re_applyBlurWithRadius:EAMBlurredCellBlurRadius
                                                                     tintColor:[UIColor colorWithWhite:1.0f
                                                                                                 alpha:0.4f]
                                                         saturationDeltaFactor:1.8f
                                                                     maskImage:nil];
    });
    return _blurredImage;
}

@end
