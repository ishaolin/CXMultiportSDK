//
//  CXMBaseURLRequest.m
//  Pods
//
//  Created by wshaolin on 2019/2/28.
//

#import "CXMBaseURLRequest.h"

@implementation CXMBaseURLRequest

- (NSString *)baseURL{
    switch(self.netEnv){
        case CXNetEnvQA:
            return @"https://passport-test.zhidaohulian.com";
        case CXNetEnvRD:
            return @"https://passport-dev.zhidaohulian.com";
        case CXNetEnvOL:
        default:
            return @"https://passport.zhidaohulian.com";
    }
}

- (NSString *)sigWithParams:(NSDictionary<NSString *,id> *)params ignoreKeys:(NSArray<NSString *> *)ignoreKeys{
    return [CXSignUtil signWithDictionary:params
                               ignoreKeys:ignoreKeys
                               privateKey:@"JGqZw9"];
}

- (NSDictionary<NSString *,id> *)commonParams{
    NSMutableDictionary<NSString *, id> *params = [NSMutableDictionary dictionary];
    [params cx_setString:[NSBundle mainBundle].cx_buildVersion forKey:@"appVersionCode"];
    [params cx_setString:[NSBundle mainBundle].cx_appVersion forKey:@"appVersion"];
    [params cx_setObject:@(3) forKey:@"source"];
    return [params copy];
}

@end
