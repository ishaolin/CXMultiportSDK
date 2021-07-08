//
//  CXMFinishedViewController.h
//  Pods
//
//  Created by wshaolin on 2019/2/28.
//

#import <CXUIKit/CXUIKit.h>
#import "CXMDefines.h"

@interface CXMFinishedViewController : CXBaseViewController <CXNavigationAnimationSupportor>

@property (nonatomic, copy) CXMultiportSDKCompletionBlock successBlock;
@property (nonatomic, copy) CXMultiportSDKCompletionBlock failureBlock;
@property (nonatomic, copy) CXMultiportSDKPageEventBlock UIEventBlock;

- (instancetype)initWithNetEnv:(CXNetEnvType)netEnv
                          code:(NSString *)code
                         token:(NSString *)token;

@end
