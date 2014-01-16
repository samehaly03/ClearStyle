//
//  SHCTableViewCell.h
//  ClearStyle
//
//  Created by Sameh Aly on 2/24/13.
//  Copyright (c) 2013 Sahab. All rights reserved.
//

#import "SHCToDoItem.h"
#import "SHCTableViewCellDelegate.h"
#import "SHCStrikethroughLabel.h"
#import "HMGLTransitionManager.h"

// A custom table cell that renders SHCToDoItem items.
@interface SHCTableViewCell : UITableViewCell <UITextFieldDelegate>

// The item that this cell renders.
@property (nonatomic) SHCToDoItem *todoItem;

// The object that acts as delegate for this cell.
@property (nonatomic, assign) id<SHCTableViewCellDelegate> delegate;

// the label used to render the to-do text
@property (nonatomic, strong, readonly) SHCStrikethroughLabel* label;

@property (nonatomic, retain) HMGLTransition *transition;

@property (nonatomic, retain) UIView *cellView;

@end