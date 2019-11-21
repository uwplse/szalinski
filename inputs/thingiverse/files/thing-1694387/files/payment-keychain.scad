// Parametric keychain with recessed pocket accomodating RFID stickers
// distributed by some banks
// Copyright (C) 2016 Miroslav Hradílek

// This program is  free software:  you can redistribute it and/or modify it
// under  the terms  of the  GNU General Public License  as published by the
// Free Software Foundation, version 3 of the License.
//
// This program  is  distributed  in the hope  that it will  be useful,  but
// WITHOUT  ANY WARRANTY;  without  even the implied  warranty of MERCHANTA-
// BILITY  or  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public
// License for more details.
//
// You should have received a copy of the  GNU General Public License  along
// with this program. If not, see <http://www.gnu.org/licenses/>.

k_thick = 2; // Thickness of the keychain
p_depth = 1; // Depth of the pocket
k_radius = 4; // Radius of the keychain corners
p_radius = 2; // Radius of the pocket corners

h_radius = 2.5; // Radius of the hole
k_width = 33; // Keychain width
k_height = 50.5; // Keychain height
p_width = 31; // Pocket width
p_height = 41; // Pocket height

module 2d_pocket(){
    offset(r = p_radius) {
        square([p_width-2*p_radius,p_height-2*p_radius],center = true);
    }
}

module 2d_outer(){
    offset(r = k_radius) {
        square([k_width-2*k_radius,k_height-2*k_radius],center = true);
    }
}

module 2d_body(){
    hole_x_offset = -k_width/2+h_radius+1*k_thick;
    hole_y_offset = -k_height/2+h_radius+1*k_thick;
    difference(){
        2d_outer();
        // Hole
        translate([hole_x_offset,hole_y_offset,0]) circle(r=h_radius);
    }
}

module 3d_pocket(){
    pocket_y_offset = k_height/2 - p_height/2 - (k_width-p_width)/2;
    pocket_z_offset = k_thick/2-p_depth/2+0.01;
    translate([0,pocket_y_offset,pocket_z_offset]) linear_extrude(height = p_depth, center = true) 2d_pocket();
}


module 3d_outer(){
    linear_extrude(height = k_thick, center = true) 2d_body();
}

module 3d_body(){
    difference() {
        3d_outer();
        3d_pocket();        
    }
}

3d_body();