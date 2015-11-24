include <configuration.scad>

module SRodMount(rodsize = 8, thickness = 3) {
    difference() {
        union() {
            for (sign1 = [1,-1]){
                hull() {
                    rotate([0,0,sign1*45])translate([-12,0,0])cylinder(r=7,h=thickness);
                    cylinder(r=rodsize/2 +4,h=thickness);
                }
            }
			cylinder(r=rodsize/2 +4,h=thickness+7);
        }
		translate([0,0,thickness])
			cylinder(h=thickness+5,d=rodsize);

		for (sign1 = [1,-1]) {
            translate([-1*(5+rodsize/2),sign1*(5+rodsize/2),-1])
                cylinder(d=m4_dia,h=thickness+2);
        }
    }
}

module ShaftMount(thickness = 3)
{
	difference(){
		union(){
            hull() {
                for (x = [1,-1]) {
                    for (y = [1,-1]) {
                        translate([x*15,y*15,0])cylinder(r=10, h=thickness);
                    }
                }
            }
			cylinder(r=16,h=7+thickness);
		}
		translate([0,0,-1])
			cylinder(d=20, h=thickness+9);

		translate([0,0,thickness])
			cylinder(d=22, h=8);

		translate([0,0,thickness+5.5])
			cylinder(d=25, h=8);			

		for (sign1 = [1,-1]){
			for (sign2 = [1,-1]){
				translate([sign1*19,sign2*19,-1])
					cylinder(d=m4_dia, h=2+thickness);
			}
		}
		
	}
}



module ZMountBottom(rodspacing = 175, rodsize = 8, thickness = 3)
{

 difference(){
  union(){		
	rotate([0,0,45])
		ShaftMount(thickness);	

	translate([-rodspacing/2,0,0])
			SRodMount(rodsize, thickness);	
		translate([rodspacing/2,0,0])
			rotate([0,0,180])	
				SRodMount(rodsize, thickness);

	translate([-rodspacing/3.5,0,thickness/2])
			cube([rodspacing/2.5,16,thickness], center=true);
		translate([rodspacing/3.5,0,thickness/2])
			cube([rodspacing/2.5,16,thickness], center=true);
   }

		translate([0,27,4])
			cube([50,10,10], center = true);
 }

}

module PillarMount(thickness = 3)
{
	difference(){
		union(){
            hull() {
                for (x = [1,-1]) {
                    for (y = [1,-1]) {
                        translate([x*15,y*15,0])cylinder(r=10, h=thickness);
                    }
                }
            }
			cylinder(r=22,h=7+thickness);
		}
		translate([0,0,-1])
				cylinder(d=35, h=9+thickness);

		translate([0,0,thickness])
			cylinder(d=37, h=8);

		for (sign1 = [1,-1]){
			for (sign2 = [1,-1]){
				translate([sign1*19,sign2*19,-1])
					cylinder(d=m4_dia, h=2+thickness);
			}
		}
		
	}
}



module ZMountTop(rodspacing = 175, rodsize = 8, thickness = 3)
{
  difference(){
	union(){	
		rotate([0,0,45])PillarMount(thickness);	

		translate([-rodspacing/2,0,0])SRodMount(rodsize, thickness);	
		translate([rodspacing/2,0,0])rotate([0,0,180])SRodMount(rodsize, thickness);	

	translate([-rodspacing/3.5,0,thickness/2])
			cube([rodspacing/2.5,16,thickness], center=true);
		translate([rodspacing/3.5,0,thickness/2])
			cube([rodspacing/2.5,16,thickness], center=true);
	}
  
    // Slice of corner    
    translate([0,27,4])cube([50,10,10],center=true);
  }

}

//ZMountBottom(thickness = 3);
//PillarMount(3);
//ZmountTop();