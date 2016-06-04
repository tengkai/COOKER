//
//  OurViewController.m
//  COOKER
//
//  Created by BEVER on 16/6/3.
//  Copyright © 2016年 李楠. All rights reserved.
//

#import "OurViewController.h"

@interface OurViewController ()

@end

@implementation OurViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self addAllViews];
}

- (void)addAllViews
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(8, 8, [UIScreen mainScreen].bounds.size.width - 16, [UIScreen mainScreen].bounds.size.height - 16)];
    label.text = @"\t本app所有内容，包括文字、图片、音频、视频、软件、程序、以及版式设计等均在网上搜集。\n\t访问者可将本app提供的内容或服务用于个人学习、研究或欣赏，以及其他非商业性或非盈利性用途，但同时应遵守著作权法及其他相关法律的规定，不得侵犯本app及相关权利人的合法权利。除此以外，将本app任何内容或服务用于其他用途时，须征得本app及相关权利人的书面许可，并支付报酬。\n\t本app内容原作者如不愿意在本app刊登内容，请及时通知本app，予以删除。\n\t地址：山东省济南市\n\t电话：110\n\t电子邮箱：110@qq.com";
    label.numberOfLines = 0;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    CGSize size = [label sizeThatFits:CGSizeMake([UIScreen mainScreen].bounds.size.width - 16, MAXFLOAT)];
    label.frame = CGRectMake(8, 8, [UIScreen mainScreen].bounds.size.width - 16, size.height);
    [self.view addSubview:label];
}



@end
