//
//  SHCTableViewCellDelegate.h
//  ClearStyle
//
//  Created by Sameh Aly on 2/24/13.
//  Copyright (c) 2013 Sahab. All rights reserved.
//

#import "SHCToDoItem.h"
@class SHCTableViewCell;

// A protocol that the SHCTableViewCell uses to inform of state change
@protocol SHCTableViewCellDelegate <NSObject>

// indicates that the given item has been deleted
-(void) toDoItemDeleted:(SHCToDoItem*)todoItem;

// Indicates that the edit process has begun for the given cell
-(void)cellDidBeginEditing:(SHCTableViewCell*)cell;

// Indicates that the edit process has committed for the given cell
-(void)cellDidEndEditing:(SHCTableViewCell*)cell;

@end
