//
//  ViewController.m
//  sample
//
//  Created by KentarOu on 2014/02/11.
//  Copyright (c) 2014年 KentarOu. All rights reserved.
//

#import "ViewController.h"
#import "CustomCell.h"
#import "ExampleViewController.h"

@interface ViewController ()
{
    NSMutableString *checkString;
    NSMutableArray *titleArray;
    NSMutableArray *contentArray;
    
    NSMutableArray *regular_ExpressionTitle;
    NSMutableArray *regular_ExpressionContent;
    NSMutableArray *regular_ExpressionEx;
}

@property (weak, nonatomic) IBOutlet UITextField *regularExpressionTXT;
@property (weak, nonatomic) IBOutlet UITextField *checkStringTXT;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    checkString = [[NSMutableString alloc]initWithCapacity:0];
    
    
    // plistから配列を読み込み
    NSString *path = [[NSBundle mainBundle]pathForResource:@"RE" ofType:@"plist"];
    NSDictionary* dictionary = [NSDictionary dictionaryWithContentsOfFile:path];
    
    titleArray = [[NSArray arrayWithArray:[dictionary objectForKey:@"String_title"]]mutableCopy];
    contentArray = [[NSArray arrayWithArray:[dictionary objectForKey:@"String_contents"]]mutableCopy];
    regular_ExpressionTitle = [[NSArray arrayWithArray:[dictionary objectForKey:@"RE_title"]]mutableCopy];
    regular_ExpressionContent = [[NSArray arrayWithArray:[dictionary objectForKey:@"RE_contents"]]mutableCopy];
    regular_ExpressionEx = [[NSArray arrayWithArray:[dictionary objectForKey:@"RE_Exsample"]]mutableCopy];
    
    
    
    NSString *s = @"(&|\\?|&amp;)+media=";
    NSString *ss = @"aaa&amp;media=";
    
    NSRange match = [ss rangeOfString:s options:NSRegularExpressionSearch];
    if (match.location != NSNotFound) {
        NSLog(@"Found: %@",[ss substringWithRange:match]);
        
    } else {
        NSLog(@"Not Found");
    }
    
    

    
    // 設定をplistから読み込まない場合
    // titleArray = [@[@"全角ひらがな",@"全角カタカナ",@"半角カタカナ",@"全角大文字アルファベット",@"全角小文字アルファベット",@"半角大文字アルファベット",@"半角小文字アルファベット",@"全角数字",@"半角数字",@"全角記号",@"半角記号"]mutableCopy];
    // contentArray = [@[@"あかさたながぴ",@"アカサタナガピ",@"ｱｶｻﾀﾅｶﾞﾋﾟ",@"ＡＢＣＥＦＧ",@"Ａｂｃｄｅｆｇ",@"ABCDEFG",@"abcdefg",@"１２３４５６７８９０",@"1234567890",@"！”＃＄％＆’’（）＝〜｜",@"!\"#$%&'())=~|"]mutableCopy];
    //  regular_ExpressionTitle = [@[@"アルファベットのみ入力可",@"cが入っていること",@"先頭がbで終わりがkの文字列4文字",@"先頭がaで始まる",@"最後がhで終わる",@"先頭が00〜99で始まる",@"空文字@\"\"のみOK"]mutableCopy];
    // regular_ExpressionContent = [@[@"^[A-Za-z]+$",@"c+",@"^b..k$",@"^a",@"h$",@"^[0-9][0-9]",@"^$"]mutableCopy];
    
    NSString *str = @"^[A-Za-z0-9]!#$%&\\’*+\\/=?^_`{|}~-]+(?:\\.[A-Za-z0-9]!#$%&\\’*+\\/=?^_`{|}~-]*)*@(?:[A-Z_a-z0-9][A-Z-a-z0-9]*\\.)*(?:[A-Za-z0-9][A-Z-a-z0-9]{0,62})\\.(?:?:[A-Za-z]{2}.)?[A-Za-z]{2,})$";
    

    
    
    [self.tableView registerNib:[UINib nibWithNibName:@"CustomCell" bundle:nil] forCellReuseIdentifier:@"CustomCell"];
    self.tableView.rowHeight = 50.0f;
    
    
    // Exsample画面遷移
    UIBarButtonItem *bar = [[UIBarButtonItem alloc]initWithTitle:@"Ex." style:UIBarButtonItemStyleBordered target:self action:@selector(exsampleViewOpen:)];
    self.navigationItem.rightBarButtonItem = bar;
    
    
    // keyboard Notification
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [nc addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 50;
    } else if (indexPath.section == 1) {
        if (indexPath.row == 18) {
            return 80;
        } else {
            return 80;
        }
    }
    
    return 0;
}


- (void) keyboardDidShow:(NSNotification*)notify
{
//    [UIView animateWithDuration:0.25 animations:^{
//        self.tableView.frame = CGRectMake(self.tableView.frame.origin.x, self.tableView.frame.origin.y, self.tableView.frame.size.width, self.tableView.frame.size.height - 216);
//    }];
}

- (void) keyboardWillHide:(NSNotification*)notify
{
//    CGPoint p = self.tableView.contentOffset;
//   // [self.tableView setContentOffset:CGPointZero animated:NO];
//    [self.tableView setContentOffset:p];
    
//    [UIView animateWithDuration:0.25 animations:^{
//        self.tableView.frame = CGRectMake(self.tableView.frame.origin.x, self.tableView.frame.origin.y, self.tableView.frame.size.width, self.tableView.frame.size.height + 216);
//        
//    }];
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
     [self performSelector:@selector(delayCheck) withObject:nil afterDelay:0.3];
    return YES;
}

- (void)exsampleViewOpen:(UIButton*)sender
{
    ExampleViewController *sample = [ExampleViewController new];
    sample.title = @"Exsample";
    [self.navigationController pushViewController:sample animated:YES];
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return @"文字入力";
    } else {
        return @"正規表現";
    }
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return titleArray.count;
    } else {
        return regular_ExpressionTitle.count;
    }
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CustomCell";
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[CustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    for (UIView *v in [cell.contentView subviews]) {
        if (v.tag == 999) {
            [v removeFromSuperview];
        }
    }
    
    if (indexPath.section == 0) {
        cell.titleLabel.text = titleArray[indexPath.row];
        cell.contentLabel.text = contentArray[indexPath.row];
        cell.exsampleLabel.hidden = YES;
        
    } else {
        cell.titleLabel.text = regular_ExpressionTitle[indexPath.row];
        cell.contentLabel.text = regular_ExpressionContent[indexPath.row];
        cell.exsampleLabel.text = regular_ExpressionEx[indexPath.row];
        cell.exsampleLabel.hidden = NO;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    CustomCell *cell = (CustomCell*)[tableView cellForRowAtIndexPath:indexPath];
    
    [self getCheckString];
    
    if (indexPath.section == 0) {
        
        [checkString appendString:cell.contentLabel.text];
        self.checkStringTXT.text = checkString;
        
    } else if (indexPath.section == 1){
        
        self.regularExpressionTXT.text = cell.contentLabel.text;
        self.checkStringTXT.text = cell.exsampleLabel.text ;
    }
    
    [self delayCheck];
}

// スクロール開始時キーボードを下げる
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)getCheckString
{
    checkString = [self.checkStringTXT.text mutableCopy];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    [self performSelector:@selector(delayCheck) withObject:nil afterDelay:0.3];
    return YES;
}

- (void)delayCheck
{
    if ([self regularExpression:self.checkStringTXT.text]) {
        self.checkStringTXT.backgroundColor = [UIColor greenColor];
    } else {
        
        self.checkStringTXT.backgroundColor = [UIColor redColor];
    }
}


- (BOOL)regularExpression:(NSString *)string
{
    NSRange match = [string rangeOfString:self.regularExpressionTXT.text options:NSRegularExpressionSearch];
    if (match.location != NSNotFound) {
        NSLog(@"Found: %@",[string substringWithRange:match]);
        
    } else {
        NSLog(@"Not Found");
    }
    return (match.location != NSNotFound);
}

@end
