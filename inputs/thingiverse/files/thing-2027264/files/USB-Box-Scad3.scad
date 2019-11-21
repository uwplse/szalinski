// 
// (c) g3org 

//Count of SD Slots
    count_SD = 5;
//SD Card thickness
    SD_thickness=2.5;

//Count of SD Slots
    count_USB = 3;
//USB Slot thickness
    USB_thickness =4.8;
//Space between USB Slots
    USB_space = 7;

//Count micro SD 
    count_microSD =5;
//micro SD thickness
    microSD_thickness =1.3;


//Full_Render


/* [Hidden] */
$fn=20;

//inputs end

color("LawnGreen"){  
    SD_Card_render();
        difference() {
            USB_Slot();
            microSD();
        }
}



module microSD(){
    
    
     //micro SD_slot
    for (i = [ 0 : count_microSD-1 ] ) {
    
            translate([19,0,((count_SD*(SD_thickness+2.5))+USB_space)+(i*(microSD_thickness+4))]){
                linear_extrude(height = microSD_thickness, center = false, convexity = 10) {
                square([12,14]);
                }
            }
    }
}
module USB_Slot(){
    
  translate([0,0,count_SD*(SD_thickness+2)]){
   for (i = [ 0-1 : count_USB-2 ] ) {    
       
    translate([0,0,i*(USB_space+USB_thickness) ]){
        echo(i,i*(USB_space+USB_thickness));  
        difference() {
            // Block plus Rundung
            linear_extrude(height = USB_thickness+USB_space, center = false, convexity = 10) {
            translate([19,1,0,])  circle(1);
                translate([1,1,0,])  circle(1);
                polygon([[1,0],[19,0],[32,8],[32,18],[0,18],[0,1]],[[0,1,2,3,4,5]]);
           }
 //USB_slot_Schlitz
            translate([1.5,-3,USB_space]){
                linear_extrude(height = USB_thickness, center = false, convexity = 10) {
                square([13,19]);
                }
            }
  //Bodendurchbruch          
             translate([5,1,USB_space,]){
                linear_extrude(height = USB_thickness, center = false, convexity = 10) {
                square([6,19]);
                }
            } 
        } 
    } 
    i = i+1; 
  } 
  
  //Abschlussplatte_USB_Slots
      translate([0,0,count_USB*(USB_thickness+USB_space)]){
          linear_extrude(height = 2, center = false, convexity = 10) {
                translate([19,1,0,])  circle(1);
                translate([1,1,0,])  circle(1);
                polygon([[1,0],[19,0],[32,8],[32,18],[0,18],[0,1]],[[0,1,2,3,4,5]]);
            }
       } 
    }
}


module SD_Card_render(){
    
  for (i = [ 0 : count_SD-1 ] ) {    
    translate([0,0,i*(SD_thickness+2)-(SD_thickness+2)]){
        difference() {
            // Block plus Rundung
            linear_extrude(height = SD_thickness+2, center = false, convexity = 10) {
                translate([1,0,0,])   square([30,17]);
                translate([0,1,0,])  square([32,17]);
                translate([31,1,0,])  circle(1);
                translate([1,1,0,])  circle(1);
            }
  //SD_slot_Schlitz
            translate([2,-3,2,]){
                linear_extrude(height = SD_thickness, center = false, convexity = 10) {
                square([25,19]);
                }
            }
  //Bodendurchbruch          
            translate([7.7,1,2,]){
                linear_extrude(height = SD_thickness, center = false, convexity = 10) {
                square([14,19]);
                }
            }
        }
    }
    i = i+1;
  }
  //Abschlussplatte_SD_Cars Slots
      translate([0,0,count_SD*(SD_thickness+2)]){
          linear_extrude(height = 2, center = false, convexity = 10) {
                translate([1,0,0,])   square([30,17]);
                translate([0,1,0,])  square([32,17]);
                translate([31,1,0,])  circle(1);
                translate([1,1,0,])  circle(1);
            }
        }
}









