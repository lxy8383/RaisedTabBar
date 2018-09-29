//
//  LXYTabBarController.m
//  LXYRaisedTab
//
//  Created by liuxy on 2018/9/29.
//  Copyright © 2018年 liuxy. All rights reserved.
//

#import "LXYTabBarController.h"
#import "ViewController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "AddViewController.h"
#import "FourViewController.h"
#import "LXYTabBar.h"
@interface LXYTabBarController () <LXYTabBarDelegate>

@end

@implementation LXYTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化两个视图控制器
    FirstViewController *oneVc = [[FirstViewController alloc]init];
    SecondViewController *twoVc = [[SecondViewController alloc]init];
    ViewController *threeVc = [[ViewController alloc]init];
    FourViewController *fourVc = [[FourViewController alloc]init];
    
    //为两个视图控制器添加导航栏控制器
    UINavigationController *navOne = [[UINavigationController alloc]initWithRootViewController:oneVc];
    UINavigationController *navTwo = [[UINavigationController alloc]initWithRootViewController:twoVc];
    UINavigationController *navthree = [[UINavigationController alloc]initWithRootViewController:threeVc];
    UINavigationController *navfour = [[UINavigationController alloc]initWithRootViewController:fourVc];
    
    //设置控制器文字
    navOne.title = @"首页";
    navTwo.title = @"个人中心";
    navthree.title = @"wocao";
    navfour.title = @"认证";
    
    //设置控制器图片(使用imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal,不被系统渲染成蓝色)
    navOne.tabBarItem.image = [[UIImage imageNamed:@"icon_home_bottom_statist"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    navTwo.tabBarItem.selectedImage = [[UIImage imageNamed:@"icon_home_bottom_statist_hl"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    navthree.tabBarItem.image = [[UIImage imageNamed:@"icon_home_bottom_search"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    navfour.tabBarItem.selectedImage = [[UIImage imageNamed:@"icon_home_bottom_search_hl"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //改变tabbarController 文字选中颜色(默认渲染为蓝色)
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName:[UIColor lightGrayColor]} forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName:[UIColor redColor]} forState:UIControlStateSelected];
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName:[UIColor redColor]} forState:UIControlStateSelected];
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName:[UIColor redColor]} forState:UIControlStateSelected];
    
    //创建一个数组包含四个导航栏控制器
    NSArray *vcArry = [NSArray arrayWithObjects:navOne,navTwo,navthree,navfour,nil];
    
    //将数组传给UITabBarController
    self.viewControllers = vcArry;
    
    //创建自定义TabBar
    LXYTabBar *myTabBar = [[LXYTabBar alloc] init];
    myTabBar.myDelegate = self;

    //利用KVC替换默认的TabBar
    [self setValue:myTabBar forKey:@"tabBar"];

}

-(void)addButtonClick:(LXYTabBar *)tabBar
{
    
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
