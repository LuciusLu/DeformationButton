//
//  DeformationButton.m
//  DeformationButton
//
//  Created by LuciusLu on 15/3/16.
//  Copyright (c) 2015年 MOZ. All rights reserved.
//

#import "DeformationButton.h"

@implementation DeformationButton{
    CGFloat defaultW;
    CGFloat defaultH;
    CGFloat defaultR;
    CGFloat scale;
    UIView *bgView;
    UIImage *btnBackgroundImage;
}

- (instancetype)initWithFrame:(CGRect)frame withColor:(UIColor*)color
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSettingWithColor:(UIColor*)color];
    }
    return self;
}

-(CGRect)frame{
    CGRect frame = [super frame];
    self.forDisplayButton.frame = frame;
    return frame;
}

- (UIImage*)imageWithColor:(UIColor*)color cornerRadius:(CGFloat)cornerRadius{
    CGRect rect = CGRectMake(0, 0, cornerRadius*2+10, cornerRadius*2+10);
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:cornerRadius];
    path.lineWidth = 0;
    
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);

    [path fill];
    [path stroke];
    [path addClip];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (void)initSettingWithColor:(UIColor*)color{
    self.clipsToBounds = NO;
    self.layer.masksToBounds = NO;
    
    scale = 1.2;
    bgView = [[UIView alloc]initWithFrame:self.bounds];
    bgView.backgroundColor = color;
    bgView.userInteractionEnabled = NO;
    bgView.hidden = YES;
    bgView.layer.cornerRadius = 3;
    bgView.layer.masksToBounds = NO;
    [self addSubview:bgView];
    
    defaultW = bgView.frame.size.width;
    defaultH = bgView.frame.size.height;
    defaultR = bgView.layer.cornerRadius;
    
    MMMaterialDesignSpinner *spinnerView = [[MMMaterialDesignSpinner alloc] initWithFrame:CGRectZero];
    self.spinnerView = spinnerView;
    self.spinnerView.bounds = CGRectMake(0, 0, defaultH*0.8, defaultH*0.8);
    self.spinnerView.tintColor = [UIColor whiteColor];
    self.spinnerView.lineWidth = 2;
    self.spinnerView.center = CGPointMake(CGRectGetMidX(self.layer.bounds), CGRectGetMidY(self.layer.bounds));
    self.spinnerView.translatesAutoresizingMaskIntoConstraints = NO;
    self.spinnerView.userInteractionEnabled = NO;
    [self addSubview:self.spinnerView];
    
    [self addTarget:self action:@selector(loadingAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.forDisplayButton = [[UIButton alloc]initWithFrame:self.bounds];
    self.forDisplayButton.userInteractionEnabled = NO;
    [self.forDisplayButton setBackgroundImage:[[self imageWithColor:color cornerRadius:3] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)] forState:UIControlStateNormal];
    [self addSubview:self.forDisplayButton];
    
    self.contentColor = color;
}

-(void)setContentColor:(UIColor *)contentColor{
    _contentColor = contentColor;
    bgView.backgroundColor = contentColor;
}

-(void)setProgressColor:(UIColor *)progressColor{
    _progressColor = progressColor;
    self.spinnerView.tintColor = progressColor;
}

-(void)setIsLoading:(BOOL)isLoading{
    _isLoading = isLoading;
    if (_isLoading) {
        [self startLoading];
    }else{
        [self stopLoading];
    }
}

- (void)loadingAction{
    if (self.isLoading) {
        [self stopLoading];
    }else{
        [self startLoading];
    }
}

- (void)startLoading{
    if (btnBackgroundImage == nil) {
        btnBackgroundImage = [self.forDisplayButton backgroundImageForState:UIControlStateNormal];
    }
    
    _isLoading = YES;
    
    bgView.hidden = NO;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"cornerRadius"];
    animation.timingFunction = [CAMediaTimingFunction     functionWithName:kCAMediaTimingFunctionLinear];
    animation.fromValue = [NSNumber numberWithFloat:defaultR];
    animation.toValue = [NSNumber numberWithFloat:defaultH*scale*0.5];
    animation.duration = 0.3;
    [bgView.layer setCornerRadius:defaultH*scale*0.5];
    [bgView.layer addAnimation:animation forKey:@"cornerRadius"];

    [self.forDisplayButton setBackgroundImage:nil forState:UIControlStateNormal];
    
    [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
        bgView.layer.bounds = CGRectMake(0, 0, defaultW*scale, defaultH*scale);
    } completion:^(BOOL finished) {
        if (_isLoading) {
            [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
                bgView.layer.bounds = CGRectMake(0, 0, defaultH*scale, defaultH*scale);
                self.forDisplayButton.transform = CGAffineTransformMakeScale(0, 0);
                self.forDisplayButton.alpha = 0;
            } completion:^(BOOL finished) {
                if (_isLoading) {
                    self.forDisplayButton.hidden = YES;
                    [self.spinnerView startAnimating];
                }
            }];
        }
    }];
}

- (void)stopLoading{
    [self.spinnerView stopAnimating];
    self.forDisplayButton.hidden = NO;
    
    _isLoading = NO;

    [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:0 options:
     UIViewAnimationOptionCurveLinear animations:^{
        self.forDisplayButton.transform = CGAffineTransformMakeScale(1, 1);
        self.forDisplayButton.alpha = 1;
    } completion:^(BOOL finished) {
    }];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"cornerRadius"];
    animation.timingFunction = [CAMediaTimingFunction     functionWithName:kCAMediaTimingFunctionLinear];
    animation.fromValue = [NSNumber numberWithFloat:defaultH*scale*0.5];
    animation.toValue = [NSNumber numberWithFloat:defaultR];
    animation.duration = 0.3;
    [bgView.layer setCornerRadius:defaultR];
    [bgView.layer addAnimation:animation forKey:@"cornerRadius"];
    
    [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
        bgView.layer.bounds = CGRectMake(0, 0, defaultW*scale, defaultH*scale);
    } completion:^(BOOL finished) {
        if (!_isLoading) {
            CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"cornerRadius"];
            animation.timingFunction = [CAMediaTimingFunction     functionWithName:kCAMediaTimingFunctionLinear];
            animation.fromValue = [NSNumber numberWithFloat:bgView.layer.cornerRadius];
            animation.toValue = [NSNumber numberWithFloat:defaultR];
            animation.duration = 0.3;
            [bgView.layer setCornerRadius:defaultR];
            [bgView.layer addAnimation:animation forKey:@"cornerRadius"];
            [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
                bgView.layer.bounds = CGRectMake(0, 0, defaultW, defaultH);
            } completion:^(BOOL finished) {
                if (!_isLoading) {
                    if (btnBackgroundImage != nil) {
                        [self.forDisplayButton setBackgroundImage:btnBackgroundImage forState:UIControlStateNormal];
                    }
                    bgView.hidden = YES;
                    //            _isLoading = NO;
                }
            }];
        }
    }];
}

-(void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    [self.forDisplayButton setSelected:selected];
}

- (void)setHighlighted:(BOOL)highlighted{
    [super setHighlighted:highlighted];
    [self.forDisplayButton setHighlighted:highlighted];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
