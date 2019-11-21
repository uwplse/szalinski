str="Text";
font = "Consolas";
width=40.6;

letter_size = 50;
letter_height = 5;

module letter(l) {
  translate([0,0,-letter_height / 2])
  {
    linear_extrude(height = letter_height, convexity = 10) {
   
        text(l, size = letter_size, font = font,, $fn = 2, spacing=1);
    }
  }
}


module textOnMagnet(str)
{
    letter(str);
}


module base(str)
{
    minkowski()
    {
        textOnMagnet(str);
        
        intersection()
        {
            sphere(d=letter_size/2,$fn=16);
            scale(500)
            translate([-.5,-.5,0])
            cube(1);
        }
    }
}


scale(.25)
difference()
{
  
    for(i=[0:1:len(str)-1])
    {
        translate([i*width,0,0])
        base(str[i]);
    }
    
    color("red")
    for(i=[0:1:len(str)-1])
    {
        translate([0,0,-letter_height/2+.2+1])
        translate([i*width,0,0])
        scale([1,1,100])
        translate([0,0,letter_height/2])
        textOnMagnet(str[i]);
    }
}
