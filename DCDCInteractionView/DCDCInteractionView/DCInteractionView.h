//
//  DCInteractionView.h
//  Objective-CDemo
//
//  Created by 树妖 on 2018/7/19.
//  Copyright © 2018年 树妖. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DCInteractionView : UIView

@property (copy, nonatomic) void(^imageClickEvent)(NSTextAttachment *attach);
@property (copy, nonatomic) void(^textClickEvent)(void);

- (void)addImage:(UIImage *)image content:(NSString *)content clickableContent:(NSString *)clickableContent;
- (void)reloadInteractionView;
@end
