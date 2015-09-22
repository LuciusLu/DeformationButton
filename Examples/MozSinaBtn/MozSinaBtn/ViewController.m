//
//  ViewController.m
//  DeformationButton
//
//  Created by LuciusLu on 15/3/16.
//  Copyright (c) 2015年 MOZ. All rights reserved.
//

#import "ViewController.h"
#import "DeformationButton.h"

@interface ViewController (){
    DeformationButton *deformationBtn;
}

@end

@implementation ViewController

- (UIColor *)getColor:(NSString *)hexColor
{
    unsigned int red,green,blue;
    NSRange range;
    range.length = 2;
    
    range.location = 0;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&red];
    
    range.location = 2;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&green];
    
    range.location = 4;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&blue];
    
    return [UIColor colorWithRed:(float)(red/255.0f) green:(float)(green / 255.0f) blue:(float)(blue / 255.0f) alpha:1.0f];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    deformationBtn = [[DeformationButton alloc]initWithFrame:CGRectMake(100, 100, 140, 36) withColor:[self getColor:@"e13536"]];
    [self.view addSubview:deformationBtn];

    [deformationBtn.forDisplayButton setTitle:@"微博注册" forState:UIControlStateNormal];
    [deformationBtn.forDisplayButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [deformationBtn.forDisplayButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [deformationBtn.forDisplayButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 6, 0, 0)];
    [deformationBtn.forDisplayButton setImage:[UIImage imageNamed:@"微博logo.png"] forState:UIControlStateNormal];

    [deformationBtn addTarget:self action:@selector(btnEvent) forControlEvents:UIControlEventTouchUpInside];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(testTap)];
    [self.view addGestureRecognizer:tap];
}

- (void)testTap{
    NSLog(@"testTap");
}

- (void)btnEvent{
    NSLog(@"btnEvent");
//    deformationBtn.isLoading = NO;
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
//    deformationBtn.isLoading = !deformationBtn.isLoading;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
