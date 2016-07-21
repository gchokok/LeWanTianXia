//
//  PoetryDetailViewController.m
//  BaseProject
//
//  Created by apple on 16/7/20.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "PoetryDetailViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface PoetryDetailCell : UITableViewCell
@property(nonatomic,strong) UILabel *label;

@end
@implementation PoetryDetailCell
- (UILabel *)label {
    if(_label == nil) {
        _label = [[UILabel alloc] init];
        _label.font = [UIFont systemFontOfSize:18];
        _label.numberOfLines = 0;
    }
    return _label;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.label];
        [_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(10, 10, 10, 10));
        }];
    }
    return self;
}


@end

@interface PoetryDetailViewController ()<UITableViewDataSource,UITableViewDelegate,AVSpeechSynthesizerDelegate>
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) UIBarButtonItem *readItem;
@property(nonatomic,strong) AVSpeechSynthesizer *spe;
@end

@implementation PoetryDetailViewController

- (id)initWithShi:(NSString *)shi intro:(NSString *)shiIntro{
    if (self = [super init]) {
        _shi = shi;
        _shiIntro = shiIntro;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    self.navigationItem.rightBarButtonItem = self.readItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - UITableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @[@"诗词赏析", @"注解"][section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PoetryDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell.label.text = @[_shi, _shiIntro][indexPath.section];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

- (UITableView *)tableView {
	if(_tableView == nil) {
		_tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.allowsSelection = NO;
        _tableView.tableFooterView = [UIView new];
        [_tableView registerClass:[PoetryDetailCell class] forCellReuseIdentifier:@"Cell"];
	}
	return _tableView;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.spe stopSpeakingAtBoundary:AVSpeechBoundaryImmediate];
}

- (UIBarButtonItem *)readItem {
	if(_readItem == nil) {
		_readItem = [[UIBarButtonItem alloc] bk_initWithTitle:@"朗读" style:UIBarButtonItemStyleDone handler:^(id sender) {
            if (self.spe.speaking) {
                [self.spe stopSpeakingAtBoundary:AVSpeechBoundaryWord];
                return;
            }
            NSString *str = [_shi stringByAppendingString:_shiIntro];
            AVSpeechUtterance *utt = [AVSpeechUtterance speechUtteranceWithString:str];
            utt.voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"zh_CN"];
            [self.spe speakUtterance:utt];
        }];
	}
	return _readItem;
}

- (AVSpeechSynthesizer *)spe {
	if(_spe == nil) {
		_spe = [[AVSpeechSynthesizer alloc] init];
        _spe.delegate = self;
	}
	return _spe;
}

- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didStartSpeechUtterance:(AVSpeechUtterance *)utterance{
    self.readItem.title = @"停止";
}
- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didFinishSpeechUtterance:(AVSpeechUtterance *)utterance{
    self.readItem.title = @"朗读";
}
- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didCancelSpeechUtterance:(AVSpeechUtterance *)utterance{
    self.readItem.title = @"朗读";
}

@end
