//
//  MenuViewController.h
//  01侧滑控制器
//
//  Created by CORYIL on 16/3/9.
//  Copyright © 2016年 徐锐. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MViewController : UIViewController

@property (nonatomic,strong) UIViewController *leftViewController;

@property (nonatomic,strong) UIViewController *centerViewController;

//@property (nonatomic,strong) UIViewController *rigthViewController;


/**
 *  通过视图控制器创建侧滑控制器
 *
 *  @param centerViewController 中心视图控制器
 *  @param leftViewController   左侧视图控制器
 *
 *  @return 侧滑控制器
 */
- (instancetype)initWithCenterViewController:(UIViewController *)centerViewController
                          leftViewController:(UIViewController *)leftViewController;

/**
 *  左侧滑和还原功能
 */
- (void)showLeftVC;

/**
 *  显示中心控制器
 */
- (void)showCenterVC;

@end
