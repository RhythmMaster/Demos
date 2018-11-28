//
//  TZLSystemAlbumViewController.m
//  Demos
//
//  Created by tang on 2018/11/26.
//  Copyright © 2018年 TZL. All rights reserved.
//

#import "TZLSystemAlbumViewController.h"
#import "TZLAlbumImagePicker.h"

#import "UIImage+TZLCircleImage.h"

@interface TZLSystemAlbumViewController ()
/**  */
@property(nonatomic, strong) UIImageView *headView;
@property(nonatomic, strong) TZLAlbumImagePicker *picker;
@end

@implementation TZLSystemAlbumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(100, 100, 150, 50);
    [self.view addSubview:button];
    [button setTitle:@"上传照片" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(modifyAction1) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *headView = [UIImageView new];
    [self.view addSubview:headView];
    [headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(0);
        make.size.equalTo(CGSizeMake(100, 100));
    }];
    self.headView = headView;
}
- (void)modifyAction1 {
    WK(weakSelf);
    TZLAlbumImagePicker *picker = [[TZLAlbumImagePicker alloc] init];
    [picker getImageWithViewController:self photoBlock:^(UIImage * _Nonnull image) {
        weakSelf.headView.image = [image circleImage];
    }];
    _picker = picker;//必须设置为全局的 不然按照正常 到这里 picker已经被释放了,代理就不会执行了
}


@end
