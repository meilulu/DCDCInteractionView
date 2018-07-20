//
//  DCInteractionView.m
//  Objective-CDemo
//
//  Created by 树妖 on 2018/7/19.
//  Copyright © 2018年 树妖. All rights reserved.
//

#import "DCInteractionView.h"
@interface DCInteractionView ()<UITextViewDelegate>
@property (strong, nonatomic) UITextView *textView;

@property (strong, nonatomic) NSMutableAttributedString *attributedContent;
@end
@implementation DCInteractionView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.textView = [[UITextView alloc] initWithFrame:self.bounds];
        self.textView.delegate = self;
        self.textView.editable = false;
        self.textView.scrollEnabled = false;
        self.textView.textContainerInset = UIEdgeInsetsMake(0, 0, 0, 0);
        [self addSubview:self.textView];
    }
    return self;
}

- (void)reloadInteractionView {
    self.textView.attributedText = self.attributedContent;
}

- (void)addImage:(UIImage *)image content:(NSString *)content clickableContent:(NSString *)clickableContent{
    
    self.attributedContent = [[NSMutableAttributedString alloc] init];
    
    if (image) {
        NSTextAttachment *attach = [NSTextAttachment new];
        attach.image = image;
        attach.bounds = CGRectMake(0, 0, self.bounds.size.height, self.bounds.size.height);
        NSAttributedString *attrStr = [NSAttributedString attributedStringWithAttachment:attach];
        [self.attributedContent insertAttributedString:attrStr atIndex:0];
    }
    
    NSMutableAttributedString *stringPart = [[NSMutableAttributedString alloc] initWithString:content];
    NSRange range = [content rangeOfString:clickableContent];
    if (range.location != NSNotFound) {
        [stringPart addAttribute:NSLinkAttributeName value:@"click://" range:range];
        [stringPart addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:range];
    }
    
    [stringPart addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:24] range:NSMakeRange(0, content.length)];
    [stringPart addAttribute:NSBaselineOffsetAttributeName value:@3 range:NSMakeRange(0, content.length)];//距离底部的偏移，否则文字底部有点被遮挡
    [self.attributedContent appendAttributedString:stringPart];
    
    self.textView.attributedText = self.attributedContent;
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange interaction:(UITextItemInteraction)interaction{
    if ([[URL scheme] isEqualToString:@"click"]) {
        if (self.textClickEvent) {
            self.textClickEvent();
        }
        return false;
    }
    
    return true;
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithTextAttachment:(NSTextAttachment *)textAttachment inRange:(NSRange)characterRange interaction:(UITextItemInteraction)interaction {
    if (self.imageClickEvent) {
        self.imageClickEvent(textAttachment);
    }
    
    return true;
}
@end
