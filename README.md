## demo
![Alt text](/DeformationButton.gif)

---------------------------------------
## import 
#import "DeformationButton.h"

---------------------------------------
## code
    deformationBtn = [[DeformationButton alloc]initWithFrame:CGRectMake(100, 100, 140, 36)];
    deformationBtn.contentColor = [self getColor:@"52c332"];
    deformationBtn.progressColor = [UIColor whiteColor];
    [self.view addSubview:deformationBtn];
    
    [deformationBtn.forDisplayButton setTitle:@"微信注册" forState:UIControlStateNormal];
    [deformationBtn.forDisplayButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [deformationBtn.forDisplayButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [deformationBtn.forDisplayButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 6, 0, 0)];
    
    [deformationBtn.forDisplayButton setImage:[UIImage imageNamed:@"logo_.png"] forState:UIControlStateNormal];
    UIImage *bgImage = [UIImage imageNamed:@"button_bg.png"];
    [deformationBtn.forDisplayButton setBackgroundImage:[bgImage resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)] forState:UIControlStateNormal];
    
    [deformationBtn addTarget:self action:@selector(btnEvent) forControlEvents:UIControlEventTouchUpInside];

---------------------------------------
### Thanks for [MMMaterialDesignSpinner]
[MMMaterialDesignSpinner]: https://github.com/misterwell/MMMaterialDesignSpinner