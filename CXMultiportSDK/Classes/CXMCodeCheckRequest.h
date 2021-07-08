//
//  CXMCodeCheckRequest.h
//  Pods
//
//  Created by wshaolin on 2019/2/28.
//

#import "CXMBaseURLRequest.h"

@interface CXMCodeCheckRequest : CXMBaseURLRequest

- (instancetype)initWithCode:(NSString *)code token:(NSString *)token;

@end
