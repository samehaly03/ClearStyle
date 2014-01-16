//
//  SHCViewController.h
//  ClearStyle
//
//  Created by Sameh Aly on 2/24/13.
//  Copyright (c) 2013 Sahab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SHCTableViewCellDelegate.h"
#import "SHCTableView.h"
#import "SHCTableViewDragAddNew.h"
#import "HMGLTransitionManager.h"
#import "Switch3DTransition.h"
#import "FlipTransition.h"
#import "RotateTransition.h"
#import "ClothTransition.h"
#import "DoorsTransition.h"

@interface SHCViewController : UIViewController <SHCTableViewCellDelegate, SHCTableViewDataSource, SHCTableViewCellDelegate>
{}

@property (weak, nonatomic) IBOutlet SHCTableView *tableView;

@end
