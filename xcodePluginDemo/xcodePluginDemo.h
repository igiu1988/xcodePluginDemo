//
//  xcodePluginDemo.h
//  xcodePluginDemo
//
//  Created by wangyang on 5/21/15.
//  Copyright (c) 2015 com.wy. All rights reserved.
//

#import <AppKit/AppKit.h>

@interface xcodePluginDemo : NSObject

+ (instancetype)sharedPlugin;

@property (nonatomic, strong, readonly) NSBundle* bundle;
@end