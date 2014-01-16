//
//  SHCTableView.h
//  ClearStyle
//
//  Created by Sameh Aly on 2/25/13.
//  Copyright (c) 2013 Sahab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SHCTableViewDataSource.h"

#define SHC_ROW_HEIGHT 80.0f

@interface SHCTableView : UIView <UIScrollViewDelegate>

// the object that acts as the data source for this table
@property (nonatomic, assign) id<SHCTableViewDataSource> dataSource;
// the UIScrollView that hosts the table contents
@property (nonatomic, assign, readonly) UIScrollView* scrollView;

@property (nonatomic, assign) id<UIScrollViewDelegate> delegate;

// dequeues a cell that can be reused
-(UIView*)dequeueReusableCell;

// registers a class for use as new cells
-(void)registerClassForCells:(Class)cellClass;

// an array of cells that are currently visible, sorted from top to bottom.
-(NSArray*)visibleCells;

// forces the table to dispose of all the cells and re-build the table.
-(void)reloadData;

@end
