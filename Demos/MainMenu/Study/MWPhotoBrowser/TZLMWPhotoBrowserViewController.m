//
//  TZLMWPhotoBrowserViewController.m
//  Demos
//
//  Created by tang on 2018/12/28.
//  Copyright © 2018年 TZL. All rights reserved.
//

#import "TZLMWPhotoBrowserViewController.h"


@interface TZLMWPhotoBrowserViewController ()<MWPhotoBrowserDelegate>
@property (nonatomic,retain) NSMutableArray *photosArray;
@property (nonatomic,retain) NSMutableArray *thumbArray;
@property (nonatomic,retain) NSMutableArray *selectedArray;

@end

@implementation TZLMWPhotoBrowserViewController

- (void)viewDidLoad {
    [self initPhotos];
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
}

- (void)initPhotos{
    //先清空数组
    self.photosArray = [NSMutableArray new];
    self.thumbArray = [NSMutableArray new];
    self.selectedArray = [NSMutableArray new];
    self.photosArray = @[@"https://timg01.bdimg.com/timg?pacompress&imgtype=1&sec=1439619614&autorotate=1&di=621448919ca3f6d24e690225a5f82264&quality=90&size=b870_10000&src=http%3A%2F%2Fbos.nj.bpc.baidu.com%2Fv1%2Fmediaspot%2F0ea7d028e656b4899b8cd93d22f52a52.jpeg",
                         @"https://timg01.bdimg.com/timg?pacompress&imgtype=1&sec=1439619614&autorotate=1&di=f6e54b588125890fe3011d44067fb3ad&quality=90&size=b870_10000&src=http%3A%2F%2Fbos.nj.bpc.baidu.com%2Fv1%2Fmediaspot%2F827fd7a4fe44b97c55b8c8ba3db10ba0.jpeg",
                         @"https://timg01.bdimg.com/timg?pacompress&imgtype=1&sec=1439619614&autorotate=1&di=a3c988e69d42c15f2f2249434bbe4915&quality=90&size=b870_10000&src=http%3A%2F%2Fbos.nj.bpc.baidu.com%2Fv1%2Fmediaspot%2F9f9b6d10c6c5035b1b80507e223678df.jpeg"].mutableCopy;
    self.delegate = self;
//    [self reloadData];
    
}
#pragma mark - MWPhotosBrowserDelegate
//必须实现的方法
- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser{
    return  self.photosArray.count;
}
- (id<MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index{
    
    if (index < self.photosArray.count) {
        return [MWPhoto photoWithURL:[NSURL URLWithString:[self.photosArray objectAtIndex:index]]];
    }
    return nil;
}
//可选方法
- (void)photoBrowser:(MWPhotoBrowser *)photoBrowser didDisplayPhotoAtIndex:(NSUInteger)index{
    NSLog(@"当前显示图片编号----%ld",index);
}
- (void)photoBrowser:(MWPhotoBrowser *)photoBrowser actionButtonPressedForPhotoAtIndex:(NSUInteger)index{
    NSLog(@"分享按钮的点击方法----%ld",index);
}

- (BOOL)photoBrowser:(MWPhotoBrowser *)photoBrowser isPhotoSelectedAtIndex:(NSUInteger)index{
    //浏览图片时是图片是否选中状态
    return NO;
}
- (void)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index selectedChanged:(BOOL)selected{
    
    //selected表示是否选中
    if (selected) {
        
        [self.selectedArray addObject:@(index)];
        NSLog(@"第%ld张图片在被选中",index);
    }else{
        
        [self.selectedArray removeObject:@(index)];
        NSLog(@"第%ld张图片在被选中",index);
    }
    
    
}
//有navigationBar时title才会显示
//- (NSString *)photoBrowser:(MWPhotoBrowser *)photoBrowser titleForPhotoAtIndex:(NSUInteger)index{
//
//    NSString *str = nil;
//    switch (index) {
//        case 0 :
//            str = @"这是第111张图片";
//            break;
//        case 1 :
//            str = @"这是第222张图片";
//            break;
//        case 2 :
//            str = @"这是第333张图片";
//            break;
//        default:
//            break;
//    }
//    return str
//    ;
//}
//如果要看缩略图必须实现这个方法
//- (id<MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser thumbPhotoAtIndex:(NSUInteger)index{
//    return [self.thumbArray objectAtIndex:index];
//}
//-(void)photoBrowserDidFinishModalPresentation:(MWPhotoBrowser *)photoBrowser{
//    
//    [self dismissViewControllerAnimated:YES completion:nil];
//}

@end
