//
//  C4WorkSpace.m
//  test2
//
//  Created by YourMom on 9/19/12.
//  Copyright (c) 2012 YourMom. All rights reserved.
//

#import "C4WorkSpace.h"

bool isFWD;

int speed=1;






@implementation C4WorkSpace {
    
    C4Movie *movie;
    CGRect movieFrame;
    
}



-(void)setup {
    self.canvas.userInteractionEnabled = YES;
    //create a movie and play it automatically
    movie = [C4Movie movieNamed:@"TV-SMASH.m4v"inFrame:movieFrame];
    movie.center = self.canvas.center;
    [self.canvas addMovie:movie];
    movie.shouldAutoplay = NO;
    movie.rate = speed;
    // movie.zPosition=180.0f;
    // movie.loops = true;
    
    
    
    
    [self listenFor:@"touchesBegan"fromObject:(movie) andRunMethod:@"badTOUCH"];
    [movie addGesture:PAN name:@"panGesture" action:@"move:"];
    [self listenFor:@"reachedEnd" andRunMethod:@"theEND"];
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPressGesture:)];
    longPress.minimumPressDuration = 0.1f;
    [self.canvas addGestureRecognizer:longPress];
    
}






-(void)handleLongPressGesture:(id)sender {
    UILongPressGestureRecognizer *lp = (UILongPressGestureRecognizer *)sender;
    CGPoint touchPoint = [lp locationInView:self.canvas];
    int xpos=0;
    int currpos=0;
    
   // NSString *output;//temp for string out
   // output = [NSString stringWithFormat:@"%f",touchPoint.x];
  //  C4Log(output);
    
    xpos=currpos;
    
    currpos = touchPoint.x;
    [movie pause];
    
    [movie seekToTime:(CGFloat)(currpos*.02)];
    
    
    
}

-(void)foo {
    C4Log(@"MOVE!!!!!");
    
}






-(void)touchesBegan {
    
    [movie play];
    
    // movie.center = self.canvas.center;
    isFWD=true;
    
    
}


-(void) badTOUCH{
    [movie play];
    //   [movie seekByAddingTime:1.0f];
    movie.center = self.canvas.center;
    //  movie.frame = CGRectMake(100.0,100.0,500.0,200.0); //this code works...
    
    
}




-(void) theEND{
    
    C4Log(@"END!!!!!");
    
    if (isFWD==false){
        movie.rate=speed;
        isFWD=true;
        
    }
    else if(isFWD==true){
        C4Log(@"THING!!!!!");
        
        movie.rate=-speed;
        isFWD=false;
        
    }
}
@end