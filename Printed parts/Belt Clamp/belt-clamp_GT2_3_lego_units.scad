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

include <configuration.scad>
include <../../../Generic_Mech_Repo/configuration/general.scad>

module beltclamp(){

clamp_height = NUT_HEIGHT_M3+1;
clamp_width = 8;
clamp_length = 16;		// distance between the center of the 2 holes
belt_pitch = 2;
belt_width = 7.5;
tooth_width = 1.3;
tooth_heigth = .75;
offset = belt_pitch/4;
// uncomment next line for a symetric clamp
//offset = 0;
    

    
    
	difference(){
		// basic shape
		union(0){
			translate(v = [0,0,clamp_height/2]) cube([clamp_length,clamp_width,clamp_height], center=true);
			translate(v = [-clamp_length/2, 0, 0]) cylinder(r=clamp_width/2,h=clamp_height);
			translate(v = [clamp_length/2, 0, 0]) cylinder(r=clamp_width/2,h=clamp_height);
			}
	    for (i=[-1,1]){
        translate([i*clamp_length/2,0,-0.05])
        rotate([0,0,90])
    color([1,0,0]){
hex_hole(h_trap=NUT_HEIGHT_M3,h_hole=clamp_height-NUT_HEIGHT_M3+0.1,r_trap=SCREW_STANDARD_M3,rot=0);}
}	
		// belt grip
		translate(v = [0,offset,clamp_height-tooth_heigth])
		for ( i = [round(-clamp_width/belt_pitch/2) : round(clamp_width/belt_pitch/2)]){
			translate(v = [0,belt_pitch*i,tooth_heigth])cube(size = [belt_width, tooth_width, tooth_heigth*2], center = true);
		}
	}

}

beltclamp();