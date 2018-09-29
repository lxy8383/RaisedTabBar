//
//  LXYTabBar.h
//  LXYRaisedTab
//
//  Created by liuxy on 2018/9/29.
//  Copyright © 2018年 liuxy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LXYTabBar;

@protocol LXYTabBarDelegate <NSObject>

-(void)addButtonClick:(LXYTabBar *)tabBar;

@end

@interface LXYTabBar : UITabBar

@property (nonatomic, weak) id <LXYTabBarDelegate> myDelegate;

@end
