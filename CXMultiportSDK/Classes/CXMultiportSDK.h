//
//  CXMultiportSDK.h
//  Pods
//
//  Created by wshaolin on 2019/2/28.
//

#import <Foundation/Foundation.h>
#import "CXMDefines.h"

@interface CXMultiportSDK : NSObject

+ (BOOL)canHandleQRCode:(NSString *)QRCode;

+ (void)handleQRCode:(NSString *)QRCode
          loginToken:(NSString *)token
              netEnv:(CXNetEnvType)netEnv
            showPage:(CXMultiportSDKShowPageBlock)showPage
             eventor:(CXMultiportSDKPageEventBlock)eventor
             success:(CXMultiportSDKCompletionBlock)success
             failure:(CXMultiportSDKCompletionBlock)failure;

@end
