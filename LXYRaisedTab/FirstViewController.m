//
//  FirstViewController.m
//  LXYRaisedTab
//
//  Created by liuxy on 2018/9/29.
//  Copyright © 2018年 liuxy. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *img = [[UIImageView alloc]init];
    img.image = [UIImage imageNamed:@"hello"];
    img.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height + 100);
    [self.view addSubview:img];
    img.contentMode = UIViewContentModeScaleAspectFill;
    
//    self.view.backgroundColor = [UIColor grayColor];
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
