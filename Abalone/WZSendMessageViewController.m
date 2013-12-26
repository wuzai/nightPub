//
//  WZSendMessageViewController.m
//  Abalone
//
//  Created by chen  on 13-12-23.
//  Copyright (c) 2013年 曹昊. All rights reserved.
//

#import "WZSendMessageViewController.h"
#import "WZMessage+Networks.h"
#import "WZUser+me.h"
#import "UIWindow+Lock.h"

@interface WZSendMessageViewController ()

@end

@implementation WZSendMessageViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	self.title = @"添加评论";
    
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
    UIBarButtonItem *closeItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(closeKeyboard:)];
    UIBarButtonItem *flexible = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    toolbar.items = @[flexible,closeItem];
    self.content.inputAccessoryView = toolbar;
    self.content.delegate = self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sendCommentSuccess:) name:WZSendMessageSucceedNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sendCommentFail:) name:WZSendMessageFailedNotification object:nil];
}

-(void)closeKeyboard:(id)sender
{
    [self.content  resignFirstResponder];
}

-(void)updateWordsNum
{
    NSString *textNum = [NSString stringWithFormat:@"%i/200",self.content.text.length];
    self.wordNum.text = textNum;
}

-(void)textViewDidBeginEditing:(UITextView *)textView
{
    CGRect frame = self.content.frame;
    frame.size.height = 80;
    self.content.frame = frame;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(languageChanged:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

-(void)textViewDidChange:(UITextView *)textView
{
    NSUInteger num = self.content.text.length;
    if (num < 200) {
        [self updateWordsNum];
    }else{
        self.content.text = [self.content.text substringToIndex:200];
    }
}

-(void)textViewDidEndEditing:(UITextView *)textView
{
    CGRect frame = self.content.frame;
    frame.size.height = 145;
    self.content.frame = frame;
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
}


-(void)languageChanged:(NSNotification *)notification
{
    NSDictionary *userInfo = [notification userInfo];
    NSValue *value1 = [userInfo valueForKey:UIKeyboardFrameBeginUserInfoKey];
    NSValue *value2 = [userInfo valueForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect frame1,frame2;
    [value1 getValue:&frame1];
    [value2 getValue:&frame2];
    CGFloat height = frame2.size.height - frame1.size.height;
    CGRect frame = self.content.frame;
    frame.size.height -= height;
    self.content.frame = frame;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    if (self.view.window == nil) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:WZSendMessageSucceedNotification object:nil];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:WZSendMessageFailedNotification object:nil];
    }
    
}

- (IBAction)sendMessage:(id)sender {
    
    NSString *cleanString = [self.content.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (!cleanString.length) {
        [[[UIAlertView alloc]initWithTitle:@"提示" message:@"请输入有效数据 " delegate:nil  cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
        
    }else{
        [UIWindow lock];
        [WZMessage sendMessage:self.content.text by:[WZUser me] toUserId:self.toUser];
    }
    
}

-(void)sendCommentSuccess:(NSNotification *)notification
{
    [UIWindow unlock];
    
    WZMessage *comment = [[notification object] lastObject];
    comment.toUserId = self.toUser.gid;
    comment.send = [WZUser me];
    comment.content = self.content.text;
    //comment.createdAt = [NSDate date];
   
    [[RKObjectManager sharedManager].objectStore save:nil];
    
    self.content.text = nil;
    [[[UIAlertView alloc]initWithTitle:@"提示" message:@"感谢您的评论！ " delegate:nil  cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
}

-(void)sendCommentFail:(NSNotification *)notification
{
    [UIWindow unlock];
    [[[UIAlertView alloc]initWithTitle:@"提示" message:@"评论失败，请检查网络！" delegate:nil  cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
}


@end