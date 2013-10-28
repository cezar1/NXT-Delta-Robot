// PRUSA Mendel  
// Belt clamp
// GNU GPL v3
// Josef Průša
// josefprusa@me.com
// prusadjs.cz
// http://www.reprap.org/wiki/Prusa_Mendel
// http://github.com/prusajr/PrusaMendel
//
// modified by neurofun
// modified by DanMoto

include <configuration.scad>


module beltclamp(){
belt_pitch = 2;
belt_width = 10;
belt_offset = 0; // Use for Prusa I2 X-Carriage 
clamp_height = 5;
clamp_width = 10;
clamp_length = 18;		// distance between the center of the 2 holes
tooth_width = 1.3;
tooth_heigth = .75;
bottom_tooth_width = 1.4;
bottom_tooth_height = 1.2;
offset = belt_pitch/4;
offset2 = offset+(belt_pitch/2);
// uncomment next line for a symetric clamp
//offset = 0;

	difference(){
		// basic shape

		union(0){
			translate(v = [0,0,clamp_height/2]) cube([clamp_length,clamp_width,clamp_height], center=true);
			translate(v = [-clamp_length/2, 0, 0]) cylinder(r=clamp_width/2,h=clamp_height);
			translate(v = [clamp_length/2, 0, 0]) cylinder(r=clamp_width/2,h=clamp_height);
		}

		// screw holes
		translate(v = [-clamp_length/2, 0, -1])
			polyhole(m3_diameter, clamp_height+2);
		translate(v = [clamp_length/2, 0, -1])
			polyhole(m3_diameter, clamp_height+2);

		// bottom belt grip
		for ( i = [round(-clamp_width/belt_pitch/2) : round(clamp_width/belt_pitch/2)])
			translate(v = [belt_offset,(belt_pitch*i)+offset,0])
				cube(size = [belt_width, bottom_tooth_width, bottom_tooth_height*2], center = true);

		// top belt grip
		for ( i = [round(-clamp_width/belt_pitch/2) : round(clamp_width/belt_pitch/2)])
			translate(v = [belt_offset,(belt_pitch*i)+offset2,clamp_height])
				cube(size = [belt_width, tooth_width, tooth_heigth*2], center = true);
		
	}

}

beltclamp();