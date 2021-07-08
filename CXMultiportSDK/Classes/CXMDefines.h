//
//  CXMDefines.h
//  Pods
//
//  Created by wshaolin on 2019/2/28.
//

#ifndef CXMDefines_h
#define CXMDefines_h

#import <CXNetSDK/CXNetDefines.h>
#import <CXUIKit/CXUIKit.h>

#define CX_MULTIPORT_IMAGE(name)    CX_POD_IMAGE(name, @"CXMultiportSDK")

#define CXM_EVENT_ACTION_CLOSE      0x0001  /* 登录页面关闭按钮 */
#define CXM_EVENT_ACTION_LOGIN      0x0002  /* 登录页面登录按钮 */
#define CXM_EVENT_ACTION_CANCEL     0x0003  /* 登录页面取消按钮 */

typedef NSInteger CXMEventType;

@class UIViewController;

typedef void(^CXMultiportSDKCompletionBlock)(UIViewController *VC, NSString *error);
typedef void(^CXMultiportSDKPageEventBlock)(UIViewController *VC, CXMEventType event);
typedef void(^CXMultiportSDKShowPageBlock)(UIViewController *VC);

#endif /* CXMDefines_h */
