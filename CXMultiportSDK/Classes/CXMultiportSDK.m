//
//  CXMultiportSDK.m
//  Pods
//
//  Created by wshaolin on 2019/2/28.
//

#import "CXMultiportSDK.h"
#import "CXMCodeCheckRequest.h"
#import "CXMFinishedViewController.h"

static const NSString *CXMultiLoginCodeKey = @"code";

@implementation CXMultiportSDK

+ (BOOL)canHandleQRCode:(NSString *)QRCode{
    return !CXStringIsEmpty([self codeFromQRCode:QRCode]);
}

+ (NSString *)codeFromQRCode:(NSString *)QRCode{
    NSURL *URL = [NSURL URLWithString:QRCode];
    if(!URL){
        return nil;
    }
    
    NSDictionary<NSString *, NSString *> *params = [URL cx_params];
    if(CXDictionaryIsEmpty(params)){
        return nil;
    }
    
    // 西安-刘备货运分支
    if([params cx_hasKey:CXMultiLoginCodeKey]){
        return [params cx_stringForKey:CXMultiLoginCodeKey];
    }
    
    // 泰安-出租车分支
    NSString *loginCode = [params cx_objectForKey:@"loginCode"];
    URL = [NSURL URLWithString:loginCode];
    if(!URL){
        return nil;
    }
    
    params = [URL cx_params];
    return [params cx_stringForKey:CXMultiLoginCodeKey];
}

+ (void)handleQRCode:(NSString *)QRCode
          loginToken:(NSString *)token
              netEnv:(CXNetEnvType)netEnv
            showPage:(CXMultiportSDKShowPageBlock)showPage
             eventor:(CXMultiportSDKPageEventBlock)eventor
             success:(CXMultiportSDKCompletionBlock)success
             failure:(CXMultiportSDKCompletionBlock)failure{
    NSString *code = [self codeFromQRCode:QRCode];
    CXMCodeCheckRequest *checkRequest = [[CXMCodeCheckRequest alloc] initWithCode:code token:token];
    checkRequest.netEnv = netEnv;
    [checkRequest loadRequestWithSuccess:^(NSURLSessionDataTask * _Nonnull dataTask, id  _Nullable data) {
        CXBaseModel *model = (CXBaseModel *)data;
        if(model.isValid){
            CXMFinishedViewController *VC = [[CXMFinishedViewController alloc] initWithNetEnv:netEnv code:code token:token];
            VC.successBlock = success;
            VC.failureBlock = failure;
            VC.UIEventBlock = eventor;
            !showPage ?: showPage(VC);
        }else{
            !failure ?: failure(nil, model.msg);
        }
    } failure:^(NSURLSessionDataTask * _Nullable dataTask, NSError * _Nullable error) {
        !failure ?: failure(nil, error.HUDMsg);
    }];
}

@end
