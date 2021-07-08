//
//  CXMCodeCheckRequest.m
//  Pods
//
//  Created by wshaolin on 2019/2/28.
//

#import "CXMCodeCheckRequest.h"

@implementation CXMCodeCheckRequest

- (instancetype)initWithCode:(NSString *)code token:(NSString *)token{
    if(self = [super init]){
        [self addParam:code forKey:@"code"];
        [self addParam:token forKey:@"token"];
    }
    
    return self;
}

- (NSString *)path{
    return @"/sso/app/qrcodeCheck";
}

@end
