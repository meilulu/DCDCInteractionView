//
//  DCRootInteractionVC.m
//  DevelopControls
//
//  Created by 树妖 on 2018/7/20.
//  Copyright © 2018年 树妖. All rights reserved.
//

#import "DCRootInteractionVC.h"
#import "DCInteractionView.h"
@interface DCRootInteractionVC ()

@property BOOL isImageSeleted;
@end

@implementation DCRootInteractionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"点击" style:UIBarButtonItemStyleDone target:self action:@selector(doRightAction)];
    _isImageSeleted = false;
}

- (void)doRightAction {
    NSString *str = @"蒹葭苍苍，白露为霜";
    CGSize size = [str boundingRectWithSize:CGSizeMake(300, 200) options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:24]} context:nil].size;
    DCInteractionView *interactionView = [[DCInteractionView alloc] initWithFrame:CGRectMake(100, 100, size.width+size.height+10, size.height)];
    [interactionView addImage:[UIImage imageNamed:@"checkbox_unselect"] content:str clickableContent:@"白露"];
    [self.view addSubview:interactionView];
    interactionView.textClickEvent = ^{
        NSLog(@"文字被点击");
    };
    __weak typeof (interactionView) weakView = interactionView;
    interactionView.imageClickEvent = ^(NSTextAttachment *attach) {
        NSLog(@"图片被点击");
        self.isImageSeleted = !self.isImageSeleted;
        attach.image = [UIImage imageNamed:self.isImageSeleted?@"checkbox_select":@"checkbox_unselect"];
        [weakView reloadInteractionView];
    };
}

@end
