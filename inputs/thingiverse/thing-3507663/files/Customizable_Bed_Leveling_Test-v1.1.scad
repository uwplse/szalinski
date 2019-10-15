/*
Customizable Bed Leveling Test
Version 1.1
Written by kenwebart

Customize your own bed leveling test.

Please update your settings below.

License: Creative Commons Attribution-ShareAlike 4.0 International License
This is a human-readable summary of the full license below.

Under this license, you are free to:
Share - copy and redistribute the material in any medium or format
Adapt - remix, transform, and build upon the material for any purpose, even commercially.
The licensor cannot revoke these freedoms as long as you follow the license terms.

License terms

Attribution - You must give appropriate credit, provide a link to the license, and indicate if changes were made. You may do so in any reasonable manner, but not in any way that suggests the licensor endorses you or your use.
ShareAlike - If you remix, transform, or build upon the material, you must distribute your contributions under the same license as the original.
No additional restrictions - You may not apply legal terms or technological measures that legally restrict others from doing anything the license permits.

Notices

You do not have to comply with the license for elements of the material in the public domain or where your use is permitted by an applicable exception or limitation.
//No warranties are given. The license may not give you all of the permissions necessary for your intended use. For example, other rights such as publicity, privacy, or moral rights may limit how you use the material.
*/

/*
Use at your own risk.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS
BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER
IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
POSSIBILITY OF SUCH DAMAGE.

*/

//width in mm.
printer_x = 210;

//depth in mm.
printer_y = 210; 

//height in mm.
printer_z = 205;

//diameter in mm.
nozzle = 0.4;

//height in mm.
layerheight = 0.2;

//Bild plate margin in mm.
margin = 1.5;

//in  mm. If needed, try 15.
skirt_padding = 0;

//Choose a shape
shape = 0; // [0,1,2,3]

//calculate space  
x = printer_x - (margin*2) - (skirt_padding*2);
y = printer_y - (margin*2) - (skirt_padding*2);
z = printer_z - margin;


//module for lines
 module line(start, end) {
    hull() {
        translate(start) linear_extrude(height = layerheight) circle(nozzle); 
        translate(end) linear_extrude(height = layerheight) circle(nozzle); 
    }
}


if (shape == 0) {
		//set cube size
		a = 20;
		cubesize = [a,a,layerheight];
		
		//calc space between cubes
		cubesInRow = 5;
		lengthCubes = a*cubesInRow;
		xLength = x - lengthCubes;
		space = xLength/(cubesInRow-1);
	

	for (j=[0:cubesInRow-1]) {
		padding_y = (a*j)+(space*j);
		for (i=[0:cubesInRow-1]) {
			padding_x = (a*i)+(space*i);
				translate([padding_x,padding_y]) cube(cubesize);
			}
		}
	}

if (shape == 1) {
		//set cube size
		a = 20;
		cubesize = [a,a,layerheight];
	
		translate([0,0]) cube(cubesize);
		translate([x-a,0]) cube(cubesize);
		translate([0,y-a]) cube(cubesize);
		translate([x-a,y-a]) cube(cubesize);
		translate([(x-a)/2,(y-a)/2]) cube(cubesize);
	}

if (shape == 2) {
    
    //set space between lines in mm
    space = 10;
    
    //calc how many lines possible
    linesPossible = round(((x+y)/2)/(space*2+nozzle*2));
    echo(linesPossible);

        for (i=[0:linesPossible]) {
            padding = space*i;
            line([0+padding,0+padding], [x-padding,0+padding]);
            line([x-padding,0+padding], [y-padding,y-padding]);
            line([y-padding,y-padding], [0+padding,y-padding]);
            line([0+padding,y-padding], [0+padding,0+padding]);
        }
    }


if (shape == 3) {
	cube([x,y,layerheight]);
	}
	