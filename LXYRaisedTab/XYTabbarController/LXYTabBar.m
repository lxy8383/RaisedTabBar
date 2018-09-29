//
//  LXYTabBar.m
//  LXYRaisedTab
//
//  Created by liuxy on 2018/9/29.
//  Copyright © 2018年 liuxy. All rights reserved.
//

#import "LXYTabBar.h"
#import "UIView+HLExtension.h"

const static CGFloat AddButtonMargin = 20;

@interface LXYTabBar()

// 加号
@property (nonatomic, strong) UIButton *addButton;

@property (nonatomic, strong) UIButton *msButton;
// 标题
@property (nonatomic, strong) UILabel *addLabel;

@end

@implementation LXYTabBar
- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame]){
        //创建中间“+”按钮
        self.addButton = [[UIButton alloc] init];
        UIImage *backImg =  [self coreBlurImage:[UIImage imageNamed:@"gaosi"] withBlurNumber:12.5];
        //设置默认背景图片
        [self.addButton setBackgroundImage:[UIImage imageNamed:@"addIcon-1"] forState:UIControlStateNormal];
        //设置按下时背景图片
        [self.addButton setBackgroundImage:[UIImage imageNamed:@"addIcon-1"] forState:UIControlStateHighlighted];
        //添加响应事件
        [self.addButton addTarget:self action:@selector(addBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
        //将按钮添加到TabBar
        [self addSubview:self.addButton];
        
        // 高斯模糊
        self.msButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.msButton setBackgroundImage:backImg forState:UIControlStateNormal];
        [self addSubview:self.msButton];
        self.msButton.hidden = YES;

        // e
        self.addLabel = [[UILabel alloc]init];
        self.addLabel.backgroundColor = [UIColor blackColor];
        self.addLabel.text = @"添加";
        self.addLabel.font = [UIFont systemFontOfSize:10];
        self.addLabel.textColor = [UIColor grayColor];
        [self.addLabel sizeToFit];
        [self addSubview:self.addLabel];
        self.addLabel.hidden = YES;
        
        
        // 修改tabbar上面细线
        [[UITabBar appearance] setShadowImage:[UIImage new]];
        // 修改tabbar背景图片
        [[UITabBar appearance] setBackgroundImage:[UIImage imageNamed:@"CombinedShape"]];
        
        //自定义分割线颜色
//        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(self.bounds.origin.x-0.5, self.bounds.origin.y, self.bounds.size.width+1, self.bounds.size.height+2)];
//        bgView.layer.borderColor = [UIColor orangeColor].CGColor;
//        bgView.layer.borderWidth = 0.5;
//        [self insertSubview:bgView atIndex:0];
//        self.opaque = YES;
  
    }
    return self;
}

//响应中间“+”按钮点击事件
-(void)addBtnDidClick
{
    if([self.myDelegate respondsToSelector:@selector(addButtonClick:)]){
        [self.myDelegate addButtonClick:self];
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    //去掉TabBar上部的横线
    for (UIView *view in self.subviews){
        
       if ([view isKindOfClass:[UIImageView class]] && view.bounds.size.height <= 1){
            //横线的高度为0.5
                UIImageView *line = (UIImageView *)view;
                line.hidden = YES;
            }
        }
         //设置“+”按钮的位置
        self.addButton.centerX = self.centerX;
        self.addButton.centerY = self.height * 0.5 - 1.5 * AddButtonMargin;
         //设置“+”按钮的大小为图片的大小
        self.addButton.xySize = CGSizeMake(self.addButton.currentBackgroundImage.size.width, self.addButton.currentBackgroundImage.size.height);

    
         //设置“添加”label的位置 （如果需要可以自动调整位置）
//         self.msButton.centerX = self.addButton.centerX;
//         self.addLabmsButtonel.centerY = self.height * 0.3 ;
//         self.msButton.xySize = CGSizeMake(120, 80);
    
    
        int btnIndex = 0;
         //系统自带的按钮类型是UITabBarButton，找出这些类型的按钮，然后重新排布位置，空出中间的位置
        Class class = NSClassFromString(@"UITabBarButton");
         for (UIView *btn in self.subviews) {//遍历TabBar的子控件
                 if ([btn isKindOfClass:class]) {
                     //如果是系统的UITabBarButton，那么就调整子控件位置，空出中间位置
                     //每一个按钮的宽度等于TabBar的三分之一
                     // 5 代表是5个模块
                        btn.width = self.width / 5;
            
                        btn.x = btn.width * btnIndex;
           
                        btnIndex++;
                        //如果索引是2(即“+”按钮)，直接让索引加一
                        if (btnIndex == 2) {
                            btnIndex++;
                        }
            
                }
        }
        //将“+”按钮放到视图层次最前面
         [self bringSubviewToFront:self.addButton];
    
}
//重写hitTest方法，去监听"+"按钮和“添加”标签的点击，目的是为了让凸出的部分点击也有反应
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {

//这一个判断是关键，不判断的话push到其他页面，点击“+”按钮的位置也是会有反应的，这样就不好了
//self.isHidden == NO 说明当前页面是有TabBar的，那么肯定是在根控制器页面
//在根控制器页面，那么我们就需要判断手指点击的位置是否在“+”按钮或“添加”标签上
//是的话让“+”按钮自己处理点击事件，不是的话让系统去处理点击事件就可以了
    if (self.isHidden == NO){
        //将当前TabBar的触摸点转换坐标系，转换到“+”按钮的身上，生成一个新的点
        CGPoint newA = [self convertPoint:point toView:self.addButton];
        //将当前TabBar的触摸点转换坐标系，转换到“添加”标签的身上，生成一个新的点
        CGPoint newL = [self convertPoint:point toView:self.addLabel];
        //判断如果这个新的点是在“+”按钮身上，那么处理点击事件最合适的view就是“+”按钮
        if ( [self.addButton pointInside:newA withEvent:event]){
            return self.addButton;
        }
        //判断如果这个新的点是在“添加”标签身上，那么也让“+”按钮处理事件
        else if([self.addLabel pointInside:newL withEvent:event]){
            return self.addButton;
        }else{
            //如果点不在“+”按钮身上，直接让系统处理就可以了
            return [super hitTest:point withEvent:event];
        }
    }else{
        //TabBar隐藏了，那么说明已经push到其他的页面了，这个时候还是让系统去判断最合适的view处理就好了
        return [super hitTest:point withEvent:event];
    }
}

- (UIImage *)coreBlurImage:(UIImage *)image withBlurNumber:(CGFloat)blur
{
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *inputImage= [CIImage imageWithCGImage:image.CGImage];
    //设置filter
    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];
    [filter setValue:inputImage forKey:kCIInputImageKey]; [filter setValue:@(blur) forKey: @"inputRadius"];
    //模糊图片
    CIImage *result=[filter valueForKey:kCIOutputImageKey];
    CGImageRef outImage=[context createCGImage:result fromRect:[result extent]];
    UIImage *blurImage=[UIImage imageWithCGImage:outImage];
    CGImageRelease(outImage);
    return blurImage;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
