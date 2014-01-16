//
//  SHCToDoItem.m
//  ClearStyle
//
//  Created by Sameh Aly on 2/24/13.
//  Copyright (c) 2013 Sahab. All rights reserved.
//

#import "SHCToDoItem.h"

@implementation SHCToDoItem

- (id)initWithText:(NSString *)text
{
    if (self = [super init])
    {
        self.text = text;
    }
    
    return self;
}

+ (id)toDoItemWithText:(NSString *)text
{
    return [[SHCToDoItem alloc] initWithText:text];
}

@end
