// By Erik Andersson
// Please help with this method to bring support for more UILineBreakModes and text alignment

#import "UILabel+fix.h"
#import <CoreText/CoreText.h>

@implementation UILabel (fix)

- (CGRect)rectForLetterAtIndex:(NSUInteger)index
{
    NSAssert(self.lineBreakMode != UILineBreakModeClip, @"UILabel.lineBreakMode cannot be UILineBreakModeClip to calculate the rect of a character. You might think that it's possible, seeing as UILineBreakModeWordWrap is supported, and they are almost the same. But the semantics are weird. Sorry.");
    NSAssert(self.lineBreakMode != UILineBreakModeHeadTruncation, @"UILabel.lineBreakMode cannot be UILineBreakModeHeadTruncation to calculate the rect of a character. We can't have everything you know.");
    NSAssert(self.lineBreakMode != UILineBreakModeMiddleTruncation, @"UILabel.lineBreakMode cannot be UILineBreakModeMiddleTruncation to calculate the rect of a character. We can't have everything you know.");
  //  NSAssert(self.lineBreakMode != UILineBreakModeTailTruncation, @"UILabel.lineBreakMode cannot be UILineBreakModeTailTruncation to calculate the rect of a character. We can't have everything you know.");
    
    // Check if label is empty. Should add so it also checks for strings containing only spaces
    if ( [self.text length] == 0 )
    {
        return self.bounds;
    }
    
    // Algorithm goes like this:
    //    1. Determine which line the letter is on
    //    2. Get the x-position on the line by: width of string up to letter
    //    3. Apply UITextAlignment to the x-position
    //    4. Add y position based on height of letters * line number
    //    Et víolà!
    
    NSString *letter = [self.text substringWithRange:NSMakeRange(index, 1)];
    
    // Determine which line the letter is on and the string on that line
    CGSize letterSize = [letter sizeWithFont:self.font];
    
    int lineNo = 0;
    int linesDisplayed = 1;
    
    // Get the substring with the line on it
    NSUInteger lineStartsOn = 0;
    NSUInteger currentLineLength = 1;
    
    // Temporary variables
    NSUInteger currentLineStartsOn = 0;
    NSUInteger currentCurrentLineLength = 1;
    
    float currentWidth;
    
    // TODO: Add support for UILineBreakModeWordWrap, UILineBreakModeCharacterWrap to complete implementation
    
    // Get the line number of the current letter
    // Get the contents of that line
    // Get the total number of lines (which means that no matter what we loop through the entire thing)
    
    BOOL isDoneWithLine = NO;
    
    NSUInteger i = 0, len = [self.text length];
    
    // The loop is different depending on the lineBreakMode. If it is UILineBreakModeCharacterWrap it is easy
    // just check for every single character. For UILineBreakModeWordWrap it is a bit more tedious. We have
    // to think in terms of words. We have to find each word and check it. If it is longer than the frame width
    // then we know we have a new word, and that lines index starts on the words beginning index.
    // Spaces prove to be even morse troublesome. Several spaces in a row at the end of a line won't result in
    // any more width.
    for ( ; i < len; i++ )
    {
        NSString *currentLine = [self.text substringWithRange:NSMakeRange(currentLineStartsOn, currentCurrentLineLength)];
        
        CGSize currentSize = [currentLine sizeWithFont:self.font constrainedToSize:CGSizeMake(self.frame.size.width, 1000) lineBreakMode:self.lineBreakMode];
        currentWidth = currentSize.width;
        
        if ( currentSize.height > self.font.lineHeight )
        {
            // We have to go to a new line
            linesDisplayed++;
            
            //NSLog(@"new line on: %d", i);
            
            // If i <= index that means we are on the correct letter's line
            // store that
            if ( i <= index )
            {
                lineStartsOn = i;
                lineNo++;
                currentLineLength = 1;
            }
            else
                isDoneWithLine = YES;
            
            currentLineStartsOn = i;
            currentCurrentLineLength = 1;
            i--;
        }
        else
        {
            // Okay with the same line
            
            currentCurrentLineLength++;
            
            if ( ! isDoneWithLine )
            {
                currentLineLength++;
            }
        }
    }
    
    // Make sure we didn't overstep the bounds
    while ( lineStartsOn + currentLineLength > len )
        currentLineLength--;
    
    // Check if linesDisplayed is faulty, if for example lines have been clipped
    CGSize totalSize = [self.text sizeWithFont:self.font constrainedToSize:CGSizeMake(self.frame.size.width, 100000) lineBreakMode:self.lineBreakMode];
    
    if ( totalSize.height > self.frame.size.height )
    {
        // It has been clipped, calculate how many lines are actually shown
        
        linesDisplayed = 0;
        float ddLineHeight = 0;
        while ( ddLineHeight < self.frame.size.height )
        {
            ddLineHeight += self.font.lineHeight;
            linesDisplayed++;
        }
        
        linesDisplayed--;
        
        // Number of lines is not automatic, keep it within that range
        if ( self.numberOfLines > 0 )
            linesDisplayed = linesDisplayed > self.numberOfLines ? self.numberOfLines : linesDisplayed;
    }
    
    // Length of the substring up and including this letter
    NSUInteger currentLineSubstrLength = index - lineStartsOn + 1;
    
    currentWidth = [[self.text substringWithRange:NSMakeRange(lineStartsOn, currentLineLength)] sizeWithFont:self.font].width;
    
    NSString *lineSubstr = [self.text substringWithRange:NSMakeRange(lineStartsOn, currentLineSubstrLength)];
    
    float x = [lineSubstr sizeWithFont:self.font].width - [letter sizeWithFont:self.font].width;
    float y = self.frame.size.height/2 - (linesDisplayed*self.font.lineHeight)/2 + self.font.lineHeight*lineNo;
    
    if ( self.textAlignment == UITextAlignmentCenter )
    {
        x = x + (self.frame.size.width-currentWidth)/2;
    }
    else if ( self.textAlignment == UITextAlignmentRight )
    {
        x = self.frame.size.width-(currentWidth-x);
    }
    
    return CGRectMake(x, y, letterSize.width, letterSize.height);
}

@end
