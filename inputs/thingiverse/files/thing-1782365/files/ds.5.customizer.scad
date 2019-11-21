//Chromableedstudios - ds case

// Number of ds/3ds carts
number_of_carts = 3; // [1,3,9]

if(number_of_carts == 1)
{
    dsCartHolder();
}
else if (number_of_carts == 3)
{
    threeCarts();
}
else if (number_of_carts == 9)
{
    nineCarts();
}

module nineCarts()
{
    threeCarts();
    translate([0,blockY-.2,0])
    threeCarts();
    translate([0,(blockY*2)-.2,0])
    threeCarts();
}

module threeCarts()
{
    dsCartHolder();
    translate([blockX-.2,0,0])
    dsCartHolder();
    translate([(blockX*2)-.2,0,0])
    dsCartHolder();
}

module dsCartHolder()
{
    union()
    {
        difference()
        {        
            block();
                     
            union()
            {
                cart();
                clip();
            }
        }
        cartHolders();
        translate([0,0,-1.3])
        cartRetainer();
        cartRetainer();
    }
}

module cartRetainer() 
{
    translate([-10,-8,-1.7])
    rotate([0,0,90])
    cube([1.7,8,1.6]);
}

clipUpper = 20;
clipXoff = -22;
clipYoff = 10;
module clip()
{
    translate([-12,-8,-1])
    cube([8,8,6], center = true);
    
    rotate([5,0,0])
    translate([clipXoff+2,clipYoff-2.4,-3])
    cube([4,clipUpper+4,5], center = true);
    
    translate([clipXoff,clipYoff,0])
    cube([2,clipUpper,blockZ*2], center = true);
    translate([clipXoff+4,clipYoff,0])
    cube([2,clipUpper,blockZ*2], center = true);
    
    translate([clipXoff-1.9,clipYoff-clipUpper+1,0])
    cube([2,clipUpper,blockZ*2], center = true);
    translate([clipXoff+4+1.9,clipYoff-clipUpper+1,0])
    cube([2,clipUpper,blockZ*2], center = true);
    
    
    translate([clipXoff+4+1.9-4,clipYoff-clipUpper-8,0])
    rotate([0,0,90])
    cube([2,9,blockZ*2], center = true);
}

cartX = 34+.5;
cartY = 35+.5;
cartZ = 4.5;
cartXOffset = 5;
cartYOffset = -5;
cartTopX = 42;
cartTopY = 8;
module cart()
{
    translate([cartXOffset,cartYOffset,0])
   
    union()
    {
        cube([cartX,cartY,cartZ], center=true);
        translate([0,0,cartZ/2])
        cube([cartX,cartY,cartZ], center=true);
        hull()
        {
            cartTopPart(0);
            translate([0,7,1])
            cartTopPart(16);
            translate([0,10,2])
            cartTopPart(16);
        }
    }
    
        
}
module cartTopPart(rotateX)
{
    color("red")
    translate([0,(cartY/2)-cartTopY/2,0])
    rotate([rotateX,0,0])
    cube([cartTopX,cartTopY,cartZ], center=true);
    color("red")
    translate([0,(cartY/2)-cartTopY/2,cartZ/2])
    rotate([rotateX,0,0])
    cube([cartTopX,cartTopY,cartZ], center=true);
}
cartHolderX = 6;
cartHolderY = 14;
cartHolderZ = 1;
module cartHolders()
{
    translate([cartX/2,cartYOffset,(blockZ/2)-cartHolderZ/2])
    cartHolder();
    translate([-(cartX/2),cartYOffset,(blockZ/2)-cartHolderZ/2])
    cartHolder();
    
}
module cartHolder()
{
    color("blue")
    translate([cartXOffset,-((cartY/2)-cartHolderY/2),0])
    cube([cartHolderX,cartHolderY,cartHolderZ], center=true);
}

blockX = 55;
blockY = 50;
blockZ = 6;
module block()
{
    cube([blockX,blockY,blockZ], center=true);
    
}