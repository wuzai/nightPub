//
//  WZCreateBulletinViewController.m
//  Abalone
//
//  Created by chen  on 13-11-28.
//  Copyright (c) 2013年 曹昊. All rights reserved.
//

#import "WZCreateBulletinViewController.h"
#import "WZBulletin+Networks.H"
#import "WZUser+Me.h"
#import "UIWindow+Lock.h"



@interface WZCreateBulletinViewController ()

@end

@implementation WZCreateBulletinViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	self.title = @"添加评论";
    
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
    UIBarButtonItem *closeItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(closeKeyboard:)];
    UIBarButtonItem *flexible = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    toolbar.items = @[flexible,closeItem];
    self.contentTextView.inputAccessoryView = toolbar;
    self.contentTextView.delegate = self;
    self.titleTextView.inputAccessoryView = toolbar;
    self.titleTextView.delegate = self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sendCommentSuccess:) name:WZBulletinAddSuccessNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sendCommentFail:) name:WZBulletinAddFailedNotification object:nil];
}

-(void)closeKeyboard:(id)sender
{
    [self.contentTextView  resignFirstResponder];
    [self.titleTextView  resignFirstResponder];
}

-(void)updateWordsNum
{
    NSString *textNum = [NSString stringWithFormat:@"%i/200",self.contentTextView.text.length];
    self.textCountLabel.text = textNum;
}

-(void)updateTitleWordsNum
{
    NSString *textNum = [NSString stringWithFormat:@"%i/50",self.titleTextView.text.length];
    self.titleCountLabel.text = textNum;
}


-(void)textViewDidBeginEditing:(UITextView *)textView
{
    CGRect frame = self.contentTextView.frame;
    frame.size.height = 80;
    self.contentTextView.frame = frame;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(languageChanged:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

-(void)textViewDidChange:(UITextView *)textView
{
    if (textView == self.contentTextView)
    {
        NSUInteger num = self.contentTextView.text.length;
        if (num < 200) {
            [self updateWordsNum];
        }
        else{
            self.contentTextView.text = [self.contentTextView.text substringToIndex:200];
        }
    }
    else
    {
        NSUInteger num = self.titleTextView.text.length;
        if (num < 50) {
            [self updateTitleWordsNum];
        }
        else{
            self.titleTextView.text = [self.titleTextView.text substringToIndex:50];
        }

    }
    
}

-(void)textViewDidEndEditing:(UITextView *)textView
{
    CGRect frame = self.contentTextView.frame;
    frame.size.height = 145;
    self.contentTextView.frame = frame;
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
    CGRect frame = self.contentTextView.frame;
    frame.size.height -= height;
    self.contentTextView.frame = frame;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    if (self.view.window == nil) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:WZBulletinAddSuccessNotification object:nil];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:WZBulletinAddFailedNotification object:nil];
    }
    
}

- (IBAction)createBulletin:(id)sender
{
    
    NSString *cleanString = [self.contentTextView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (!cleanString.length) {
        [[[UIAlertView alloc]initWithTitle:@"提示" message:@"请输入有效数据 " delegate:nil  cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
        
    }else{
        [UIWindow lock];
        
        [WZBulletin  createBulletin:self.contentTextView.text with:self.titleTextView.text by:[WZUser me]];
    }
    
}

-(void)sendCommentSuccess:(NSNotification *)notification
{
    [UIWindow unlock];
    
    WZBulletin *comment = [[notification object] lastObject];
    comment.user = [WZUser me];
    comment.title = self.titleTextView.text;
    
    comment.createAt = [NSDate date];
    comment.content = [self.contentTextView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    [[RKObjectManager sharedManager].objectStore save:nil];
    self.titleTextView.text = nil;
    self.contentTextView.text = nil;
    [[[UIAlertView alloc]initWithTitle:@"提示" message:@"感谢您的评论！ " delegate:nil  cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
}

-(void)sendCommentFail:(NSNotification *)notification
{
    [UIWindow unlock];
    [[[UIAlertView alloc]initWithTitle:@"提示" message:@"评论失败，请检查网络！" delegate:nil  cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
}
@end
