# Check *.deps files for needed variables first

# Define compiler and global flags for all platforms win linux
CXX := g++
CXX_FLAGS := -g -Wall
LD_FLAGS := -g -Wall
DLL_FLAGS := -shared

# Define the makefile folder and the root folder
MKFILE_PATH := $(abspath $(lastword $(MAKEFILE_LIST)))
CURRENT_DIR := $(notdir $(patsubst %/,%,$(dir $(MKFILE_PATH))))
ROOT_DIRECTORY= $(patsubst %/,%,$(dir $(MKFILE_PATH)))

OUT_BINDIR ?= $(ROOT_DIRECTORY)/BIN
D_SRCDIR := src.lib
M_SRCDIR := src.main
OBJDIR := obj
D_OBJDIR := $(OBJDIR)
M_OBJDIR := $(OBJDIR)

# Platform specific settings related to compilation naming etc
PLATFORM := $(shell uname)
ARCH := $(shell arch)

# Windows platform is calculate differently
ifneq ($(PLATFORM),Linux)
#PLATFORM := $(shell uname -o)
PLATFORM := WinMsysCygwin
endif

include $(ROOT_DIRECTORY)/build.$(PLATFORM).$(ARCH).deps 

INCTOEXPORT := $(ROOT_DIRECTORY)/export/
INCLUDEDIRS+= $(INCTOEXPORT)

ifeq ($(PLATFORM),Linux)
  SFX:=so
  SHARED_OBJ := $(OUT_BINDIR)/lib$(TARGET_NAME).$(SFX)
else
  SFX=dll
  SHARED_OBJ := $(OUT_BINDIR)/$(TARGET_NAME).$(SFX)
endif



TARGET := $(OUT_BINDIR)/$(TARGET_NAME)

LOCAL_LIBDIR:=$(OUT_BINDIR)
LIBDIRS:=$(SYS_LIBDIR) $(LOCAL_LIBDIR)
LIBRARIES:= $(SYS_LIBS) $(LOCAL_LIBS)

# Uncomment to build all when make file changes
SPECDEP=Makefile

#--------------------------

D_CPP_FILES := $(wildcard $(D_SRCDIR)/*.cpp)
M_CPP_FILES := $(wildcard $(M_SRCDIR)/*.cpp)
D_OBJ_FILES := $(addprefix $(OBJDIR)/,$(notdir $(D_CPP_FILES:.cpp=.o)))
M_OBJ_FILES := $(addprefix $(OBJDIR)/,$(notdir $(M_CPP_FILES:.cpp=.o)))
D_DEP_FILES := $(addprefix $(OBJDIR)/,$(notdir $(D_CPP_FILES:.cpp=.d)))
M_DEP_FILES := $(addprefix $(OBJDIR)/,$(notdir $(M_CPP_FILES:.cpp=.d)))

INCLUDEPATH := $(foreach includedir,$(INCLUDEDIRS),-I$(includedir))
LIBPATH := $(foreach libdir,$(LIBDIRS),-L$(libdir)) 
LIBS := $(foreach library,$(LIBRARIES),-l$(library))

# by default link with our generated lib
# when there are no sources for lib, we do not link with any internal library
ifeq ("$(D_OBJ_FILES)","") 
LINKLIBTARGET:=
else
LINKLIBTARGET:=-l$(TARGET_NAME)
endif



.PHONY: all clean clean_deps SHARED ALL rundir dirs_structure

all: 
	@echo TARGETS accepted: ALL, SHARED, clean, clean_deps, rundir, dirs_structure
	@echo - if it is the first time to launch this makefile, please create folder structure with: make dirs_structure 
	@echo - targets are: 
	@echo   clean, clean_deps - cleaning targets
	@echo   rundir - Msys Windows bring all needed librairies in BIN
	@echo   SHARED - build library
	@echo   ALL - build also an executable that use the library   

$(OBJDIR):
	mkdir $(OBJDIR)

$(OUT_BINDIR):
	mkdir $(OUT_BINDIR)

dirs_structure:
	@if [ ! -d $(OUT_BINDIR) ]; then mkdir $(OUT_BINDIR); fi
	@if [ ! -d $(ROOT_DIRECTORY)/$(OBJDIR) ];     then mkdir $(ROOT_DIRECTORY)/$(OBJDIR);     fi
	@if [ ! -d $(ROOT_DIRECTORY)/$(D_SRCDIR) ];   then mkdir $(ROOT_DIRECTORY)/$(D_SRCDIR);   fi
	@if [ ! -d $(ROOT_DIRECTORY)/$(M_SRCDIR) ];   then mkdir $(ROOT_DIRECTORY)/$(M_SRCDIR);   fi
	@if [ ! -d $(INCTOEXPORT) ];then mkdir $(INCTOEXPORT);fi
	@echo DIRS created: 
	@echo - sources for shared object: $(ROOT_DIRECTORY)/$(D_SRCDIR)
	@echo - sources for main executable that use shared object: $(ROOT_DIRECTORY)/$(M_SRCDIR)
	@echo - objects and dependencies : $(ROOT_DIRECTORY)/$(OBJDIR)
	@echo - library, executable and needed dependencies for running: $(OUT_BINDIR)
	@echo - .h include files needed by other projects to be able to use this library: $(INCTOEXPORT)
	@echo .


ALL: $(SHARED_OBJ) $(TARGET)

SHARED: $(SHARED_OBJ)

$(SHARED_OBJ): $(D_OBJ_FILES)
ifneq ("$(LINKLIBTARGET)","")
	$(CXX) $(DLL_FLAGS) $(LIBPATH) $(LD_FLAGS) -o $@ $^ $(LIBS) 
endif

$(TARGET): $(M_OBJ_FILES)
	$(CXX) $(LIBPATH) $(LD_FLAGS) -o $@ $^ $(LIBS) $(LINKLIBTARGET)

$(D_OBJDIR)/%.o:  $(D_SRCDIR)/%.cpp | $(OBJDIR) $(OUT_BINDIR)
	$(CXX) $(INCLUDEPATH) $(CXX_FLAGS) -c -o $@ $<

$(M_OBJDIR)/%.o:  $(M_SRCDIR)/%.cpp | $(OBJDIR) $(OUT_BINDIR)
	$(CXX) $(INCLUDEPATH) $(CXX_FLAGS) -c -o $@ $<

clean:
	-rm -rf $(OBJDIR)
	-rm -f $(TARGET)
	-rm -f $(SHARED_OBJ)

clean_deps:
	-rm $(DEP_FILES)

rundir: $(TARGET)
	@echo This will do rundir = copy all system and dep libs in OUT_BINDIR 
ifeq ($(PLATFORM),Linux)
	@echo Nothing to be done for Linux, just execute in BIN: LD_LIBRARY_PATH+=. ./proc args
else
	@for lf in $(SYS_LIBS) stdc++-6 gcc_s_dw2-1 winpthread-1 ; do \
		cp $(SYS_LIBDIR)/../bin/lib$$lf.$(SFX) $(OUT_BINDIR); \
	done
endif 
    
CXX_FLAGS += -MMD
-include $(OBJ_FILES:.o=.d)
