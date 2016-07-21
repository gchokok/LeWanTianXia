//
//  KindIntroViewController.m
//  BaseProject
//
//  Created by apple on 16/7/19.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "KindIntroViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface KindIntroViewController ()<AVSpeechSynthesizerDelegate>
@property(nonatomic,strong) UITextView *textView;
@property(nonatomic,strong) UIBarButtonItem *readItem;
@property(nonatomic,strong) AVSpeechSynthesizer *spe;
@end

@implementation KindIntroViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.textView];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    self.textView.text = _introKind;
    self.textView.contentOffset = CGPointMake(0, 0);
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

- (UITextView *)textView {
	if(_textView == nil) {
		_textView = [[UITextView alloc] init];
        _textView.font=[UIFont systemFontOfSize:18];
        _textView.editable = NO;
	}
	return _textView;
}

- (UIBarButtonItem *)readItem{
    if (!_readItem) {
        _readItem = [[UIBarButtonItem alloc] bk_initWithTitle:@"朗读" style:UIBarButtonItemStyleDone handler:^(id sender) {
            if (self.spe.speaking) {
                [self.spe stopSpeakingAtBoundary:AVSpeechBoundaryWord];
                return;
            }
            AVSpeechUtterance *utt =[AVSpeechUtterance speechUtteranceWithString:_introKind];
            utt.voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"zh_CN"];
            [self.spe speakUtterance:utt];
            
        }];
    }
    return _readItem;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.spe stopSpeakingAtBoundary:AVSpeechBoundaryImmediate];
}

- (AVSpeechSynthesizer *)spe{
    if (!_spe) {
        _spe = [AVSpeechSynthesizer new];
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
