OPENSCAD:=$(shell which openscad)
TARGET=../stl

OPENSCAD_SETTINGS=$$fa=2;$$fs=0.2;

EXTRAS=configuration.scad shapes.scad

FILES=driveWheelRod.stl driveWheelTube.stl motorMountShort.stl motorMountLong.stl limitSwitchMount.stl pipeSupportLong.stl pipeSupportShort.stl

PARTS=$(join $(addsuffix $(TARGET)/, $(dir $(FILES))), $(notdir $(FILES))) 


TARGETS=$(PARTS)

parts : $(TARGET) $(TARGETS)

$(TARGET)/driveWheelRod.stl: driveWheel.scad $(EXTRAS)
	$(OPENSCAD) -o $@ -D'$(OPENSCAD_SETTINGS);beltWheelRod(75, 12, 19);' $<

$(TARGET)/driveWheelTube.stl: driveWheel.scad $(EXTRAS)
	$(OPENSCAD) -o $@ -D'$(OPENSCAD_SETTINGS);beltWheelTube(75, 12, 19);' $<

$(TARGET)/motorMountShort.stl: motorMount.scad $(EXTRAS)
	$(OPENSCAD) -o $@ -D'$(OPENSCAD_SETTINGS);MotorMount(Height=50);' $<

$(TARGET)/motorMountLong.stl: motorMount.scad $(EXTRAS)
	$(OPENSCAD) -o $@ -D'$(OPENSCAD_SETTINGS);MotorMount(Height=70);' $<

$(TARGET)/limitSwitchMount.stl: limitSwitchHolder.scad $(EXTRAS)
	$(OPENSCAD) -o $@ -D'$(OPENSCAD_SETTINGS);limitSwitchHolder();' $<

$(TARGET)/pipeSupportLong.stl: pipeSupport.scad $(EXTRAS)
	$(OPENSCAD) -o $@ -D'$(OPENSCAD_SETTINGS);pipeSupportLong();' $<

$(TARGET)/pipeSupportShort.stl: pipeSupport.scad $(EXTRAS)
	$(OPENSCAD) -o $@ -D'$(OPENSCAD_SETTINGS);pipeSupportShort();' $<


#assembly: $(TARGET) $(TARGET)/assembly.stl

all: parts assembly


$(TARGET) :
	mkdir -p $(TARGET)

#$(TARGET)/%.stl : %.scad $(EXTRAS)
#	@echo "Processing $@"
#	$(OPENSCAD) -o $@ -D'$(OPENSCAD_SETTINGS);$(subst $(TARGET)/,,$(subst .stl,();,$@))' $<


clean :
	rm -f $(TARGETS) $(TARGET)/assembly.stl
