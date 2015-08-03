//
//  UIView+SuperTableViewCell.m
//  HW41-44
//
//  Created by Илья Егоров on 02.08.15.
//  Copyright (c) 2015 Илья Егоров. All rights reserved.
//

#import "UIView+SuperTableViewCell.h"

@implementation UIView (SuperTableViewCell)

-(UITableViewCell*) superTableViewCell {
    
    if ([self isKindOfClass:[UITableViewCell class]]) {
        return (UITableViewCell*)self;
    }
    
    if (!self.superview) {
        return nil;
    }
    
    return [self.superview superTableViewCell];
}

@end
