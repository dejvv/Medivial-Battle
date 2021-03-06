//
//  MainMenu.h
//  MedivialBattle
//
//  Created by David Zagorsek on 26/01/2019.
//

#import <Foundation/Foundation.h>

#import "Menu.h"

@interface MainMenu : Menu {
    Image *background;
    
    Label *title;
    
    ButtonHud *play, *opponents, *settings;
}

@end
