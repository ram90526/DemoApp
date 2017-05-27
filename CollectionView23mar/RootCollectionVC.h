//
//  ViewController.h
//  CollectionView23mar
//
//  Created by SOM LIMBU on 23/03/16.
//  Copyright © 2016 SOM LIMBU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootCollectionVC : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>{
    UIImage * tempImg;
}

@property  UIImagePickerController*imagePicker;
//*************picker************

@property NSMutableArray*mainImagesArray;
@property NSMutableArray*statusArray;

@property UIImageView *imgView;

@property NSString*str1;
//*************check box***********//
@property BOOL checkBox;
@property UIImageView*checkBoxImageView;

//***************segmented controller***************//
@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentedController;

@property (strong, nonatomic) IBOutlet UIButton *nextBtn;

//**************storing check mark box***************//

@property UIButton*storeBtn;

@property NSMutableArray*tempArray1;
@property NSMutableArray*tempArray2;

//@property NSArray*tempArray1;
//@property NSArray*tempArray2;




@end

