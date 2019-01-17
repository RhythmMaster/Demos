//
//  TZLUITextFieldViewController.m
//  Demos
//
//  Created by tang on 2018/11/28.
//  Copyright © 2018年 TZL. All rights reserved.
//

#import "TZLUITextFieldViewController.h"
#import "UITextField+TZLExtension.h"

@interface TZLUITextFieldViewController ()

@property (nonatomic, strong) UITextField *inputTextField;
@property (nonatomic, strong) UILabel *tipLabel;
@end

@implementation TZLUITextFieldViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}
- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    //标签
    [self.tipLabel sizeToFit];
    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20.0);
        make.top.equalTo(self.view).offset(100.0);
    }];
    
    //输入框
    [self.inputTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.tipLabel.mas_right).offset(15.0);
        make.centerY.equalTo(self.tipLabel);
        make.height.equalTo(@(CGRectGetHeight(self.tipLabel.frame) + 20));
        make.width.equalTo(@(200.0));
    }];
}
- (void)setupUI {
    //标签
    UILabel *tipLabel = [[UILabel alloc] init];
    tipLabel.text = @"手机号";
    tipLabel.textAlignment = NSTextAlignmentLeft;
    tipLabel.textColor =  [UIColor blueColor];
    tipLabel.font = [UIFont systemFontOfSize:18.0];
    [self.view addSubview:tipLabel];
    self.tipLabel = tipLabel;
    
    //输入框
    UITextField *inputTextField = [[UITextField alloc] init];
    inputTextField.placeholder = @"请输入手机号";
    [inputTextField addTarget:self action:@selector(textFieldDidChanged:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:inputTextField];
    self.inputTextField = inputTextField;
    
    //扩展属性部分
    inputTextField.placeholderFont = [UIFont systemFontOfSize:15];
    inputTextField.placeholderColor = [UIColor blackColor];
    inputTextField.borderColor = [UIColor lightGrayColor];
    inputTextField.marginLeftOfPlaceholder = 10;
    
    //UITextField左侧和右侧视图
    //左侧视图
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeContactAdd];
    leftButton.frame = CGRectMake(0.0, 0.0, 40, 40);
    inputTextField.leftView = leftButton;
    inputTextField.leftViewMode = UITextFieldViewModeAlways;
    
    //右侧视图
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    rightButton.frame = CGRectMake(0.0, 0.0, 40, 40);
    inputTextField.rightView = rightButton;
    inputTextField.rightViewMode = UITextFieldViewModeWhileEditing;
    
    //在UITextField或者UITextField成为默认响应的时候，会弹出系统键盘。如果对这两个控件的inputView属性设置了自定义的view，在其成为第一响应的时候系统键盘将不再弹出，取而代之的是赋值给inputView的那个view。inputAccessoryView是键盘的辅助视图，即键盘上面那部分。同样当对inputAccessoryView设置了自定义view时，键盘弹出的同时，该view会作为辅助视图出现在键盘的上面，和键盘一起弹出。
    //inputView
    UILabel *inputLabelView = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.bounds.size.width, 120.0)];
    inputLabelView.text = @"我是inputView";
    inputLabelView.textColor = [UIColor orangeColor];
    inputLabelView.textAlignment = NSTextAlignmentCenter;
    inputLabelView.backgroundColor = [UIColor lightGrayColor];
    
    inputTextField.inputView = inputLabelView;
    
    //inputAccessoryView
    UILabel *inputAccessoryLabelView = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.bounds.size.width, 50.0)];
    inputAccessoryLabelView.text = @"我是inputAccessoryLabelView";
    inputAccessoryLabelView.textColor = [UIColor blueColor];
    inputAccessoryLabelView.textAlignment = NSTextAlignmentCenter;
    inputAccessoryLabelView.backgroundColor = [UIColor greenColor];
    
    inputTextField.inputAccessoryView = inputAccessoryLabelView;
}
#pragma mark - Action && Notification

- (void)textFieldDidChanged:(UITextField *)textField {
    
}
@end
