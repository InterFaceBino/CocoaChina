//
//  BNNavigationController.m
//  掌厨
//
//  Created by wo on 15/9/28.
//  Copyright (c) 2015年 wo. All rights reserved.
//

#import "BNNavigationController.h"

@interface BNNavigationController ()

@end

@implementation BNNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
    if (self.viewControllers.count > 0)
    {
        
        UIButton * leftCustrom = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [leftCustrom setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
        
        [leftCustrom addTarget:self action:@selector(leftCustromTouch:) forControlEvents:UIControlEventTouchUpInside];
        
        leftCustrom.frame = CGRectMake(0, 0, 40, 40);
        
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftCustrom];
    }
    
    [super pushViewController:viewController animated:animated];
    
}

- (void)leftCustromTouch:(UIButton *)btn
{
    [self popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
