// South African luggage tags
// Hussein Suleman
// 9 March 2018

// Full name
name = "Firstname Lastname";

// Telephone number
phone = "+555-my-phone";

// Email address
email = "my.email@xyz.com";

module roundbox (w, h, d, rimw, rimr, base)
{
    difference () {
       union () {
          translate ([0,rimr,0]) cube ([w,h-(2*rimr),d]);
          translate ([rimr,0,0]) cube ([w-(2*rimr),h,d]);
          translate ([rimr,rimr,0]) cylinder (r=rimr,h=d,$fn=100);
          translate ([rimr,h-rimr,0]) cylinder (r=rimr,h=d,$fn=100);
          translate ([w-rimr,rimr,0]) cylinder (r=rimr,h=d,$fn=100);
          translate ([w-rimr,h-rimr,0]) cylinder (r=rimr,h=d,$fn=100);
       }
          translate ([rimw,rimr,base]) cube ([w-(2*rimw),h-(2*rimr),d-base+1]);
          translate ([rimr,rimw,base]) cube ([w-(2*rimr),h-(2*rimw),d-base+1]);
          translate ([rimr,rimr,base]) cylinder (r=rimr-rimw,h=d-base+1,$fn=100);
          translate ([rimr,h-rimr,base]) cylinder (r=rimr-rimw,h=d-base+1,$fn=100);
          translate ([w-rimr,rimr,base]) cylinder (r=rimr-rimw,h=d-base+1,$fn=100);
          translate ([w-rimr,h-rimr,base]) cylinder (r=rimr-rimw,h=d-base+1,$fn=100);
       
    }
}

translate ([-45, -30, 0]) 
difference () {
   union () {
      difference () {
         roundbox (90, 60, 3, 2, 5, 2);
         union () {
            translate ([0,20,-2.5]) cube ([60, 20, 3]);
            translate ([92.5,11.5,-2.5]) rotate ([0,0,135]) cube ([44, 20, 3]);
            translate ([61.5,17.5,-2.5]) rotate ([0,0,45]) cube ([44, 20, 3]);
         }
      }
      translate ([0,24,0]) cube ([60, 12, 0.5]);
      translate ([90,9,0]) rotate ([0,0,135]) cube ([38, 12, 0.5]);
      translate ([63,24.5,0]) rotate ([0,0,45]) cube ([38, 12, 0.5]);
      translate ([10,30,0]) cylinder (d=11, h=3, $fn=30);
   }
   translate ([10,30,-1]) cylinder (d=8, h=5, $fn=30);   
}


translate ([-22,2,1]) cube ([54,2,2]);

translate ([0,16,1]) scale ([0.78,1,1]) linear_extrude (2) text(name,size=8,font="trebuchet:style=bold italic",direction="ltr",valign="center",halign="center",spacing=1);
translate ([0,-10,1]) 
 linear_extrude (2) {
    translate ([0,0,0]) text(phone,size=7,font="trebuchet:style=bold",direction="ltr",valign="center",halign="center");
    translate ([0,-10,0]) text(email,size=5,font="trebuchet:style=bold",direction="ltr",valign="center",halign="center");
 }

