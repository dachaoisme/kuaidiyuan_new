//
//  RCSegmentView.m
//  ProjectOne
//
//  Created by RongCheng on 16/3/31.
//  Copyright © 2016年 JiYue.com. All rights reserved.
//

#import "RCSegmentView.h"
#define lineWidth 20
#define selectedFontSize 17
#define normalFontSize 17


@implementation RCSegmentView
- (instancetype)initWithFrame:(CGRect)frame controllers:(NSArray *)controllers titleArray:(NSArray *)titleArray ParentController:(UIViewController *)parentC
{
    if (self = [super initWithFrame:frame]) {
        self.controllers = controllers;
        self.nameArray = titleArray;

        self.segmentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 44)];
        self.segmentView.tag = 50;
        [self addSubview:self.segmentView];
        self.segmentScrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 44, frame.size.width, frame.size.height - 44)];
        self.segmentScrollV.contentSize = CGSizeMake(frame.size.width * self.controllers.count, 0);
        self.segmentScrollV.delegate = self;
        self.segmentScrollV.showsHorizontalScrollIndicator = NO;
        self.segmentScrollV.pagingEnabled = YES;
        self.segmentScrollV.bounces = NO;
        [self addSubview:self.segmentScrollV];

        for (int i = 0; i < self.controllers.count; i++) {
            UIViewController *contr = self.controllers[i];
            [self.segmentScrollV addSubview:contr.view];
            contr.view.frame = CGRectMake(i * frame.size.width, 0, frame.size.width, CGRectGetHeight(self.segmentScrollV.frame));
            [parentC addChildViewController:contr];
            [contr didMoveToParentViewController:parentC];
        }
        for (int i = 0; i < self.controllers.count; i++) {
            //////////////////////最新和最热两个，所有，在此处对i=0和i=1就行了=控制////////////////////

            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            float leftAndRightSpace = 100 * VMScaleOfCurrentDeviceAndModelDeviceWidth;
            float buttonWidth = 44 * VMScaleOfCurrentDeviceAndModelDeviceWidth;
            float buttonSpace = (SCREEN_WIDTH - leftAndRightSpace * 2 - 3 * buttonWidth)/2;
            if (i == 0) {
                btn.frame = CGRectMake(leftAndRightSpace, 0, buttonWidth, 44);
            } else if (i == 1) {
                btn.frame = CGRectMake( leftAndRightSpace+buttonWidth+buttonSpace, 0, buttonWidth, 44);
            }else if (i == 2) {
                btn.frame = CGRectMake(leftAndRightSpace+buttonWidth*2+buttonSpace*2, 0, buttonWidth, 44);
            }else {
            }

            btn.tag = i;
            [btn setTitle:self.nameArray[i] forState:(UIControlStateNormal)];
            [btn setTitleColor:[CommonUtils colorWithHex:TitleNormalBlackColor] forState:(UIControlStateNormal)];
            [btn setTitleColor:[CommonUtils colorWithHex:@"00c0cc"] forState:(UIControlStateSelected)];
            [btn addTarget:self action:@selector(Click:) forControlEvents:(UIControlEventTouchUpInside)];
            btn.titleLabel.font = JMSystemFont(normalFontSize);
            if (i == 0) {
                btn.selected = YES;
                self.seleBtn = btn;
                btn.titleLabel.font = JMSystemFont(selectedFontSize);
            } else {
                btn.selected = NO;
            }

            [self.segmentView addSubview:btn];
        }
        ///根据需求，无需此灰色线条
        self.down = [[UILabel alloc] initWithFrame:CGRectMake(0, 39.5, frame.size.width, 0.5)];
        self.down.backgroundColor = [UIColor grayColor];
        //[self.segmentView addSubview:self.down];

        ///可以根据个数相除得到宽度
        //self.line=[[UILabel alloc]initWithFrame:CGRectMake(0,37, frame.size.width/self.controllers.count, 3)];
        //也可以把线的宽度写死
        self.line = [[UILabel alloc] initWithFrame:CGRectMake(0, 36, lineWidth, 3)];
        self.line.backgroundColor = [CommonUtils colorWithHex:@"00c0cc"];
        self.line.tag = 100;
        [self.segmentView addSubview:self.line];
        [self updateLineCenter];
    }


    return self;
}
- (void)Click:(UIButton *)sender
{
    self.seleBtn.titleLabel.font = JMSystemFont(selectedFontSize);
    self.seleBtn.selected = NO;
    self.seleBtn = sender;
    self.seleBtn.selected = YES;
    self.seleBtn.titleLabel.font = JMSystemFont(selectedFontSize);
    //    [UIView animateWithDuration:0.2 animations:^{
    //        CGPoint frame = self.line.center;
    //        frame.x = self.frame.size.width / (self.controllers.count * 2) + (self.frame.size.width / self.controllers.count) * (sender.tag);
    //        self.line.center = frame;
    //    }];
    [self.segmentScrollV setContentOffset:CGPointMake((sender.tag) * self.frame.size.width, 0) animated:YES];
    [self updateLineCenter];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SelectVC" object:sender userInfo:nil];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //    [UIView animateWithDuration:0.2 animations:^{
    //        CGPoint frame = self.line.center;
    //        frame.x = self.frame.size.width / (self.controllers.count * 2) + (self.frame.size.width / self.controllers.count) * (self.segmentScrollV.contentOffset.x / self.frame.size.width);
    //        self.line.center = frame;
    //    }];
    UIButton *btn = (UIButton *)[self.segmentView viewWithTag:(self.segmentScrollV.contentOffset.x / self.frame.size.width)];
    self.seleBtn.selected = NO;
    self.seleBtn = btn;
    self.seleBtn.selected = YES;
    [self updateLineCenter];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SelectVC" object:btn userInfo:nil];
}

- (void)updateLineCenter
{
    ///更新红线的位置
    [UIView animateWithDuration:0.1 animations:^{
        self.line.center = CGPointMake(self.seleBtn.center.x, self.line.center.y);
    }];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
