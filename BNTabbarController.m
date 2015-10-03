//
//  BNTabbarController.m
//  掌厨
//
//  Created by wo on 15/9/28.
//  Copyright (c) 2015年 wo. All rights reserved.
//

#import "BNTabbarController.h"
#import "BNNavigationController.h"


#import "BNAllController.h"
#import "BNSecondController.h"
#import "BNFoundController.h"
#import "BNMineController.h"


@interface BNTabbarController ()
{
    BOOL centerButtonhide;
}

@property (nonatomic,strong) NSMutableArray *muViewController;

@property (nonatomic,strong)UIView * topView;

@property (nonatomic,strong) UIView *vic;

@property (nonatomic,strong) UIButton *centerButton;


@end

@implementation BNTabbarController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    _muViewController = [[NSMutableArray alloc]init];
    
    
    BNAllController *all = [[BNAllController alloc]init];
    [self setItemWithController:all title:@"综合" imageName:@"tabbar-news.png" selectedImage:@"tabbar-news-selected.png"];
    
    BNSecondController  *second = [[BNSecondController alloc]init];
    [self setItemWithController:second title:@"动弹" imageName:@"tabbar-tweet.png" selectedImage:@"tabbar-tweet-selected.png"];
    
    [_muViewController addObject:[UIViewController new]];
    
    BNFoundController *found = [[BNFoundController alloc]init];
    [self setItemWithController:found title:@"发现" imageName:@"tabbar-discover.png" selectedImage:@"tabbar-discover-selected.png"];
    
    BNMineController *mine = [[BNMineController alloc]init];
    [self setItemWithController:mine title:@"我" imageName:@"tabbar-me.png" selectedImage:@"tabbar-me-selected.png"];
    
    
    _topView = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height+250,self.view.frame.size.width,200)];
//    _topView.alpha = 0.5;
    _topView.backgroundColor = [UIColor colorWithRed:201.0/255.0 green:206.0/255.0 blue:209.0/255.0 alpha:0.5];
    [self.view addSubview:_topView];

    
    CGFloat btnX = 30;
    CGFloat btnY = 20;
    CGFloat btnW = 60;
    CGFloat btnH = 60;
    
    NSArray *topViewButtonImageArray = [NSArray arrayWithObjects:@"tweetEditing.png",@"picture.png",@"shooting.png",@"sound.png",@"scan.png",@"search.png", nil];
    
    NSArray *topViewButtonColor = @[[UIColor colorWithRed:221.0/255.0 green:134.0/255.0 blue:80.0/255.0 alpha:1],[UIColor colorWithRed:24.0/255.0 green:158.0/255.0 blue:86.0/255.0 alpha:1],[UIColor colorWithRed:32.0/255.0 green:143.0/255.0 blue:179.0/255.0 alpha:1],[UIColor colorWithRed:228.0/255.0 green:76.0/255.0 blue:80.0/255.0 alpha:1],[UIColor colorWithRed:82.0/255.0 green:173.0/255.0 blue:85.0/255.0 alpha:1],[UIColor colorWithRed:236.0/255.0 green:190.0/255.0 blue:16.0/255.0 alpha:1]];
    
    NSArray *topViewButtonName = @[@"文字",@"相册",@"拍摄",@"语音",@"扫一扫",@"找人"];
    
    for(int i = 0; i<6 ; i++){
    
        UIButton  *btn = [[UIButton alloc]initWithFrame:CGRectMake(btnX, btnY,btnW, btnH)];
       
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 15, 30, 30)];
        imageView.image = [UIImage imageNamed:topViewButtonImageArray[i]];
        [btn addSubview:imageView];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(7, 65, 50, 10)];
        label.text = topViewButtonName[i];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:14];
        [btn addSubview:label];
       
        btn.layer.cornerRadius = 30.0;
        
        btn.backgroundColor = topViewButtonColor[i];
        
        btn.alpha = 1.0;
        
        i % 3 !=2  ? (btnX += (60+70)):(btnX = 30,(btnY += (60 +40)));
        
        btn.tag = i;
        
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [_topView addSubview:btn];
        
    }
    
    
    self.viewControllers = [NSArray arrayWithArray:_muViewController];

    _centerButton = [[UIButton alloc]initWithFrame:CGRectMake(self.view.center.x-20, 5, 40, 40)];
    [self.tabBar addSubview:_centerButton];
    _centerButton.layer.cornerRadius = 20.0;
    _centerButton.backgroundColor = [UIColor colorWithRed:42.0/255.0 green:154.0/255.0 blue:54.0/255.0 alpha:1];
    [_centerButton setBackgroundImage:[UIImage imageNamed:@"tabbar-more.png"] forState:UIControlStateNormal];
    [_centerButton addTarget:self action:@selector(centerButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *btn = _topView.subviews [1];
    NSLog(@"1%@,2%@",btn,_topView.subviews[1]);
    
}


-(void)btnClick :(UIButton *)btn{
    NSLog(@"%ld",btn.tag);
}

-(void)centerButtonClick :(UIButton *)btn{
    if (!centerButtonhide) {
        
        for (int i = 0; i< 6; i++) {
            UIButton *anBtn =_topView.subviews[i];
            CGRect size = anBtn.frame;
            
            
            [UIView transitionWithView:self.view duration:0.5 options:0 animations:^{
                _centerButton.transform = CGAffineTransformMakeRotation(45 *M_PI / 180.0);
                
                _topView.frame = CGRectMake(0, self.view.frame.size.height-300,self.view.frame.size.width,200);
                anBtn.frame = CGRectMake(size.origin.x, size.origin.y-20,60,60);
                [_topView addSubview:anBtn];
                
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.5 animations:^{
                    _topView.frame = CGRectMake(0, self.view.frame.size.height-250,self.view.frame.size.width,200);
                    anBtn.frame = CGRectMake(size.origin.x, size.origin.y,60,60);
                }];
            }];
        }
        
//        [UIView transitionWithView:_topView duration:0.5 options:0 animations:^{
//            _centerButton.transform = CGAffineTransformMakeRotation(45 *M_PI / 180.0);
//            _topView.frame = CGRectMake(0, self.view.frame.size.height-300,self.view.frame.size.width,200);
//        } completion:^(BOOL finished) {
//            [UIView animateWithDuration:0.5 animations:^{
//                _topView.frame = CGRectMake(0, self.view.frame.size.height-250,self.view.frame.size.width,200);
//            }];
//        }];
        centerButtonhide = !centerButtonhide;
    }
    else{
        [UIView animateWithDuration:0.5 animations:^{
            _centerButton.transform = CGAffineTransformMakeRotation(0 *M_PI / 180.0);
            
            _topView.frame = CGRectMake(0, self.view.frame.size.height+250,self.view.frame.size.width,200);
        }];
        centerButtonhide = !centerButtonhide;
    }
}


-(void)setItemWithController:(UIViewController *)controller title:(NSString *)title imageName:(NSString *)imageName selectedImage:(NSString *)selectedImage{

    if (self.viewControllers.count == 2) {
        [self addChildViewController:[UIViewController new]];
        return;
    }
    
    controller.tabBarItem.title = title;
    controller.tabBarItem.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    controller.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    controller.navigationItem.title = title;
    controller.view.backgroundColor = [UIColor whiteColor];
    

    NSDictionary * attributes = @{NSForegroundColorAttributeName:[UIColor colorWithRed:42.0/255.0 green:154.0/255.0 blue:54.0/255.0 alpha:1]};
    [controller.tabBarItem setTitleTextAttributes:attributes forState:UIControlStateSelected];
    
    BNNavigationController *nav = [[BNNavigationController alloc]initWithRootViewController:controller];
    nav.navigationBar.barTintColor = [UIColor colorWithRed:42.0/255.0 green:154.0/255.0 blue:54.0/255.0 alpha:1];

    [_muViewController addObject:nav];
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
