//How tall do you want your vase?
height = 250;
//How many steps do you want the vase to go up in?
layers = 10;
//How wide in MM is the vase
width = 400;
//wall width Increase this number to make the pot waterproof, decrease it to make more room for plants
thickness = 60;
//Want some spin?
spin = 2;
//Number 1-100, size of the base in percent
base = 60;
//pick random numbers for this until it looks good
magicsause = 50;

growth = height/layers;

difference(){
union(){
difference(){
    //controlls the number of layers
    for (stackcount = [0:growth:height])
    {
        tempwidth = (stackcount/ (stackcount + magicsause))*width;
        //bevels the edge of each layer
        intersection(){
            //makes squares for each layer
            union(){
                     for (x = [0:15:75]){
                        translate([0,0,stackcount]) rotate([0,0,x+((stackcount/growth)*spin)]) cube([tempwidth,tempwidth,growth*2], center = true);
                                        }
                   }
                    //makes the cone to shape the bevel
                    translate([0,0,stackcount*.9]) cylinder(growth*2, tempwidth*.5, tempwidth, center=true,  $fn=24);
                }
    }
       
            translate([0,0,0])
           
            //hollows out the vessel
           for (stackcountY = [0:growth:height ])
        {
           
            topr = (stackcountY/ (stackcountY + magicsause))*width;
            botr = ((stackcountY -growth)/ ((stackcountY-growth) + magicsause))*width;
        translate([0,0,stackcountY]) cylinder(growth, (botr-thickness)*.75, (topr - thickness)*.75 , center = false, $fn = 24);
        }
} 
//makes the base
for (x = [0:15:75]){
                       translate([0,0,.5*growth]) rotate([0,0,x]) cube([width*(base/100),width*(base/100),growth], center = true);
                    }


                }
                //cleanup the bottom. dont know why i need this
                translate ([0,0,-3]) cylinder(3,width, width);
            }