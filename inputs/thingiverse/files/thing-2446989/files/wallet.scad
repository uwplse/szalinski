$fn = 100;
walletLength = 98;
walletHeight = 89;
moneySlotWidth = 1;
cardSlotWidth = 1;
cardSlotLength = 93;
cardSlotHeight =  44;
heightDecreasePerSlot = 10;

wallSize = 0.5;
cornerRadius = 3;
bottomHeight = 1;

cardslotsPerSide =4;

walletWidth = 2 * (wallSize * 2 + moneySlotWidth + (wallSize + cardSlotWidth) * cardslotsPerSide) + wallSize * 3+ 1; 


module roundedSquare(x,y,r)
{
    difference()
    {
        square([x,y]);
        union()
        {
            for(i=[0:3])
            {
                translate([(x -r + 0.1) * floor(i /2),  (y - r + 0.1) * floor(i %2)])
                translate([(r/2 -0.1/2),(r/2 -0.1/2)])
                mirror([1 * floor(i/2),0])
                rotate(-90 * floor(i%2))
                translate([-(r/2 -0.1/2),-(r/2 -0.1/2)])
                difference()
                {
                    translate([-0.1,-0.1])
                        square([r + 0.1,r + 0.1]);
                    translate([r,r])
                    circle(r);
                }
            }
            


        }
    }

}
module moneyslot()
{
    linear_extrude(height = walletHeight +bottomHeight)
    {
        difference()
        {
            difference()
            {
                union()
                {
                    //moneyslot outside
                    difference()
                    {

                        roundedSquare(walletWidth,walletLength,cornerRadius);
                        translate([wallSize,wallSize,0])
                            roundedSquare(walletWidth - wallSize * 2,walletLength - wallSize * 2,cornerRadius);

                    }
                    
                    //moneyslot outside
                    difference()
                    {
                        translate([(wallSize + moneySlotWidth),-20,0])
                            roundedSquare(walletWidth - (wallSize + moneySlotWidth) * 2,
                                          walletLength - (moneySlotWidth + wallSize) +20 ,
                                            cornerRadius);
                        translate([-0.5 *walletWidth,  -walletLength])
                        square([walletWidth * 2,walletLength]);
                    
                    }
                }
                translate([(wallSize  + moneySlotWidth + wallSize), -20,0])
                    roundedSquare(walletWidth - (wallSize + moneySlotWidth + wallSize) * 2,
                        walletLength - (wallSize + moneySlotWidth + wallSize) +20 ,
                        cornerRadius);    
            }
            difference()
            {
                translate([-walletWidth/2, -walletLength/2])
                roundedSquare(walletWidth*2,walletLength*2,cornerRadius);
                roundedSquare(walletWidth,walletLength,cornerRadius);
            }

        }
    }

    //moneyslot bottom
    linear_extrude(height = bottomHeight)
    {
        difference()
        {
            roundedSquare(walletWidth,walletLength,cornerRadius);
            translate([(wallSize  + moneySlotWidth + wallSize), -20,0])
                    roundedSquare(walletWidth - (wallSize + moneySlotWidth + wallSize) * 2,
                        walletLength - (wallSize + moneySlotWidth + wallSize) +20 ,
                        cornerRadius);
            translate([-0.5 *walletWidth,  walletLength - wallSize- moneySlotWidth])
                square([walletWidth * 2,walletLength]);
        }
    }
}

module cardslot()
{
    //hole part
    for(i = [0 : cardslotsPerSide - 1])
    {
        linear_extrude(height = walletHeight -heightDecreasePerSlot - (i * heightDecreasePerSlot))
        difference()
        {  
            translate([-20,0,0])
            roundedSquare(cardSlotWidth + wallSize * 2 + 20 + (cardSlotWidth + wallSize) * i ,
                cardSlotLength + wallSize * 2 ,
                cornerRadius);
            
            translate([-20 + (cardSlotWidth + wallSize) * i,wallSize,0])
            roundedSquare(cardSlotWidth + wallSize +20  ,
            cardSlotLength,
            cornerRadius);
            
            translate([-20-0.1,-0.1])
            square([20 ,cardSlotLength + wallSize * 2 + 0.2]);
        }
        
    }
    
    //solid part
    for(i = [0 : cardslotsPerSide -1])
    {
        linear_extrude(height = walletHeight -heightDecreasePerSlot - cardSlotHeight - (i * heightDecreasePerSlot))
        difference()
        {  
            translate([-20,0,0])
            roundedSquare(cardSlotWidth + wallSize * 2 + 20 + (cardSlotWidth + wallSize) * i ,
                cardSlotLength + wallSize * 2 ,
                cornerRadius);
            

            
            translate([-20-0.1,-0.1])
            square([20 ,cardSlotLength + wallSize * 2 + 0.2]);
        }
        
    }
}

union()
{
    moneyslot();
    translate([wallSize * 2 + moneySlotWidth,0])
        cardslot();
    translate([ walletWidth- (wallSize * 2 + moneySlotWidth),0])
        mirror([1,0,0])
            cardslot();
}