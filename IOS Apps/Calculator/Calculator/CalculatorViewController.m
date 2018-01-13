//
//  CalculatorViewController.m
//  Calculator
//
//  Created by LI Admin on 5/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CalculatorViewController.h"
#import "CalculatorBrain.h"

@interface CalculatorViewController ()

@property (nonatomic) BOOL userIsInTheMiddleOfEnteringANumber;
@property (nonatomic) BOOL decimalAlreadyPressed;
@property (nonatomic) BOOL resultDisplayed;
@property (nonatomic, strong) CalculatorBrain *brain;

@end

@implementation CalculatorViewController

@synthesize display = _display;
@synthesize historyDisplay = _historyDisplay;
@synthesize userIsInTheMiddleOfEnteringANumber = _userIsInTheMiddleOfEnteringANumber;
@synthesize decimalAlreadyPressed = _decimalAlreadyPressed;
@synthesize resultDisplayed = _resultDisplayed;
@synthesize brain = _brain;

- (CalculatorBrain *) brain
{
    if (!_brain) _brain = [[CalculatorBrain alloc] init];
    return _brain;
}

- (IBAction)digitPressed:(UIButton *)sender 
{
    NSString * digit = sender.currentTitle;
    
    if (self.userIsInTheMiddleOfEnteringANumber) {
        [self.display setText:[self.display.text stringByAppendingString:digit]];
    } else if (![digit isEqualToString:@"0"]) {
        self.display.text = digit;
        self.userIsInTheMiddleOfEnteringANumber = YES;
    }
    
    self.resultDisplayed = NO;
}

- (IBAction)enterPressed 
{
    [self.brain pushOperand:[self.display.text doubleValue]];
    self.userIsInTheMiddleOfEnteringANumber = NO;
    self.decimalAlreadyPressed = NO;
    
    if (self.historyDisplay.text.length == 0) {
        [self.historyDisplay setText:self.display.text];  
    } else {
        NSString* displayText = [@" " stringByAppendingString:self.display.text];
        [self.historyDisplay setText:[self.historyDisplay.text stringByAppendingString:displayText]];
    }
    
}

- (IBAction)operationPressed:(UIButton *)sender 
{
    if (self.userIsInTheMiddleOfEnteringANumber) [self enterPressed];
    double result = [self.brain performOperation:sender.currentTitle];
    NSString *resultString = [NSString stringWithFormat:@"%g", result];
    self.display.text = resultString;
    
    if (self.historyDisplay.text.length == 0) {
        if ([sender.currentTitle isEqualToString:@"π"]) {
             [self.historyDisplay setText:sender.currentTitle]; 
        }
        else {
             [self.historyDisplay setText:[@"0 " stringByAppendingString:sender.currentTitle]];  
        }
    } else {
        NSString* displayText = [@" " stringByAppendingString:sender.currentTitle];
        [self.historyDisplay setText:[self.historyDisplay.text stringByAppendingString:displayText]];
    }
    
    NSRange range = [self.historyDisplay.text rangeOfString:@" "];
    if (range.location == NSNotFound) {
        [self.historyDisplay setText:[self.historyDisplay.text stringByAppendingString:@" ="]];
    } else {
        NSString* thing = @"";
        NSArray* things = [self.historyDisplay.text componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@" ="]];
        NSEnumerator *e = [things objectEnumerator];
        NSString* object;
        while (object = [e nextObject]) {
            if (![thing isEqualToString:@"="]) {
                thing = [[thing stringByAppendingString:object] stringByAppendingString:@" "];
            }
        }
//        thing = [thing substringToIndex:(thing.length-2)];
        [self.historyDisplay setText:[thing stringByAppendingString:@" ="]];
    }
    
    self.decimalAlreadyPressed = NO;
    self.resultDisplayed = YES;
}

- (IBAction)decimalPressed 
{
    if (!self.decimalAlreadyPressed) {
        if ([self.display.text isEqualToString:@"0"] || self.userIsInTheMiddleOfEnteringANumber) {
            [self.display setText:[self.display.text stringByAppendingString:@"."]];
        } else if (!self.userIsInTheMiddleOfEnteringANumber) {
            [self.display setText:@"0."];
        }
    }
    
    self.decimalAlreadyPressed = YES;
    self.userIsInTheMiddleOfEnteringANumber = YES;
}

- (IBAction)signChangePressed:(UIButton *)sender 
{
    if (self.userIsInTheMiddleOfEnteringANumber) {
        NSString* display = self.display.text;
        [self.display setText:[@"-" stringByAppendingString:display]];
    } else {
        [self operationPressed:sender];
    }
}

- (IBAction)clearPressed 
{
    self.userIsInTheMiddleOfEnteringANumber = NO;
    self.decimalAlreadyPressed = NO;
    self.resultDisplayed = NO;
    [self.historyDisplay setText:@""];
    [self.display setText:@"0"];
    [self.brain clearStack];
}

- (IBAction)backspacePressed:(id)sender 
{
    if (self.display.text.length == 1) {
        self.userIsInTheMiddleOfEnteringANumber = NO;
        self.decimalAlreadyPressed = NO;
        [self.display setText:@"0"]; 
    } else if (!self.resultDisplayed) {
        NSInteger indexToRemoveOneNumber = self.display.text.length-1;
        [self.display setText:[self.display.text substringToIndex:indexToRemoveOneNumber]];
    }
}

- (void)viewDidUnload 
{
    [self setHistoryDisplay:nil];
    [super viewDidUnload];
}
@end
