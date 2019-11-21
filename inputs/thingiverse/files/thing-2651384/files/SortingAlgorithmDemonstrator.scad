//Sorting Algorithm Demostrator
//For Quicksort etc.

stickWidth = 5; 
count = 11;
//changing anything anywhere will trigger a re-randomization
Random = "yes"; // [yes,no]
random = Random == "yes" ? true : false;
echo (random);
MaxLength = 40; // Only for random (above the level)
MinLength = 5; // Only for random (above the level)
// Only for non-random; make sure # of digits matches count*2. For example, "S123034" will generate one stick of length 12, one of 30 and one of 34 (mm, above the level) 'S' is to force customizer to conver the input to string. 
Seed = "S9995908580757065605550"; 
//Seed = str (lengthSeed);
standHeight = 30; 
clearance = 0.5;

if (random) {
    randLength = rands(MinLength+standHeight,MaxLength+standHeight,count);
    for (i = [1:count])
    {
        translate ([(i-1)*stickWidth*1.5,sqrt(3)*0.5*stickWidth-0.001,0])
        union(){
            cube ([stickWidth,randLength[i-1],stickWidth]);
            translate([stickWidth/2,-stickWidth/sqrt(3)/2,0])
            rotate(30)
            cylinder (r = stickWidth/sqrt(3), h = stickWidth ,$fn = 3);
            translate([stickWidth/2,randLength[i-1]+stickWidth/2/sqrt(3),0])
            rotate(-30)
            cylinder (r = stickWidth/sqrt(3), h = stickWidth ,$fn = 3);
        }
    }
}else{
     for (i = [1:count]){
         length = standHeight+ strToNbr(Seed[2*i])+10*strToNbr(Seed[2*i-1]);
         echo (length);
         
         translate ([(i-1)*stickWidth*1.5,sqrt(3)*0.5*stickWidth-0.001,0])
        union(){
            cube ([stickWidth,length,stickWidth]);
            translate([stickWidth/2,-stickWidth/sqrt(3)/2,0])
            rotate(30)
            cylinder (r = stickWidth/sqrt(3), h = stickWidth ,$fn = 3);
            translate([stickWidth/2,length+stickWidth/2/sqrt(3),0])
            rotate(-30)
            cylinder (r = stickWidth/sqrt(3), h = stickWidth ,$fn = 3);
        }
     }
    
}


function strToNbr(str, i=0, nb=0) = i == len(str) ? nb : nb+strToNbr(str, i+1, search(str[i],"0123456789")[0]*pow(10,len(str)-i-1));



translate([-count*(stickWidth+clearance)-clearance-20, 0,0 ])

difference(){
cube ([count*(stickWidth+clearance)+clearance+5,stickWidth+2*clearance+5+30,standHeight+5]);

translate([2.5, -0.01, 5])
cube ([count*(stickWidth+clearance)+clearance,30,standHeight+5]);
translate([2.5, 32.5, 5])
cube ([count*(stickWidth+clearance)+clearance,stickWidth+2*clearance,standHeight+5]);

translate([-.5,0,standHeight+5])
scale([1,1,standHeight/30])
rotate([0,90,0])
cylinder (r = 30, h = count*(stickWidth+clearance)+clearance+6, $fn = 45);
}

//String to number found from this site: https://github.com/openscad/openscad/issues/571 