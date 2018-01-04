//
//  NBViewController.m
//  NBHttpTool
//
//  Created by 260497176@qq.com on 10/16/2017.
//  Copyright (c) 2017 260497176@qq.com. All rights reserved.
//

#import "NBViewController.h"
#import "NBHttpTool.h"


@interface NBViewController ()
@property (weak, nonatomic) IBOutlet UILabel *uulbl;
@property(nonatomic, strong) NBHttpTool *httpTool;
@end

@implementation NBViewController

- (NBHttpTool *)httpTool
{
    if (_httpTool == nil) {
        _httpTool = [[NBHttpTool alloc] init];
    }
    return _httpTool;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.uulbl.userInteractionEnabled = YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSDictionary *parame = @{
                           @"TOP":@"5"
                           };

    [self.httpTool setValue:@"0ba1ee7d-25d2-47f4-8b75-79af9f8ad6bc" forHTTPHeaderField:@"USER"];
    [self.httpTool setValue:@"6107FD4FFDC8332A2ACC1EFB9577F0B1" forHTTPHeaderField:@"TOKEN"];
    [self.httpTool request:NBHttpTypePOST urlStr:@"http://data.chinacpc.org/API/App/GetNews" parameter:parame resultBlock:^(id responseObject, NSError *error) {
        NSLog(@"%@",responseObject);
    }];
}

//字典转字符串
- (NSString*)dictionaryToJson:(NSDictionary *)dic

{
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}
@end
