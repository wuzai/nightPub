//
//  ImageBrowseViewController.m
//  WuTongCity
//
//  Created by alan  on 13-8-18.
//  Copyright (c) 2013年 alan. All rights reserved.
//

#import "ImageBrowseViewController.h"
#import "LocalDirectory.h"

@interface ImageBrowseViewController ()

@end

@implementation ImageBrowseViewController
@synthesize delegate;

- (id)initWithImageName:(UIImage *)_imageName{
	if (self = [super init]) {
        imageName = _imageName;
        fullScreen = NO;
        
        //图片本地路径
//        NSString *imagePath = [[LocalDirectory imageFileDirectory] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",imageName]];
        
        self.wantsFullScreenLayout = YES;
        //全屏图片
		imageView = [[UIImageView alloc] initWithImage:_imageName];
        imageView.frame = CGRectMake(0.0, 0.0, self.view.bounds.size.width, self.view.bounds.size.height);
        [self.view addSubview:imageView];
        
        UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:@"取消"
                                                                       style:UIBarButtonItemStylePlain
                                                                      target:self
                                                                      action:@selector(goback)];
        self.navigationItem.leftBarButtonItem = leftButton;
        
        UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithTitle:@"删除"
                                                                          style:UIBarButtonItemStylePlain
                                                                         target:self
                                                                         action:@selector(gobackByTrash)];
        self.navigationItem.rightBarButtonItem = anotherButton;
                
		//添加点击手势
        UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fullScreenImage)];
        gestureRecognizer.cancelsTouchesInView = NO;
        [self.view addGestureRecognizer:gestureRecognizer];
    }
	
	return self;
}


- (void)goback {
//	[delegate imageBrowseDidCancel:self];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)gobackByTrash {
	[delegate trashWithImageName:imageName];
}

-(void)fullScreenImage{
    if (fullScreen) {//已经打开全屏
        fullScreen = NO;
        [self.navigationController setNavigationBarHidden:NO animated:YES];//显示navigationcontroller
//        [[UIApplication sharedApplication] setStatusBarHidden:NO];
    }else{//没有打开全屏
        fullScreen = YES;
       [self.navigationController setNavigationBarHidden:YES animated:YES];//隐藏navigationcontroller
//        [[UIApplication sharedApplication] setStatusBarHidden:YES];
    }
    
}

@end
