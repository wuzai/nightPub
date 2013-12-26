//
//  CreateWeiboViewController.m
//  WuTongCity
//
//  Created by alan  on 13-8-15.
//  Copyright (c) 2013年 alan. All rights reserved.
//

#import "CreateWeiboViewController.h"
#import "WZUser+Me.h"
#import "LocalDirectory.h"
#import "ImageUtil.h"
#import "ASIFormDataRequest.h"
#import "SBJsonParser.h"
#import "WZPICUpload.h"
#import "UIWindow+Lock.h"

@interface CreateWeiboViewController ()

@end

@implementation CreateWeiboViewController

@synthesize imageArray=_imageArray;

- (id)init{
    self = [super init];
    if (self) {
        faceBoardShow = NO;//默认表情键盘没有打开
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    //为使用tableview定义的临时数据
    tempDict = [[NSMutableDictionary alloc]initWithObjectsAndKeys:[NSArray arrayWithObject:@"1"],@"1",[NSArray arrayWithObject:@"2"],@"2", nil];
    tempArray = [[NSArray alloc]initWithArray:[[tempDict allKeys]sortedArrayUsingSelector:@selector(compare:)]];
    UIImage *image = [UIImage imageNamed:@"more.png"];
    //初始默认给一个加好图片按钮
//    self.imageArray = [[NSMutableArray alloc]initWithObjects:image, nil];
    self.imageArray = [[NSMutableArray alloc]init];
    self.imagePathArray = [[NSMutableArray alloc]init];
    self.imageFullPathArray = [[NSMutableArray alloc]init];

    WZUser *user = [WZUser me];
    NSString *string = user.postImage;
    
    NSString *picServerPath = @"http://172.168.1.116:4000/fileServer/showImages?fileUrl=";
    
    
    
    if (user.postImage && ![user.postImage isEqualToString:@""])
    {
        NSArray *arr = [string componentsSeparatedByString: @","];
        for (int i=0; i< arr.count;i++)
        {
            NSString *imageNoServerUrl = [arr objectAtIndex:i];
            NSString *imageUrl = [picServerPath stringByAppendingString:[arr objectAtIndex:i]];
            
            
            UIImage *myImage2 =[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]]];
            if (myImage2)
            {
                [self.imageArray addObject:myImage2];
                [self.imagePathArray addObject:imageNoServerUrl];
                [self.imageFullPathArray addObject:imageNoServerUrl];
            }
        }
        //self.imagePathArray = [[NSMutableArray alloc]init];
    }
  
    [self.imageArray addObject:image];

    

    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:@"取消"
                                                                      style:UIBarButtonItemStylePlain
                                                                     target:self
                                                                     action:@selector(goback)];
    self.navigationItem.leftBarButtonItem = leftButton;

    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithTitle:@"发布"
                                                                      style:UIBarButtonItemStylePlain
                                                                     target:self
                                                                     action:@selector(sendWeibo)];
    self.navigationItem.rightBarButtonItem = anotherButton;
    

    createWeiboTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 480) style:UITableViewStyleGrouped];
    createWeiboTableView.dataSource = self;
    createWeiboTableView.delegate = self;
    [self.view addSubview:createWeiboTableView];
    
    
    //初始化文本框
    weiboTextView = [[UITextView alloc]initWithFrame:CGRectMake(10, 10, 280, 80)];
    weiboTextView.font = [UIFont systemFontOfSize:14];
    weiboTextView.delegate = self;

    
    //添加点击手势--点击撤销键盘
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    gestureRecognizer.cancelsTouchesInView = NO;
    [createWeiboTableView addGestureRecognizer:gestureRecognizer];

}

//tableview------------------------------------start--------------------------------------------------
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [tempDict allKeys].count;//返回分组数量,即Array的数量
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSString *key=[tempArray objectAtIndex:section];//返回当前分组对应neighbourDict的key值
    NSArray *sectionArray=[tempDict objectForKey:key];//根据key，取得Array
    return [sectionArray count]; //返回Array的大小
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * tableIdentifier=@"CreateWeiboCell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:tableIdentifier];
    if(cell==nil){
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];
    }
    
    NSString *key = [tempArray objectAtIndex:[indexPath section]];
    NSArray *section = [tempDict objectForKey:key];
    NSString *type = [section objectAtIndex:[indexPath row]];
    switch ([type intValue]) {
        case 1://设置文本框
            [cell.contentView addSubview:weiboTextView];
            cell.frame = CGRectMake(0, 0, 320, 100);
            break;
        case 2:{//设置图片
            
            UIButton *imgBtn;
            int imgBtnX = 20, imgBtnY = 10;
            if(self.imageArray.count > 0){
                int imgBtnHeight = 60, imgBtnWidth = 60;
                for (int i=0; i<self.imageArray.count; i++) {
                    UIImage *imageName = [self.imageArray objectAtIndex:i];
                    imgBtn = [[UIButton alloc] initWithFrame:CGRectMake(imgBtnX,imgBtnY,imgBtnHeight,imgBtnWidth)];
                      [imgBtn setBackgroundImage:imageName forState:UIControlStateNormal];
                    if (i == self.imageArray.count - 1) {
                        
                        [imgBtn addTarget:self action:@selector(showImageRes) forControlEvents:UIControlEventTouchUpInside];
                    }else{
                      
                        [imgBtn addTarget:self action:@selector(showImage:) forControlEvents:UIControlEventTouchUpInside];
                    }
                    imgBtn.tag = i;//将imgageArray下标赋给tag
                    if (self.imageArray.count > 1) {
                        //每行4个，到第四个图片
                        if ((i+1)%4 == 0 && (i+1) < self.imageArray.count) {
                            imgBtnX = 20;
                            imgBtnY = imgBtnY+imgBtnHeight+5;
                        }else{
                            imgBtnX = imgBtnX+imgBtnWidth+10;
                        }
                    }
                    [cell addSubview:imgBtn];
                }
                imgBtnY = imgBtnY + imgBtnHeight+10;//cell总高度
            }
            cell.backgroundColor = [UIColor colorWithRed:240.0 green:241.0 blue:242.0 alpha:1.0];
            cell.frame = CGRectMake(0, 0, 320, imgBtnY);
            break;
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [self tableView:createWeiboTableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"";
}

//tableview-----------------------------end---------------------------------------------------------
- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//取消按钮
-(void)goback{
    //[createWeiboReq cancel];
    [self dismissViewControllerAnimated:YES completion:nil];
}

//文字键盘和表情键盘切换
-(void)showPhraseInfo{
    if (faceBoardShow) {//打开文字键盘
        [weiboTextView resignFirstResponder];
                weiboTextView.inputView = nil;
        weiboTextView.keyboardType = UIKeyboardTypeDefault;
        [weiboTextView becomeFirstResponder];
        faceBoardShow = NO;
    }else{//打开表情键盘
        [weiboTextView resignFirstResponder];
        
        [weiboTextView becomeFirstResponder];
        faceBoardShow = YES;
    }
}

//文本框回调赋值(文字、表情)
-(void) setParentText:(NSString *)inputText{
    NSMutableString *tempStr = [[NSMutableString alloc]initWithString:weiboTextView.text];
    [tempStr appendString:inputText];
    weiboTextView.text = tempStr;
}

//弹出选项列表选择图片来源
- (void)showImageRes {
    UIActionSheet *chooseImageSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"从相册选择",@"相机", nil];
    [chooseImageSheet showInView:self.view];
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
            //从相册选择
            [self openPhotoLibray];
            break;
        case 1:
            //拍照
            [self openCamera];
            break;
        default:
            break;
    }
}

//打开图片库
-(void)openPhotoLibray{
    UIImagePickerController *mImagePicker=[[UIImagePickerController alloc]init];
    mImagePicker.sourceType=UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    mImagePicker.delegate= self;
    [self presentViewController:mImagePicker animated:YES completion:nil];
}

//拍照
-(void)openCamera{
    //资源类型为照相机
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    //判断是否有相机
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]){
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        //设置拍照后的图片可被编辑
        picker.allowsEditing = YES;
        //资源类型为照相机
        picker.sourceType = sourceType;
        [self presentViewController:picker animated:YES completion:nil];
        //        [self presentModalViewController:picker animated:YES];
        //        [picker release];
    }else {
        NSLog(@"该设备无摄像头");
    }
}

//获取图库图片
//获取图库图片
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *image= [info objectForKey:UIImagePickerControllerOriginalImage];
    
    UIImage *bolgImage = [ImageUtil imageWithImageSimple:image scaledToSize:CGSizeMake(image.size.width, image.size.height)];
    //用时间戳作为图片名称,并创建图片
    //    NSString *imageName = [NSString stringWithFormat:@"%ld.png", (long)[[NSDate date] timeIntervalSince1970]];
    //    imagePath = [[LocalDirectory imageFileDirectory] stringByAppendingPathComponent:imageName];
    //    [[NSFileManager defaultManager] createFileAtPath:imagePath contents:UIImageJPEGRepresentation(bolgImage, 0.5) attributes:nil];
    
    NSString *urlString = @"http://172.168.1.116:4000/imageUploadServer";
    
    NSData *data = UIImagePNGRepresentation(bolgImage);//获取图片数据
    
    NSMutableData *imageData = [NSMutableData dataWithData:data];
    NSURL *url = [NSURL URLWithString:urlString];
    ASIFormDataRequest *aRequest = [[ASIFormDataRequest alloc] initWithURL:url];
    [aRequest setDelegate:self];//代理
    
    [aRequest setRequestMethod:@"POST"];
    
    [aRequest setData:imageData withFileName:@"myphoto.jpg" andContentType:@"image/jpeg" forKey:@"postImage"];
    
    // [aRequest setPostValue:imageData forKey:@"file"];
    [aRequest addRequestHeader:@"Content-Type" value:@"binary/octet-stream"];//这里的value值 需与服务器端 一致
    
    [aRequest startAsynchronous];//开始。异步
    [aRequest setDidFinishSelector:@selector(uploadPicSucceed:)];//当成功后会自动触发 headPortraitSuccess 方法
    [aRequest setDidFailSelector:@selector(uploadPicfailed:)];//如果失败会 自动触发 headPortraitFail 方法
    
    
    
    
    
    
    
    //如果当前图片数量已经为9,删掉最后一个添加图片,将新的图片放入集合
    if (self.imageArray.count == 9 && [[self.imageArray lastObject] isEqualToString:@"more.png"])
    {
        NSLog(@"%@",self.imageArray);
        [self.imageArray insertObject:bolgImage atIndex:(self.imageArray.count-1)];//在最后位置放入对象
        NSLog(@"%@",self.imageArray);
        [self.imageArray removeLastObject];//删除最后一个对象(more)
        NSLog(@"%@",self.imageArray);
        
    }else{
        
        [self.imageArray insertObject:bolgImage atIndex:(self.imageArray.count-1)];//插入到(imgageArray.count-1)前面一个位置
    }
    
    
    [UIWindow lock];
    
    [createWeiboTableView reloadData];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}


- (void)uploadPicSucceed:(ASIFormDataRequest *)notification
{
    
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    NSDictionary *tempDict = [parser objectWithString:notification.responseString];
    NSString *faceImageId = [tempDict objectForKey:@"fileUrl"];
    NSString *imgServerId = [tempDict objectForKey:@"fileFullUrl"];
    
    [self.imagePathArray addObject:faceImageId];
    [self.imageFullPathArray addObject:faceImageId];
    NSLog(@"blog回调结果:%@",self.imageFullPathArray);
    //    WZUser *user = [WZUser me];
    //    user.faceIcon = imgServerId;
    //    [[RKObjectManager sharedManager].objectStore save:nil];
    
    NSLog(@"blog回调结果:%@",notification.responseString);
    [[NSNotificationCenter defaultCenter] removeObserver:self name:WZUpLoadPicFailedNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:WZUpLoadPicSucceedNotification object:nil];
    [UIWindow unlock];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"头像上传成功" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil];
    
    
    [alert show];
    
}

- (void)uploadPicfailed:(ASIFormDataRequest *)notification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:WZUpLoadPicFailedNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:WZUpLoadPicSucceedNotification object:nil];
    [UIWindow unlock];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"头像上传失败" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil];
        [alert show];
}
//全屏打开图片
-(void) showImage:(id)sender{
    UIButton *btn = (UIButton *)sender;
    NSLog(@"%d",btn.tag);
    //通过放入btn里的集合下标，在imgkeyarray里找出对应image的key值,再通过key值在imgDict里找到image
    UIImage *image = [self.imageArray objectAtIndex:btn.tag];
    ImageBrowseViewController *imageBrowseViewController = [[ImageBrowseViewController alloc] initWithImageName:image];
	[imageBrowseViewController setDelegate:self];
    [self.navigationController pushViewController:imageBrowseViewController animated:YES];
}
//删除图片
-(void)trashWithImageName:(UIImage *)_imageName{
    //如果当前图片数组的最后一个对象不是more
      int index;
    for (int i=0; i<self.imageArray.count; i++) {
        UIImage *delImageName = [self.imageArray objectAtIndex:i];
        if (delImageName == _imageName)
        {
            index = i;
        }
    }
    if (self.imageArray.count == 9 && ![[self.imageArray lastObject] isEqualToString:@"more.png"]) {//如果图片数==9
        [self.imageArray removeObject:_imageName];
      
        [self.imagePathArray removeObjectAtIndex:index];
        [self.imageFullPathArray removeObjectAtIndex:index];
        UIImage *image = [UIImage imageNamed:@"more.png"];
        [self.imageArray addObject:image];
        
    
    }else{
        [self.imageArray removeObject:_imageName];
        [self.imagePathArray removeObjectAtIndex:index];
        [self.imageFullPathArray removeObjectAtIndex:index];
    }
    [createWeiboTableView reloadData];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)sendWeibo{
    NSLog(@"发微博啦！");
    //调用user接口保存图片
    WZUser *user = [WZUser me];
    
    
    NSLog(@"%@",self.imageFullPathArray);
    NSString *oldPath=@"";
      if (self.imageFullPathArray.count !=0)
        {
            for (int i =0; i<self.imageFullPathArray.count;i++)
            {
                NSString *path = [self.imageFullPathArray objectAtIndex:i];
                if (i == self.imageFullPathArray.count - 1)
                {
                    NSString *fullPath = @"";
//                    fullPath = [picServerPath stringByAppendingString:fullPath];
                    fullPath = [fullPath stringByAppendingString:path];
                    oldPath = [oldPath stringByAppendingString:fullPath];
                }
                else
                {
                    NSString *fullPath = @"";
//                    fullPath = [picServerPath stringByAppendingString:fullPath];
                    fullPath = [fullPath stringByAppendingString:path];

                    fullPath = [ fullPath stringByAppendingString:@","];
                    oldPath = [oldPath stringByAppendingString:fullPath];
                }
                
            }
        }
//    NSLog(@"fullPath==%@",oldPath);
//        user.postImage =oldPath;
//    NSLog(@"fullPath==%@",oldPath);
//        [[RKObjectManager sharedManager].objectStore save:nil];
    
      [self dismissViewControllerAnimated:YES completion:nil];
}



- (void) hideKeyboard {
    [weiboTextView resignFirstResponder];
    weiboTextView.inputView = nil;
    weiboTextView.keyboardType = UIKeyboardTypeDefault;
    faceBoardShow = NO;
    
}

#pragma mark  -------邻居说列表请求回调----------
-(void)createBlogSuccess:(NSNotificationCenter*)request{
        [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark  -------请求错误--------
- (void)requestError:(NSNotificationCenter*)request{
    
    UIAlertView *av=[[UIAlertView alloc]initWithTitle:@"梧桐邑" message:@"服务器异常" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles: nil];
    [av show];
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
