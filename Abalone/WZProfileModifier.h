//
//  WZProfileModifier.h
//  Abalone
//
//  Created by 吾在 on 13-4-24.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *const kWZUserProfileNameKey;
extern NSString *const kWZUserProfileGenderKey;
extern NSString *const kWZUserProfileEmailKey;
extern NSString *const kWZUserProfileBirthKey;
extern NSString *const KWZUserProfileFaceIconKey;
extern NSString *const KWZuserProfileRealNameKey;
extern NSString *const KWZuserProfilePicKey;

@interface WZProfileModifier : NSObject
+ (instancetype)modifier;
@property (nonatomic,readonly) NSDictionary *changes;
- (void)synchronize;
- (void)invalid;
- (void)invalidChangeForKey:(NSString *)key;
- (void)prepareChange:(id)value forKey:(NSString *)key;
- (void)setIcon:(id)value forKey:(NSString *)key;
@end
