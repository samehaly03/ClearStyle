//
//  SHCViewController.m
//  ClearStyle
//
//  Created by Sameh Aly on 2/24/13.
//  Copyright (c) 2013 Sahab. All rights reserved.
//

#import "SHCViewController.h"
#import "SHCToDoItem.h"
#import "SHCTableViewCell.h"
#import "SHCTableViewPinchToAdd.h"

@implementation SHCViewController
{
    // an array of to-do items
    NSMutableArray* _toDoItems;
    
    // the offset applied to cells when entering “edit mode”
    float _editingOffset;
    
    SHCTableViewDragAddNew* _dragAddNew;
    
    SHCTableViewPinchToAdd* _pinchAddNew;
    
    HMGLTransition *transition;
}

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self)
    {
        // create a dummy to-do list
        _toDoItems = [[NSMutableArray alloc] init];
        [_toDoItems addObject:[SHCToDoItem toDoItemWithText:@"Feed the cat"]];
        [_toDoItems addObject:[SHCToDoItem toDoItemWithText:@"Buy eggs"]];
        [_toDoItems addObject:[SHCToDoItem toDoItemWithText:@"Pack bags for WWDC"]];
        [_toDoItems addObject:[SHCToDoItem toDoItemWithText:@"Rule the web"]];
        [_toDoItems addObject:[SHCToDoItem toDoItemWithText:@"Buy a new iPhone"]];
        [_toDoItems addObject:[SHCToDoItem toDoItemWithText:@"Find missing socks"]];
        [_toDoItems addObject:[SHCToDoItem toDoItemWithText:@"Write a new tutorial"]];
        [_toDoItems addObject:[SHCToDoItem toDoItemWithText:@"Master Objective-C"]];
        [_toDoItems addObject:[SHCToDoItem toDoItemWithText:@"Remember your wedding anniversary!"]];

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.dataSource = self;
    
    self.tableView.backgroundColor = [UIColor blackColor];
    
    [self.tableView registerClassForCells:[SHCTableViewCell class]];
    
    _dragAddNew = [[SHCTableViewDragAddNew alloc] initWithTableView:self.tableView];
    
    _pinchAddNew = [[SHCTableViewPinchToAdd alloc] initWithTableView:self.tableView];
    
    // Creating singleton of transition manager here helps to reduce lag when showing first transition.
	[HMGLTransitionManager sharedTransitionManager];
    
    transition = [[ClothTransition alloc] init];
}


/*
#pragma mark - UITableViewDataSource protocol methods
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _toDoItems.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *ident = @"cell";
    // re-use or create a cell
    SHCTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ident forIndexPath:indexPath];
    // find the to-do item for this index
    int index = [indexPath row];
    SHCToDoItem *item = _toDoItems[index];
    // set the text
    //cell.textLabel.text = item.text;
    cell.textLabel.backgroundColor = [UIColor clearColor];
    
    cell.delegate = self;
    cell.todoItem = item;
    
    return cell;
}
*/

-(UIColor*)colorForIndex:(NSInteger) index
{
    NSUInteger itemCount = _toDoItems.count - 1;
    
    float valGreen = ((float)index / (float)itemCount) * 0.8;
    
    float valRed = ((float)index / (float)itemCount) * 0.1;
    
    float valBlue = ((float)index / (float)itemCount) * 0.1;
    
    //NSLog(@"index is %i : %f %f %f", index, valRed, valGreen, valBlue);
    
    //return [UIColor colorWithRed: 0.4 green:valGreen blue: 140.0/255.0 alpha:1.0];
    
    if (index == 0)
    {
        //return [UIColor colorWithRed: valRed green:valGreen blue: 0.1 alpha:1.0];
    }
    
    return [UIColor colorWithRed: 0.4 green:valGreen blue: 0.4 alpha:1.0];

}

-(void)toDoItemDeleted:(id)todoItem
{
    // use the UITableView to animate the removal of this row
    
    //This is apple stock animation
    /*
    NSUInteger index = [_toDoItems indexOfObject:todoItem];
    [self.tableView beginUpdates];
    [_toDoItems removeObject:todoItem];
    [self.tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:index inSection:0]]
                          withRowAnimation:UITableViewRowAnimationLeft];
    [self.tableView endUpdates];
    */
    
    
    //This is our funky animation
    float delay = 0.0;
    
    // remove the model object
    [_toDoItems removeObject:todoItem];
    
    // find the visible cells
    NSArray* visibleCells = [self.tableView visibleCells];
    
    UIView* lastView = [visibleCells lastObject];
    bool startAnimating = false;
    
    // iterate over all of the cells
    for(SHCTableViewCell* cell in visibleCells)
    {
        if (startAnimating)
        {

            
            [UIView animateWithDuration:0.3
                                  delay:delay
                                options:UIViewAnimationOptionCurveEaseInOut
                             animations:^{
                                 cell.frame = CGRectOffset(cell.frame, 0.0f, -cell.frame.size.height);
                             }
                             completion:^(BOOL finished){
                                 if (cell == lastView)
                                 {
                                     [self.tableView reloadData];
                                 }
                             }];
            delay+=0.03;
             
            
        }
        
        // if you have reached the item that was deleted, start animating
        if (cell.todoItem == todoItem)
        {
            startAnimating = true;
            cell.hidden = YES;
        }
    }
     
}

-(void)cellDidBeginEditing:(SHCTableViewCell *)editingCell
{
    _editingOffset = _tableView.scrollView.contentOffset.y - editingCell.frame.origin.y;
    for(SHCTableViewCell* cell in [_tableView visibleCells])
    {
        [UIView animateWithDuration:0.3
                         animations:^{
                             cell.frame = CGRectOffset(cell.frame, 0, _editingOffset);
                             if (cell != editingCell)
                             {
                                 cell.alpha = 0.3;
                             }
                         }];
    }
}

-(void)cellDidEndEditing:(SHCTableViewCell *)editingCell
{
    for(SHCTableViewCell* cell in [_tableView visibleCells])
    {
        [UIView animateWithDuration:0.3
                         animations:^{
                             cell.frame = CGRectOffset(cell.frame, 0, -_editingOffset);
                             if (cell != editingCell)
                             {
                                 cell.alpha = 1.0;
                             }
                         }];
    }
}

#pragma mark - SHCTableViewDataSource methods
-(NSInteger)numberOfRows
{
    return _toDoItems.count;
}

-(UITableViewCell *)cellForRow:(NSInteger)row
{
    NSString *ident = @"cell";
    SHCTableViewCell* cell = (SHCTableViewCell*)[self.tableView dequeueReusableCell];
    SHCToDoItem *item = _toDoItems[row];
    cell.todoItem = item;
    cell.delegate = self;
    cell.backgroundColor = [self colorForIndex:row];
    return cell;
}

-(void)itemAdded
{
    [self itemAddedAtIndex:0];
}

-(void)itemAddedAtIndex:(NSInteger)index
{
    // create the new item
    SHCToDoItem* toDoItem = [[SHCToDoItem alloc] init];
    [_toDoItems insertObject:toDoItem atIndex:index];
    
    // refresh the table
    [_tableView reloadData];
    
    // enter edit mode
    SHCTableViewCell* editCell;
    for (SHCTableViewCell* cell in _tableView.visibleCells)
    {
        if (cell.todoItem == toDoItem)
        {
            editCell = cell;
            break;
        }
    }
    [editCell.label becomeFirstResponder];
}

@end
