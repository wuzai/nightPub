//
//  CreateWeiboViewController.h
//  WuTongCity
//
//  Created by alan  on 13-8-15.
//  Copyright (c) 2013年 alan. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ImageBrowseViewController.h"
//#define  keyboardHeight 216

@interface CreateWeiboViewController : UIViewController<UITableViewDelegate,UIImagePickerControllerDelegate,UITextViewDelegate,UITableViewDataSource,UINavigationControllerDelegate,UIActionSheetDelegate,ImageBrowseDelegate>{
   
    UITableView *createWeiboTableView;
    UITextView *weiboTextView;//微博文字
    //为使用tableview定义的临时数据
    NSMutableDictionary *tempDict;
    NSArray *tempArray;
    
//    NSMutableDictionary *imgDict;//临时图片字典
//    NSMutableArray *imgKeyArray;//临时图片字典key
    //NSMutableArray *imageArray;//临时图片字典key
//    NSMutableArray *imagePathArray;//临时图片地址
//    NSMutableArray *imageFullPathArray;//临时图片服务器地址

    BOOL  faceBoardShow;//是否打开表情键盘
    
    NSString *imagePath;//图片路径
    
}
@property (nonatomic,strong) NSMutableArray *imageArray;//临时图片字典key
@property (nonatomic,strong) NSMutableArray *imagePathArray;//临时图片字典key
@property (nonatomic,strong) NSMutableArray *imageFullPathArray;//临时图片字典key

@end
