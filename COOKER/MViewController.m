//
//  MenuViewController.m
//  01侧滑控制器
//
//  Created by CORYIL on 16/3/9.
//  Copyright © 2016年 徐锐. All rights reserved.
//

#import "MViewController.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

#define kLeftSpace kScreenWidth/5*4

@interface MViewController ()

@end

@implementation MViewController


- (instancetype)initWithCenterViewController:(UIViewController *)centerViewController
                          leftViewController:(UIViewController *)leftViewController{
    
    if (self = [super init]) {
        
        _centerViewController = centerViewController;
        
        _leftViewController = leftViewController;
        
        /**
         *  现在位于视图控制器MenuViewController的M文件中
         
            父视图就是self.view 也就是MenuVC的根视图
         
            left view 在下 center view 在上 当调用侧滑事件时,center view向右平移
         */
        
    }
    return self;
    
}

- (instancetype)initWithCenterViewController:(UIViewController *)centerViewController{

    if (self = [super init]) {
        
        _centerViewController = centerViewController;
        
    }
    return self;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (_leftViewController) {
        
        [self.view addSubview:_leftViewController.view];

        
    }

    [self.view addSubview:_centerViewController.view];


}

- (void)showLeftVC{
    
    //判断中央控制器的view的偏移量
    
    //如果为0 --> 没有侧滑 -->开始侧滑
    if (_centerViewController.view.frame.origin.x == 0) {
        
        [UIView animateWithDuration:0.3 animations:^{
            
            _centerViewController.view.frame = CGRectMake(kLeftSpace, 0, _centerViewController.view.frame.size.width, _centerViewController.view.frame.size.height);
            
        }];
        
        //如果不为0 --> 已经侧滑了 --> 还原
    }else{
    
        [self showCenterVC];
    }
    


}

- (void)showCenterVC{
    
    

    [UIView animateWithDuration:0.3 animations:^{
       
        _centerViewController.view.frame = self.view.bounds;
        
    }];

}


@end
