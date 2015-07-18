//
//  NSView+dump.m
//  xcodePluginDemo
//
//  Created by wangyang on 5/21/15.
//  Copyright (c) 2015 com.wy. All rights reserved.
//

#import "NSView+dump.h"

@implementation NSView (dump)
-(void)dumpWithIndent:(NSString *)indent {
    NSString *class = NSStringFromClass([self class]);
    NSString *info = @"";
    if ([self respondsToSelector:@selector(title)]) {
        NSString *title = [self performSelector:@selector(title)];
        if (title != nil && [title length] > 0) {
            info = [info stringByAppendingFormat:@" title=%@", title];
        }
    }
    if ([self respondsToSelector:@selector(stringValue)]) {
        NSString *string = [self performSelector:@selector(stringValue)];
        if (string != nil && [string length] > 0) {
            info = [info stringByAppendingFormat:@" stringValue=%@", string];
        }
    }
    NSString *tooltip = [self toolTip];
    if (tooltip != nil && [tooltip length] > 0) {
        info = [info stringByAppendingFormat:@" tooltip=%@", tooltip];
    }
    
    NSLog(@"%@%@%@", indent, class, info);
    
    if ([[self subviews] count] > 0) {
        NSString *subIndent = [NSString stringWithFormat:@"%@%@", indent, ([indent length]/2)%2==0 ? @"| " : @": "];
        for (NSView *subview in [self subviews]) {
            [subview dumpWithIndent:subIndent];
        }
    }

}

- (void)dumpSheets{
    if (self.window.sheets.count == 0) {
        NSLog(@"-----------没有sheet------------");
    }else if (self.window.sheets.count == 1){
        
        NSLog(@"-----------有一个sheet dump begin------------");
        
        
        //        NSLog(@"sheet count %lu", (unsigned long)self.window.sheets.count);
        NSWindow *panel = self.window.sheets[0];
        //        NSLog(@"sheet class %@",  NSStringFromClass([panel class]));
        
        NSString *indent = @"";
        [panel.contentView dumpWithIndent:indent];
//        for (NSView *view in [panel.contentView subviews]) {
//            NSString *subIndent = [NSString stringWithFormat:@"sheet %@%@", indent, ([indent length]/2)%2==0 ? @"| " : @": "];
//            [view dumpWithIndent:subIndent];
//        }
        
        NSLog(@"-----------有一个sheet dump end------------");
    }else{
        
    }
}


@end
