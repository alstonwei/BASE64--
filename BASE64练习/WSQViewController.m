//
//  WSQViewController.m
//  BASE64练习
//
//  Created by Shouqiang Wei on 14-4-30.
//  Copyright (c) 2014年 Shouqiang Wei. All rights reserved.
//

#import "WSQViewController.h"
#import "GTMBase64.h"

@interface WSQViewController ()
@property (weak, nonatomic) IBOutlet UIButton *btnEncodeClicked;
- (IBAction)btnDecodeClicked:(id)sender;
- (IBAction)btnEncodeClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UITextView *txtOrigin;
@property (weak, nonatomic) IBOutlet UITextView *txtEncode;
@property (weak, nonatomic) IBOutlet UITextView *txtDecode;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segment;

@end

@implementation WSQViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"%d",_segment.selectedSegmentIndex);
	NSString* originStr = @"Man";  // base64 编码后的正确结果 TWFu

    NSData* originData = [originStr dataUsingEncoding:NSASCIIStringEncoding];
    NSString* encodeResult = [originData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    NSLog(@"encodeResult:%@",encodeResult);



    NSData* decodeData = [[NSData alloc] initWithBase64EncodedString:encodeResult options:0];
    NSString* decodeStr = [[NSString alloc] initWithData:decodeData encoding:NSASCIIStringEncoding];
    NSLog(@"decodeStr：%@",decodeStr);
}


- (IBAction)btnDecodeClicked:(id)sender {
    [self decodeStr];
}

- (IBAction)btnEncodeClicked:(id)sender {
    [self encodeStr];
}

/**
 *GTM 转码
 */
-(void)GTMEncodeTest
{
    NSString* originStr = @"Man";
    NSString* encodeResult = nil;
    NSData* originData = [originStr dataUsingEncoding:NSUTF8StringEncoding];
    NSData* encodeData = [GTMBase64 encodeData:originData];
    encodeResult = [[NSString alloc] initWithData:encodeData encoding:NSUTF8StringEncoding];
    NSLog(@"%@",encodeResult);
}

/**
 * GTM 解码
 */
-(void)GMTDecodeTest
{
    NSString* encodeStr = @"TWFu";
    NSString* decodeResult = nil;
    NSData* encodeData = [encodeStr dataUsingEncoding:NSUTF8StringEncoding];
    NSData* decodeData = [GTMBase64 decodeData:encodeData];
    decodeResult = [[NSString alloc] initWithData:decodeData encoding:NSUTF8StringEncoding];
    NSLog(@"%@",decodeResult);
}


/**
 *   编码
 *
 *  @return <#return value description#>
 */
-(NSString*)encodeStr
{

    NSString* originStr = _txtOrigin.text;
    NSString* encodeResult = nil;
    if (_segment.selectedSegmentIndex == 0) {
        NSData* originData = [originStr dataUsingEncoding:NSASCIIStringEncoding];
        encodeResult = [originData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    }
    else
    {
        NSData* originData = [originStr dataUsingEncoding:NSUTF8StringEncoding];
        NSData* encodeData = [GTMBase64 encodeData:originData];
        encodeResult = [[NSString alloc] initWithData:encodeData encoding:NSUTF8StringEncoding];


    }

    _txtEncode.text = encodeResult;
    return encodeResult;
}


/**
 *  解码
 *
 *  @return <#return value description#>
 */
-(NSString*)decodeStr
{

    NSString* encodeStr = _txtEncode.text;
    NSString* decodeResult = nil;
    if (_segment.selectedSegmentIndex == 0) {
        NSData* decodeData = [[NSData alloc] initWithBase64EncodedString:encodeStr options:0];
        decodeResult = [[NSString alloc] initWithData:decodeData encoding:NSASCIIStringEncoding];
    }
    else
    {

        NSData* encodeData = [encodeStr dataUsingEncoding:NSUTF8StringEncoding];
        NSData* decodeData = [GTMBase64 decodeData:encodeData];
        decodeResult = [[NSString alloc] initWithData:decodeData encoding:NSUTF8StringEncoding];
    }

    _txtDecode.text = decodeResult;
    return decodeResult;


}



-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{

    NSLog(@"xxxx%d",_segment.selectedSegmentIndex);
    [[UIApplication sharedApplication] respondsToSelector:@selector(resignFirstResponder)];

    [_txtDecode resignFirstResponder];
    [_txtEncode resignFirstResponder];
    [_txtOrigin resignFirstResponder];
}









@end
