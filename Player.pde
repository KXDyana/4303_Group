class Player {
    boolean isAtLeftBorder, isAtRightBorder, isAtTopBorder, isAtBottomBorder; // to control movement
    float playerRadius, playerSpeed, detectionRadius1, detectionRadius2, detectionRadius3;
    PVector position, velocity, targetPosition;
    int playerColor;
    float lastParryTimeStamp;
    boolean isParrying;
    
    Player(PVector initialPos, float playerRadius) {
        this.position = initialPos;
        this.targetPosition = this.position;
        this.velocity = new PVector(0, 0);
        this.playerRadius = playerRadius;
        this.playerSpeed = playerRadius * 0.1;
        this.detectionRadius1 = playerRadius * 3;
        this.detectionRadius2 = playerRadius * 4;
        this.detectionRadius3 = playerRadius * 5;
        this.playerColor = LIGHT_PURPLE;
    }
    
    void drawPlayer() {
        updatePlayer();                                               // update player state
        ellipseMode(CENTER);   
        
        // Draw detection circles
        fill(YELLOW, 10);
        noStroke();
        ellipse(position.x, position.y, detectionRadius3, detectionRadius3); 
        
        fill(GREEN, 20);
        ellipse(position.x, position.y, detectionRadius2, detectionRadius2); 
        
        fill(YELLOW, 50);
        ellipse(position.x, position.y, detectionRadius1, detectionRadius1);
        
        
        
        fill(playerColor);
        ellipse(position.x, position.y, playerRadius, playerRadius);  // draw player body
    }
    
    void updatePlayer() {
        if (!isParrying) playerColor = lerpColor(playerColor, LIGHT_PURPLE, 0.1);
        position.x = lerp(position.x, targetPosition.x, 0.01);
        position.y = lerp(position.y, targetPosition.y, 0.01);
        velocity.setMag(0);
        
        if (keys[' ']) {               // parry 
            isParrying = true;
            parry();
            lastParryTimeStamp = millis();
        } else isParrying = false;
        
        integrate();
    }
    
    void integrate() {
        // if velocity = 0, no need to integrate
        if (velocity.mag() == 0) return;
        // otherwise, update the position
        position.add(velocity);
    }
    
    void parry() {
        playerColor = RED; // immediately change color to red
    }

}
