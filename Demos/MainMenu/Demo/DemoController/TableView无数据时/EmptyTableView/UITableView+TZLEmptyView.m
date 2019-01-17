//
//  UITableView+TZLEmptyView.m
//  Demos
//
//  Created by tang on 2019/1/10.
//  Copyright © 2019年 TZL. All rights reserved.
//
//第一种思路:利用 tzl_emptyReload 方法去刷新 在刷新之前 可以通过对DataSource判断 有无数据
// 优点: 不用去使用swizz 方法交换
// 缺点: 缺点比较明显,所有的 reload 方法都得换成 tzl_emptyReload 方法 如果是新项目还好 在写的时候 自己注意 使用tzl_emptyReload就好了 ,但如果是老项目的话 要替换 很多reload 这个 不光工作量增加 还可能有些没修改到 ,所以有了第二种思路
//第二种思路:使用swizz 方法交换

//FIXME:使用第一种的时候记得把swizz的交换代码注释了

#import "UITableView+TZLEmptyView.h"

@interface TZLEmptyView : UIView

@property (nonatomic) UIButton *refreshBtn;

- (instancetype)newNoteViewInView:(UIView *)view;

- (void)addNoteViewWithpicName:(NSString *)picName noteText:(NSString *)noteText refreshBtnImg:(NSString *)btnImg;

@end


@implementation UITableView (TZLEmptyView)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzleMethod:@selector(reloadData) withMethod:@selector(tzl_reloadData)];
    });
}

+ (void)swizzleMethod:(SEL)origSelector withMethod:(SEL)newSelector {
    Class class = [self class];
    
    Method originalMethod = class_getInstanceMethod(class, origSelector);
    Method swizzledMethod = class_getInstanceMethod(class, newSelector);
    
    BOOL didAddMethod = class_addMethod(class,
                                        origSelector,
                                        method_getImplementation(swizzledMethod),
                                        method_getTypeEncoding(swizzledMethod));
    if (didAddMethod) {
        class_replaceMethod(class,
                            newSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

- (UIView *)emptyNoteView {
    return objc_getAssociatedObject(self, @selector(emptyNoteView));
}
- (void)setEmptyNoteView:(UIView *)emptyNoteView {
    objc_setAssociatedObject(self, @selector(emptyNoteView), emptyNoteView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (BOOL)tzl_haveEmpty {
    return [objc_getAssociatedObject(self, @selector(tzl_haveEmpty)) boolValue];
}
- (void)setTzl_haveEmpty:(BOOL)tzl_haveEmpty {
    objc_setAssociatedObject(self, @selector(tzl_haveEmpty), @(tzl_haveEmpty), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (tzl_emptyBtnBlock)tzl_emptyBtnBlock {
    return objc_getAssociatedObject(self, @selector(tzl_emptyBtnBlock));
}
- (void)setTzl_emptyBtnBlock:(tzl_emptyBtnBlock)tzl_emptyBtnBlock {
    objc_setAssociatedObject(self, @selector(tzl_emptyBtnBlock), tzl_emptyBtnBlock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

//第二种思路
- (void)tzl_reloadData {
    [self tzl_reloadData];
    if (self.tzl_haveEmpty) {//如果想所有的都加 就把这个判断去掉
        [self createEmptyView];
    }
    if (self.emptyNoteView) {
        [self checkDataSource];
    }
}
//第一种思路
- (void)tzl_emptyReload {
    [self createEmptyView];
    [self checkDataSource];
    [self reloadData];
}
//逻辑代码
- (void)checkDataSource {
    id <UITableViewDataSource> dataSource = self.dataSource;
    NSInteger numberOfSections = 1;
    if (dataSource && [dataSource respondsToSelector:@selector(numberOfSectionsInTableView:)]) {
        numberOfSections = [dataSource numberOfSectionsInTableView:self];
    }
    for (int i = 0; i < numberOfSections; i++) {
        if ( [dataSource tableView:self numberOfRowsInSection:i] != 0) {
            [self.emptyNoteView removeFromSuperview];
            return;
        }
    }
    [self addSubview:self.emptyNoteView];//这种保留tableview的滑动功能 不会被遮挡
//    [self.superview addSubview:self.emptyNoteView];//这种tableview的滑动功能会被self.emptyNoteView遮挡
    
}
- (void)noteViewBtnClick {
    [self.emptyNoteView removeFromSuperview];
    if (self.tzl_emptyBtnBlock) {
        self.tzl_emptyBtnBlock();
    }
}

- (void)createEmptyView {
    UIView *noteView = self.emptyNoteView;
    if (!noteView) {
        TZLEmptyView *noteView = [[TZLEmptyView alloc] newNoteViewInView:self];
        [noteView addNoteViewWithpicName:@"貂蝉-群-步" noteText:@"嘿嘿嘿!想不想看到东西啊" refreshBtnImg:@"detail_btn_filladdress"];
        [noteView.refreshBtn addTarget:self action:@selector(noteViewBtnClick) forControlEvents:UIControlEventTouchUpInside];
        self.emptyNoteView = noteView;
    }
}
@end

#pragma mark - NoteView
@interface TZLEmptyView()

@property (nonatomic)UIImageView *bgImgView;
@property (nonatomic)UILabel *noteLabel;
@end


@implementation TZLEmptyView

- (instancetype)newNoteViewInView:(UIView *)view {
    CGRect frame = view.bounds;
    return [self initWithFrame:frame];
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    
    [self addSubview:self.bgImgView];
    [self addSubview:self.noteLabel];
}


- (void)addNoteViewWithpicName:(NSString *)picName noteText:(NSString *)noteText refreshBtnImg:(NSString *)btnImg {
    
    self.bgImgView.image = [UIImage imageNamed:picName];
    self.noteLabel.text = noteText;
    
    if (btnImg) {
        [self addSubview:self.refreshBtn];
        [self.refreshBtn setBackgroundImage:[UIImage imageNamed:btnImg] forState:UIControlStateNormal];
        self.refreshBtn.frame = CGRectMake(0, 0, self.refreshBtn.currentBackgroundImage.size.width, self.refreshBtn.currentBackgroundImage.size.height);
    }
    
    //    [self layoutCustomViews];
}

- (void)layoutSubviews {
    
    self.bgImgView.frame = CGRectMake(self.frame.size.width/2 - self.bgImgView.image.size.width/2, (self.frame.size.height - 64)/2.0 - 20 - self.bgImgView.image.size.height/2, self.bgImgView.image.size.width, self.bgImgView.image.size.height);
    
    self.noteLabel.frame = CGRectMake(0, CGRectGetMaxY(self.bgImgView.frame) + 20, self.frame.size.width, 20);
    
    if (self.refreshBtn) {
        
        if (self.noteLabel.text.length > 0) {
            self.refreshBtn.center = CGPointMake(self.frame.size.width/2.0, CGRectGetMaxY(self.noteLabel.frame) + 25 + self.refreshBtn.currentBackgroundImage.size.height / 2.0);
        }else {
            //无提示文字时、将btn上移
            self.refreshBtn.center = CGPointMake(self.frame.size.width/2.0, CGRectGetMaxY(self.bgImgView.frame) + 25 + self.refreshBtn.currentBackgroundImage.size.height / 2.0);
        }
    }
}

- (UIImageView *)bgImgView {
    if (!_bgImgView) {
        _bgImgView = [UIImageView new];
    }
    return _bgImgView;
}

- (UILabel *)noteLabel {
    if (!_noteLabel) {
        _noteLabel = [[UILabel alloc] init];
        _noteLabel.textAlignment = NSTextAlignmentCenter;
        _noteLabel.font = [UIFont systemFontOfSize:13.0];
    }
    return _noteLabel;
}

- (UIButton *)refreshBtn {
    if (!_refreshBtn) {
        _refreshBtn = [[UIButton alloc] init];
    }
    return _refreshBtn;
}

@end
