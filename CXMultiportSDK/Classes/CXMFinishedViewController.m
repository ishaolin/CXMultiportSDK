//
//  CXMFinishedViewController.m
//  Pods
//
//  Created by wshaolin on 2019/2/28.
//

#import "CXMFinishedViewController.h"
#import "CXMCodeLoginRequest.h"

@interface CXMFinishedViewController () {
    CXNetEnvType _netEnv;
    NSString *_code;
    NSString *_token;
    
    UIButton *_closeButton;
    UIImageView *_tipImage;
    UILabel *_tipLabel;
    UIButton *_loginButton;
    UIButton *_cancelButton;
}

@end

@implementation CXMFinishedViewController

- (instancetype)initWithNetEnv:(CXNetEnvType)netEnv
                          code:(NSString *)code
                         token:(NSString *)token{
    if(self = [super init]){
        _netEnv = netEnv;
        _code = code;
        _token = token;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationBar.hidden = YES;
    
    _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_closeButton setImage:CX_MULTIPORT_IMAGE(@"multiport_login_page_close") forState:UIControlStateNormal];
    [_closeButton addTarget:self action:@selector(handleActionForCloseButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_closeButton];
    CGFloat closeButton_X = 0;
    CGFloat closeButton_Y = 20.0 + [UIScreen mainScreen].cx_safeAreaInsets.top;
    CGFloat closeButton_W = 44.0;
    CGFloat closeButton_H = closeButton_W;
    _closeButton.frame = (CGRect){closeButton_X, closeButton_Y, closeButton_W, closeButton_H};
    
    _tipImage = [[UIImageView alloc] init];
    _tipImage.image = CX_MULTIPORT_IMAGE(@"multiport_login_device");
    [self.view addSubview:_tipImage];
    CGFloat tipImage_W = 205.0;
    CGFloat tipImage_H = 130.0;
    CGFloat tipImage_X = (CGRectGetWidth(self.view.bounds) - tipImage_W) * 0.5;
    CGFloat tipImage_Y = (CGRectGetHeight(self.view.bounds) - 375.0) * 0.5;
    _tipImage.frame = CGRectMake(tipImage_X, tipImage_Y, tipImage_W, tipImage_H);
    
    _tipLabel = [[UILabel alloc] init];
    _tipLabel.textColor = CXHexIColor(0x282C2A);
    _tipLabel.textAlignment = NSTextAlignmentCenter;
    _tipLabel.font = CX_PingFangSC_RegularFont(18.0);
    _tipLabel.text = @"车机登录确认";
    [self.view addSubview:_tipLabel];
    CGFloat tipLabel_W = tipImage_W;
    CGFloat tipLabel_H = 25.0;
    CGFloat tipLabel_X = tipImage_X;
    CGFloat tipLabel_Y = CGRectGetMaxY(_tipImage.frame) + 11.0;
    _tipLabel.frame = CGRectMake(tipLabel_X, tipLabel_Y, tipLabel_W, tipLabel_H);
    
    _loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _loginButton.titleLabel.font = CX_PingFangSC_SemiboldFont(22.0);
    [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [_loginButton setTitleColor:CXHexIColor(0xFFFFFF) forState:UIControlStateNormal];
    [_loginButton cx_setBackgroundColors:@[CXHexIColor(0x07CD75), CXHexIColor(0x00E3AE)]
                       gradientDirection:CXColorGradientHorizontal
                                forState:UIControlStateNormal];
    [_loginButton addTarget:self action:@selector(handleActionForLoginButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_loginButton];
    CGFloat loginButton_W = 254.0;
    CGFloat loginButton_H = 54.0;
    CGFloat loginButton_X = (CGRectGetWidth(self.view.bounds) - loginButton_W) * 0.5;
    CGFloat loginButton_Y = CGRectGetMaxY(_tipLabel.frame) + 100.0;
    _loginButton.frame = (CGRect){loginButton_X, loginButton_Y, loginButton_W, loginButton_H};
    [_loginButton cx_roundedCornerRadii:4.0];
    
    _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _cancelButton.titleLabel.font = CX_PingFangSC_RegularFont(16.0);
    [_cancelButton setTitle:@"取消登录" forState:UIControlStateNormal];
    [_cancelButton setTitleColor:CXHexIColor(0xA0A5A3) forState:UIControlStateNormal];
    [_cancelButton setTitleColor:CXHexIColor(0x999999) forState:UIControlStateHighlighted];
    [_cancelButton addTarget:self action:@selector(handleActionForCancelButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_cancelButton];
    CGFloat cancelButton_W = 80.0;
    CGFloat cancelButton_H = 30.0;
    CGFloat cancelButton_X = (CGRectGetWidth(self.view.bounds) - cancelButton_W) * 0.5;
    CGFloat cancelButton_Y = CGRectGetMaxY(_loginButton.frame) + 25.0;
    _cancelButton.frame = (CGRect){cancelButton_X, cancelButton_Y, cancelButton_W, cancelButton_H};
}

- (void)handleActionForCloseButton:(UIButton *)closeButton{
    [self dismissAnimated:YES completion:nil];
    
    !self.UIEventBlock ?: self.UIEventBlock(self, CXM_EVENT_ACTION_CLOSE);
}

- (void)handleActionForCancelButton:(UIButton *)cancelButton{
    [self dismissAnimated:YES completion:nil];
    
    !self.UIEventBlock ?: self.UIEventBlock(self, CXM_EVENT_ACTION_CANCEL);
}

- (void)handleActionForLoginButton:(UIButton *)loginButton{
    !self.UIEventBlock ?: self.UIEventBlock(self, CXM_EVENT_ACTION_LOGIN);
    
    CXMCodeLoginRequest *request = [[CXMCodeLoginRequest alloc] initWithCode:_code token:_token];
    request.netEnv = _netEnv;
    [request loadRequestWithSuccess:^(NSURLSessionDataTask * _Nonnull dataTask, id  _Nullable data) {
        CXBaseModel *model = (CXBaseModel *)data;
        if(model.isValid){
            [self dismissAnimated:YES completion:NULL];
            !self.successBlock ?: self.successBlock(self, nil);
        }else{
            [CXHUD showMsg:model.msg];
            !self.failureBlock ?: self.failureBlock(self, model.msg);
        }
    } failure:^(NSURLSessionDataTask * _Nullable dataTask, NSError * _Nullable error) {
        [CXHUD showMsg:error.HUDMsg];
        !self.failureBlock ?: self.failureBlock(self, error.HUDMsg);
    }];
}

- (void)dismissAnimated:(BOOL)animated completion:(void (^)(void))completion{
    if(self.navigationController){
        [self.navigationController popViewControllerAnimated:animated];
    }else{
        [self dismissViewControllerAnimated:animated completion:nil];
    }
}

- (CXNavigationAnimationType)navigationAnimationType{
    return CXNavigationAnimationPresent;
}

@end
