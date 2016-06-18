//
//  InformGetCourierViewController.h
//  kuaidiyuan
//
//  Created by 王园园 on 16/6/18.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "BaseViewController.h"

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "ZBarSDK.h"


@interface InformGetCourierViewController : BaseViewController<ZBarReaderViewDelegate,UIImagePickerControllerDelegate>
{
    ZBarCameraSimulator *cameraSim;
    UIButton *btnOpenLight;
    BOOL lightOpenClose;
    int num;
    BOOL upOrdown;
    NSTimer * timer;
    ZBarSymbol* symbol;
    NSString* codeMessage;
    BOOL isOn;
}


///展示摄像图的
@property (weak, nonatomic) IBOutlet ZBarReaderView *camerView;


@property (assign, nonatomic) int mark;
@property (nonatomic, strong) UIImageView * line;


@end
