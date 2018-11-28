//
//  TZLAlbumImagePicker.h
//  Demos
//
//  Created by tang on 2018/11/26.
//  Copyright © 2018年 TZL. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef void (^TZLAlbumImagePickerBlock)(UIImage *image);
@interface TZLAlbumImagePicker : NSObject
- (void)getImageWithViewController:(UIViewController *)viewController photoBlock:(TZLAlbumImagePickerBlock)photoBlock;
@end

NS_ASSUME_NONNULL_END
