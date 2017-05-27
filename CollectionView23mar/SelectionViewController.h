//
//  SelectionViewController.h
//  CollectionView23mar
//
//  Created by SOM LIMBU on 30/03/16.
//  Copyright © 2016 SOM LIMBU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectionViewController : UIViewController


@property NSMutableArray*selectedImagesArray;
@property NSMutableArray*selectedStatusArray;

@property NSMutableArray*tempArrayInSelectionVC;
@property NSMutableArray*tempArray2InSelectionVC;


@property (strong,nonatomic)UICollectionView*selectedCollectinView;
@property UIImageView *selectedImgView;

@end
