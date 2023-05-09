class MenuOption {
    
    //Constants for menu appearance
    int menuOptionX, menuOptionY, optionWidth, optionHeight;
    float optionTextSize, selectedOptionTextSize, notSelectedOptionTextSize;
    String optionText;
    boolean selected, anyChildSelected, ommited;
    MenuOption parentOption;
    float optionColorOpa;
    int optionColor = LIGHT_PURPLE;
    Menu menu;
    
    MenuOption(String optionText, int menuOptionX, int menuOptionY, int optionWidth, int optionHeight, Menu menu) {
        this.menuOptionX = menuOptionX;
        this.menuOptionY = menuOptionY;
        this.optionWidth = optionWidth;
        this.optionHeight = optionHeight;
        this.optionTextSize = optionHeight * 1 / 2;
        this.notSelectedOptionTextSize = optionTextSize;
        this.selectedOptionTextSize = optionTextSize * 1.1;
        this.optionText = optionText;
        this.menu = menu;
    }
    
    void drawMenuOption() {
        updateOption();
        noStroke();
        
        rectMode(CENTER);
        if (selected) {
            optionColorOpa = lerp(optionColorOpa, 120, 0.1);
            optionTextSize = lerp(optionTextSize, selectedOptionTextSize, 0.1);
            fill(optionColor, optionColorOpa);
            rect(menuOptionX, menuOptionY, optionWidth, optionHeight);
            textAlign(LEFT, CENTER); 
            textSize(optionTextSize);
            fill(YELLOW);
            text(optionText, menuOptionX - optionWidth / 2.2, menuOptionY);
            
        } else{
            optionColorOpa = lerp(optionColorOpa, 0.0, 0.1);
            optionTextSize = lerp(optionTextSize, notSelectedOptionTextSize, 0.1);
            fill(optionColor, optionColorOpa);
            rect(menuOptionX, menuOptionY, optionWidth, optionHeight);
            textAlign(LEFT, CENTER); 
            textSize(optionTextSize);
            fill(YELLOW);
            text(optionText, menuOptionX - optionWidth / 2.2, menuOptionY);
        }
    }
    
    void updateOption() {
        // Check if mouse is within bounds of the rectangle
        if (Collision.pointCollideRect(new PVector(mouseX, mouseY), menuOptionX, menuOptionY, optionWidth, optionHeight)) {
            selected = true;
            
            if (mousePressed && mouseButton == LEFT && !prevMousePressed) {
                switch(optionText) {
                    case "Settings":
                        prevMousePressed = true;
                        
                        menu.menuState = Menu.STATE_SETTING;
                        break;
                    case "Back":
                        menu.menuState = Menu.STATE_ROOT; 
                        player.targetPosition = menu.menuPlayerPosition;
                        prevMousePressed = true;
                        
                        break;
                    case "Quit Game":
                        exit(); break;
                    case "Load Game":
                        menu.menuState = Menu.STATE_LOAD;
                        prevMousePressed = true;
                        
                        break;
                    case "Start Game":
                        Game.state = STATE_LEVEL;
                        player.targetPosition = levelSelect.levelSelectPlayerPosition;
                        prevMousePressed = true;
                        
                        break; 
                    case "Unlock Content":
                        unLockAllLevels = true;
                        prevMousePressed = true;
                        
                        break;
                    case "Show Game Info":
                        showInfo = !showInfo;
                        prevMousePressed = true;
                        
                        break;
                }
            }
        }
        else {
            selected = false;
        }
    }
}
