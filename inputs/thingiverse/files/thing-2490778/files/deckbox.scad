
//For a normal deck with sideboard and some tokens: [60, 15, 5]. Or a commander deck: [1, 99]
compartiments = [60, 15];
//Thickness of the walls
wall = 4; // [3, 4, 5, 6, 7, 8]
//Wether you want a window or not (0 for no, 1 for yes)
window = 1; // [0, 1] 
//The text above the line
text1 = "DECKBOX";
//The size of this text
size1 = 9.7;
//The text below the line
text2 = "DENDROWEN";
//The size of this text
size2 = 7;
//Check if you double sleeve the cards
doubleSleeved = true;

//Card width. (standard ultra-pro MTG sleeve)
cardW = 67.5;
//Card height. (standard ultra-pro MTG sleeve)
cardH = 93.4;
//Card thickness. (standard dragon shield MTG sleeve with card)
cardT = doubleSleeved ? 0.71 : 0.61;

//MTG icons. plain = 1, island = 2, swamp = 4, mountain = 8, forest = 16 (add them together for multiple icons.)
colors = 31;

flexibleClips = true;

deckbox(compartiments, wall, window == 1, true, text1, size1, text2, size2, colors);


module deckbox(
  compartiments = [60],
  wall = 4,
  window = true,
  lid = true,
  text1 = "",
  size1 = 7,
  text2 = "",
  size2 = 5,
  colors = 0){


  // HANDS OFF!!!
  tolerance = 1;
  nComps = len(compartiments);
  $fn = 72;
  sizes = compartiments * cardT;
  totalDepth = sum(sizes) + wall * nComps + wall + tolerance * nComps;
  innerDepth = totalDepth - wall * 2;

  echo("=============================");
  echo(str("                TOTAL DEPTH: ", totalDepth, "mm          "));
  echo("=============================");


  difference(){
    union(){
      translate([wall, wall, 0])
      minkowski(){
        cube([cardW, innerDepth, cardH + wall - 1]);
        cylinder(r = wall, h = 1);
      }

      if(lid){
        difference(){
          translate([wall, wall, wall + cardH])
          minkowski(){
            cube([cardW, innerDepth, wall - 1]);
            cylinder(r = wall, h = 1);
          }

          difference(){
            translate([wall, -1, wall + cardH])
            cube([cardW, totalDepth + 2, wall * 1 + 1]);

            translate([wall * 0.83, wall / 2, cardH + wall * 1.5])
            sphere(r = wall / 3);

            translate([cardW + wall * 1.17, wall / 2, cardH + wall * 1.5])
            sphere(r = wall / 3);

          }

          translate([wall / 2, wall, wall + cardH])
          rotate([0, 27, 0])
          cube([wall, totalDepth + 2, wall * 2]);


          translate([cardW + wall * 1.5, totalDepth + wall, wall + cardH])
          rotate([0, 27, 180])
          cube([wall, totalDepth, wall * 2]);
        }
      }
    }
    translate([cardW / 2 + wall, -1, cardH + wall])
    rotate([-90, 0, 0])
    cylinder(h = totalDepth + 2, d = 20);

    for(i = [0 : (nComps - 1)]){
      translate([wall, sum(sizes, 0, i) + (i * wall) + wall + i * tolerance, wall])
      cube([cardW, sizes[i] + tolerance, cardH + 1]);
    }

    if(window){
      translate([(cardW + wall * 2 - 54) / 2, -1, cardH - 51 + wall * 1.5])
      cube([54, wall + 2, 53]);
        
      translate([(cardW + wall * 2 - 54) / 2, -1, cardH - 51 + wall * 1.5])
      rotate([-22.5, 0, 0])
      cube([54, wall + 2, wall]);
    }
    
    if(colors > 0){
        b = bin(colors, 5);
        n = binHigh(b);
        pos = [0, cardW / 5, cardW / 5 * 2, cardW / 5 * 3, cardW / 5 * 4];
        if(binMatch(b, bin(1, 5))){
            translate([cardW / 5 * (((5 - n) / 2) + n - binHigh(b, 4)) + 2, 1, 11])
            rotate([90, 0, 0]){
                linear_extrude(height = 2)
                scale(0.8)
                import("plain.dxf");
            }
        }
        if(binMatch(b, bin(2, 5))){
            translate([cardW / 5 * (((5 - n) / 2) + n - binHigh(b, 3)) + 3, 1, 13])
            rotate([90, 0, 0]){
                linear_extrude(height = 2)
                scale(0.8)
                import("island.dxf");
            }
        }
        if(binMatch(b, bin(4, 5))){
            translate([cardW / 5 * (((5 - n) / 2) + n - binHigh(b, 2)) + 3, 1, 13])
            rotate([90, 0, 0]){
                linear_extrude(height = 2)
                scale(0.8)
                import("swamp.dxf");
            }
        }
        if(binMatch(b, bin(8, 5))){
            translate([cardW / 5 * (((5 - n) / 2) + n - binHigh(b, 1)) + 3, 1, 12])
            rotate([90, 0, 0]){
                linear_extrude(height = 2)
                scale(0.8)
                import("mountain.dxf");
            }
        }
        if(binMatch(b, bin(16, 5))){
            translate([cardW / 5 * (((5 - n) / 2) + n - binHigh(b, 0)) + 2, 1, 12])
            rotate([90, 0, 0]){
                linear_extrude(height = 2)
                scale(0.8)
                import("forest.dxf");
            }
        }
        
    }
    
    translate([70, 20])
    mirror()
    logo(16);

  }

  if(lid){
    margin = 0.2;
    translate([cardW + wall * 2 + 5, 0, 0])
    // translate([wall / 2 + 0.25, 0, cardH + wall]) //  <-- Lid in place. Don't print this way
    difference(){


      translate([wall / 2, wall, 0])
      minkowski(){
        cube([cardW - margin, innerDepth, wall - 1 - margin]);
        cylinder(r = wall, h = 1);
      }

      cube([wall / 2, wall, wall]);

      translate([wall * 0.5, wall / 2, wall / 2])
      sphere(r = wall / 3);

      translate([-wall - 0.4, 0, 0])
      rotate([0, 27, 0])
      cube([wall, totalDepth, wall * 2]);

      translate([cardW + wall / 2 - margin, 0, 0])
      cube([wall / 2, wall, wall]);

      translate([cardW + wall * 0.5 - margin, wall / 2, wall / 2])
      sphere(r = wall / 3);

      translate([cardW + wall * 2 + 0.4 - margin, totalDepth, 0])
      rotate([0, 27, 180])
      cube([wall, totalDepth, wall * 2]);

      translate([(cardW + wall - margin) / 2, (totalDepth) / 2, wall - 1])
      linear_extrude(height = 1.3){
        text(text1, halign = "center", valign = "center", size = size1, font="Arial:style=Bold");
      }

      translate([wall - margin / 2, (totalDepth) / 2 - size1 / 2 - 2, wall - 1])
      cube([cardW - wall, 1, 1.3]);

      translate([(cardW + wall - margin) / 2, (totalDepth) / 2 - size1 - size2 / 2, wall - 1])
      linear_extrude(height = 1.3){
        text(text2, halign = "center", valign = "center", size = size2, font="Arial:style=Bold");
      }
        
      if(flexibleClips){
          translate([wall, 0, 0])
          cube([1, 8, wall + 1]);
          
          translate([cardW - margin - 1, 0, 0])
          cube([1, 8, wall + 1]);
      }
    
    }
  }
}

module logo(size = 22, height = 1){
    scl = size / 22;
    linear_extrude(height = height){
        union(){
            text("3", scl * 14);

            translate([scl * 10, 0, 0])
            text("D", size);

            translate([scl * 31, scl * 12, 0])
            text("endrowen", scl * 10);

            translate([scl * 31, 0, 0])
            text("printing", scl * 10);
        }
    }
}
function sum(array, from = 0, to = 2000000000) = (from < to  && from < len(array) ? array[from] + sum(array, from + 1, to) : 0);

function bin(num, len=-1, v=[]) =
	len(v) == len || (num == 0 && len == -1) ? v :
	num == 0 && len != -1 ? bin(0, len, concat(0, v)) :
	bin(floor(num/2), len, concat(num%2, v));


function binMatch(bin1, bin2, s = 0) = bin1[s] == 1 && bin2[s] == 1 ? true : min(len(bin1), len(bin2)) - 1 == s ? false : binMatch(bin1, bin2, s + 1);

function binHigh(bin, s = 0) = (bin[s] == 1 ? 1 : 0) + (s + 1 == len(bin) ? 0 : binHigh(bin, s + 1));
