//
//  NSView+dump.h
//  xcodePluginDemo
//
//  Created by wangyang on 5/21/15.
//  Copyright (c) 2015 com.wy. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface NSView (dump)
-(void)dumpWithIndent:(NSString *)indent;
- (void)dumpSheets;
@end
