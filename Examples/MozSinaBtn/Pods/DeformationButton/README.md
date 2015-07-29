## demo

![Alt text](/DeformationButton.gif)
![Alt text](/DeformationButton2.gif)

---------------------------------------
## import 
#import "DeformationButton.h"

---------------------------------------
## code
    DeformationButton *deformationBtn = [[DeformationButton alloc]initWithFrame:CGRectMake(100, 100, 140, 36) withColor:[self getColor:@"e13536"]];
    [self.view addSubview:deformationBtn];

    [deformationBtn.forDisplayButton setTitle:@"微博注册" forState:UIControlStateNormal];
    [deformationBtn.forDisplayButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [deformationBtn.forDisplayButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [deformationBtn.forDisplayButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 6, 0, 0)];
    [deformationBtn.forDisplayButton setImage:[UIImage imageNamed:@"微博logo.png"] forState:UIControlStateNormal];

    [deformationBtn addTarget:self action:@selector(btnEvent) forControlEvents:UIControlEventTouchUpInside];

---------------------------------------
### Thanks for [MMMaterialDesignSpinner]
[MMMaterialDesignSpinner]: https://github.com/misterwell/MMMaterialDesignSpinner