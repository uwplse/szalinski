/* [External dimensions] */
// External heigth
ht = 50;

/* [Circles dimensions] */
// In each couple, the first number is the number of divider and the second is the width of the circle
circles = [[2,40], [3,40],[5,40],[7,60],[10,20]];

/* [Thickness] */
// Internal thickness
intTk = 4;
// External thickness
extTk = 10;

$fn=50;

module circle(circles, ht, iTk, eTk, i=0, sumR=0)
{
    union ()
    {
        difference ()
        {
            cylinder(h=ht, r=circles[i][1]+sumR+((i<len(circles))?iTk:eTk));
            
            translate([0,0,eTk])
            cylinder(h=ht-eTk+0.1, r=circles[i][1]+sumR);
            
            cylinder(h=ht, r=sumR-0.01);
        }
        if (circles[i][0]>0)
            for (j=[0:circles[i][0]])
                rotate([0,0,360/circles[i][0]*j])
                translate([sumR-iTk/2,-iTk/2,eTk-0.01])
                cube([circles[i][1]+iTk,iTk,ht-eTk+0.01]);
    }    
    if (i<len(circles)-1)
        circle(circles, ht, iTk, eTk, i+1, sumR+circles[i][1]+iTk);
}

module box(ht, circles, intTk, extTk)
{
//    echo (str("Ht : ", ht));
//    echo (str("Circles : ", circles));
//    echo (str("intTk : ", intTk));
//    echo (str("extTk : ", extTk));
    
    circle(circles, ht, intTk, extTk);
}

box(ht=ht, circles=circles, intTk=intTk, extTk=extTk);