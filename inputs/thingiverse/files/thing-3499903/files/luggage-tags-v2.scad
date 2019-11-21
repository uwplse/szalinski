// Generic luggage tags
// Hussein Suleman
// 1 April 2019

// Full name
line1 = "Firstname Lastname";

// Telephone number
line2 = "+555-my-phone";

// Email address
line3 = "my.email@xyz.com";

// Image for back of tag (black and white PNG image - white parts will be recessed)
imagefile = "ca2.png"; // [image_surface:90x60]

// default image
if (imagefile == "") {   
   imagefile = "za.png";
}

// create rounded box with recessed inner surface
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

// make box
translate ([-45, -30, 0]) 
   union () {
      difference () {
         union () {
            roundbox (90, 60, 3, 2, 5, 2);
            translate ([10,30,0]) cylinder (d=11, h=3, $fn=30);
         }
         translate ([52,30,0.49]) resize ([70/90*90,70/90*60,1]) cube ([90,60,0.5], center=true);
         translate ([10,30,-1]) cylinder (d=8, h=5, $fn=30);   
      }
   }

// place and sink image onto reverse side
translate ([-45, -30, 0]) 
   translate ([52,30,0.5])
      rotate ([0,180,0])
         resize ([70/90*90,70/90*60,0.5])
            surface(file = imagefile, center = true, invert=false);

// add line after first line of text
translate ([-22,2,1]) cube ([54,2,2]);

// bounded box resizing for text
function bb ( str ) = (len(line1)<15) ? [0,8,0] : [75,0,0];

// add text elements
translate ([0,16,1]) resize (bb(line1)) linear_extrude (2) 
   text(line1,size=8,font="trebuchet:style=bold italic",direction="ltr",valign="center",halign="center",spacing=1);
translate ([0,-10,1]) 
 linear_extrude (2) {
    translate ([0,-2,0]) resize (bb(line2)) text(line2,size=7,font="trebuchet:style=bold",direction="ltr",valign="center",halign="center");
    translate ([0,-12,0]) resize (bb(line3)) text(line3,size=5,font="trebuchet:style=bold",direction="ltr",valign="center",halign="center");
 }

