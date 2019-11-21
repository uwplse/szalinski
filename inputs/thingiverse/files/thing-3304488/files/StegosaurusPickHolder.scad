// StegosaurusPickHolder.scad - a 3D printable model of a guitar pick holder
// Copyright (C) 2018 Jaromir Hradilek

// This program is free software:  you can redistribute it and/or modify it
// under  the terms of the  GNU General Public License  as published by the
// Free Software Foundation, version 3 of the License.
//
// This program is  distributed  in the hope  that it will  be useful,  but
// WITHOUT ANY WARRANTY;  without  even the implied  warranty of MERCHANTA-
// BILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the  GNU General Public
// License for more details.
//
// You should have received a copy of the  GNU General Public License along
// with this program. If not, see <http://www.gnu.org/licenses/>.

// Change these to customize the model for your guitar picks:
pick_shape = "jazz";          // The guitar pick shape, "jazz" or "tortex"
pick_thickness = 1.38;        // The thickness of your pick
pick_tolerance = 0.12;        // The additional width of the pick slots

// A generic guitar pick in the classic Tortex shape:
module pick_tortex(thickness=1.0) {
    // Define the constant for proper scaling:
    profile_scale = 25.4/90;

    // Define the vectors for the guitar pick shape:
    points = [
      [-0.000012,-54.921270],[-3.719855,-54.840297],
      [-7.423487,-54.598563],[-11.106460,-54.197846],
      [-14.764324,-53.639922],[-18.392633,-52.926570],
      [-21.986937,-52.059565],[-25.542788,-51.040686],
      [-29.055738,-49.871710],[-31.513187,-48.698416],
      [-33.776531,-47.303686],[-35.847474,-45.713569],
      [-37.727717,-43.954115],[-39.418964,-42.051374],
      [-40.922917,-40.031394],[-42.241278,-37.920225],
      [-43.375749,-35.743916],[-44.328034,-33.528518],
      [-45.099834,-31.300079],[-45.692852,-29.084650],
      [-46.108791,-26.908279],[-46.349352,-24.797016],
      [-46.416239,-22.776910],[-46.311154,-20.874012],
      [-46.035799,-19.114370],[-43.430439,-9.781793],
      [-40.302877,-0.651673],[-36.664439,8.252728],
      [-32.526451,16.908153],[-27.900242,25.291339],
      [-22.797136,33.379027],[-17.228462,41.147958],
      [-11.205545,48.574870],[-8.811574,50.799143],
      [-6.145994,52.830208],[-4.711352,53.664580],
      [-3.208807,54.320203],[-1.638361,54.753594],
      [-0.000012,54.921270],[1.638326,54.753938],
      [3.208768,54.320709],[4.711312,53.665107],
      [6.145956,52.830657],[8.811544,50.799312],
      [11.205521,48.574870],[17.228437,41.147958],
      [22.797112,33.379027],[27.900218,25.291339],
      [32.526430,16.908153],[36.664422,8.252728],
      [40.302866,-0.651673],[43.430437,-9.781793],
      [46.035809,-19.114370],[46.311158,-20.874012],
      [46.416239,-22.776910],[46.349349,-24.797016],
      [46.108786,-26.908279],[45.692846,-29.084650],
      [45.099827,-31.300079],[44.328027,-33.528518],
      [43.375742,-35.743916],[42.241270,-37.920225],
      [40.922909,-40.031394],[39.418956,-42.051374],
      [37.727707,-43.954115],[35.847462,-45.713569],
      [33.776516,-47.303686],[31.513167,-48.698416],
      [29.055713,-49.871710],[25.542762,-51.040236],
      [21.986907,-52.058021],[18.392599,-52.923675],
      [14.764286,-53.635805],[11.106419,-54.193021],
      [7.423448,-54.593931],[3.719820,-54.837145],
      [-0.000012,-54.921270],[-0.000012,-54.921270]];

    // Scale the guitar pick to the proper size:
    scale([profile_scale, -profile_scale, 1]) {
        // Create the guitar pick shape from supplied vectors and
        // extrude it to proper thickness:
        union() {
            linear_extrude(height=thickness)
            polygon(points);
        }
    }
}

// A generic guitar pick in the Jazz III shape:
module pick_jazz(thickness=1.38) {
    // Define the constant for proper scaling:
    profile_scale = 25.4/90;

    // Define the vectors for the guitar pick shape:
    points = [
      [-0.000002,-44.291340],[-2.996548,-44.183335],
      [-5.945434,-43.863642],[-8.837953,-43.338740],
      [-11.665400,-42.615113],[-14.419072,-41.699240],
      [-17.090264,-40.597604],[-19.670270,-39.316685],
      [-22.150386,-37.862965],[-24.521908,-36.242925],
      [-26.776131,-34.463046],[-28.904349,-32.529810],
      [-30.897859,-30.449697],[-32.747955,-28.229190],
      [-34.445933,-25.874768],[-35.983089,-23.392915],
      [-37.350716,-20.790110],[-38.153680,-18.815300],
      [-38.559055,-16.740279],[-38.650925,-14.660042],
      [-38.513378,-12.669589],[-37.886370,-9.338022],
      [-37.350716,-7.505560],[-34.692018,-0.178935],
      [-31.529383,6.915656],[-27.878904,13.753414],
      [-23.756674,20.309540],[-19.178786,26.559235],
      [-14.161333,32.477699],[-8.720407,38.040134],
      [-2.872101,43.221740],[-1.407229,44.031152],
      [-0.000002,44.291340],[1.407224,44.031415],
      [2.872062,43.221740],[8.720371,38.040134],
      [14.161301,32.477699],[19.178761,26.559235],
      [23.756656,20.309540],[27.878892,13.753414],
      [31.529377,6.915656],[34.692016,-0.178935],
      [37.350716,-7.505560],[37.886370,-9.338022],
      [38.513378,-12.669589],[38.650925,-14.660042],
      [38.559055,-16.740279],[38.153680,-18.815300],
      [37.350716,-20.790110],[35.983095,-23.392705],
      [34.445944,-25.873983],[32.747969,-28.227550],
      [30.897875,-30.447006],[28.904366,-32.525955],
      [26.776148,-34.457999],[24.521924,-36.236743],
      [22.150401,-37.855788],[19.670283,-39.308737],
      [17.090274,-40.589193],[14.419080,-41.690759],
      [11.665405,-42.607038],[8.837955,-43.331633],
      [5.945434,-43.858146],[2.996547,-44.180181],
      [-0.000002,-44.291340],[-0.000002,-44.291340]];

    // Scale the guitar pick to the proper size:
    scale([profile_scale, -profile_scale, 1]) {
        // Create the guitar pick shape from supplied vectors and
        // extrude it to proper thickness:
        union() {
            linear_extrude(height=thickness)
            polygon(points);
        }
    }
}

// A low poly model of a Stegosaurus without its plates:
module body(scale_factor=1) {
    // Place the imported model in the middle:
    translate([0, 0, 0])

    // Scale the imported model:
    scale([scale_factor, scale_factor, scale_factor])

    // Import the STL model:
    import("Stegosaurus.stl", convexity=5);
}

// Tortex shaped picks placed along the left side of the body:
module plates_tortex(thickness=1.0) {
    translate([-11, 0, 21]) rotate([255, 0, 90]) pick_tortex(thickness);
    translate([-9, -30, 14]) rotate([255, -30, 100]) pick_tortex(thickness);
    translate([-9, 30, 14]) rotate([255, 30, 80]) pick_tortex(thickness);
}

// Jazz III shaped picks placed along the left side of the body:
module plates_jazz(thickness=1.38) {
    translate([-9, 0, 16]) rotate([255, 0, 90]) pick_jazz(thickness);
    translate([-7, -25, 9]) rotate([255, -30, 100]) pick_jazz(thickness);
    translate([-7, 25, 9]) rotate([255, 30, 80]) pick_jazz(thickness);
}

// A guitar pick holder with the Tortex shaped slots:
module stegosaurus_tortex(thickness=1.0) {
    difference() {
        color("SeaGreen") body(16);
        color("CornflowerBlue") plates_tortex(thickness);
        color("CornflowerBlue") mirror([1,0,0]) plates_tortex(thickness);
    }
}

// A guitar pick holder with the Jazz III shaped slots:
module stegosaurus_jazz(thickness=1.38) {
    difference() {
        color("SeaGreen") body(14);
        color("Crimson") plates_jazz(thickness);
        color("Crimson") mirror([1,0,0]) plates_jazz(thickness);
    }
}

// Determine which guitar pick shape to use:
if (pick_shape == "tortex") {
    stegosaurus_tortex(pick_thickness + pick_tolerance);
}
else if (pick_shape == "jazz") {
    stegosaurus_jazz(pick_thickness + pick_tolerance);
}
