//
//  CustomTabBarController.h
//  PRO3
//
//  Created by BEVER on 16/6/2.
//  Copyright © 2016年 李楠. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CustomTabBarItem;

@interface CustomTabBarController : UITabBarController

- (instancetype)initWithSelectedImage:(UIImage *)selectedImage tabBarBackgroundImage:(UIImage *)bgImage;

@end

/*--------------------------------------------------------------------------------*/

@interface CustomTabBarItem : UIButton

/**
 *  通过frame和tabBarItem创建按钮的方法
 */
//- (instancetype)initWithFrame:(CGRect)frame tabBarItem:(UITabBarItem *)tabBarItem;

- (instancetype)initWithFrame:(CGRect)frame tabBarItem:(UITabBarItem *)tabBarItem index:(int)index;

@end

