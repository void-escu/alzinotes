TARGET_NAME:=alldirs
SYS_LIBS:=boost_filesystem-mt boost_system-mt boost_serialization-mt
LOCAL_LIBS:=

PLATFORM := $(shell uname)
ifeq ($(PLATFORM),Linux)
  SFX:=so
else
  SFX=dll
endif


MKFILE_PATH := $(abspath $(lastword $(MAKEFILE_LIST)))
CURRENT_DIR := $(notdir $(patsubst %/,%,$(dir $(MKFILE_PATH))))
ROOT_DIRECTORY= $(dir $(MKFILE_PATH))

OUT_BINDIR ?= $(ROOT_DIRECTORY)BIN

SHARED_OBJ := $(OUT_BINDIR)/$(TARGET_NAME).$(SFX)
TARGET := $(OUT_BINDIR)/$(TARGET_NAME)

INCLUDEDIRS:= /mingw32/include/ $(ROOT_DIRECTORY)export/
SYS_LIBDIR:=/mingw32/lib/
LOCAL_LIBDIR:=$(OUT_BINDIR)
LIBDIRS:=$(SYS_LIBDIR) $(LOCAL_LIBDIR)
LIBRARIES:= $(SYS_LIBS) $(LOCAL_LIBS)

# Fix for local needs
CXX := g++
CXX_FLAGS := -g -Wall
LD_FLAGS := -g -Wall
DLL_FLAGS := -shared

# Uncomment to build all when make file changes
SPECDEP=Makefile

D_SRCDIR := src.dll
M_SRCDIR := src.main
OBJDIR := obj
D_OBJDIR := $(OBJDIR)
M_OBJDIR := $(OBJDIR)

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


.PHONY: all clean MAIN_TARGET rundir

all: 
	@echo TARGETS accepted: MAIN_TARGET, SHARED, clean, clean_deps, rundir 
    

MAIN_TARGET: $(SHARED_OBJ) $(TARGET)

SHARED: $(SHARED_OBJ)

$(SHARED_OBJ): $(D_OBJ_FILES)
	$(CXX) $(DLL_FLAGS) $(LIBPATH) $(LD_FLAGS) -o $@ $^ $(LIBS)

$(TARGET): $(M_OBJ_FILES) 
	$(CXX) $(LIBPATH) $(LD_FLAGS) -o $@ $^ $(LIBS) -l$(TARGET_NAME)

$(OBJDIR):
	mkdir $(OBJDIR)

$(D_OBJDIR)/%.o:  $(D_SRCDIR)/%.cpp | $(OBJDIR) 
	$(CXX) $(INCLUDEPATH) $(CXX_FLAGS) -c -o $@ $<

$(M_OBJDIR)/%.o:  $(M_SRCDIR)/%.cpp | $(OBJDIR) 
	$(CXX) $(INCLUDEPATH) $(CXX_FLAGS) -c -o $@ $<

clean:
	-rm -rf $(OBJDIR)
	-rm -f $(TARGET)
	-rm -f $(SHARED_OBJ)

clean_deps:
	-rm $(DEP_FILES)

rundir: $(TARGET)
	@echo This will do rundir = copy all system and dep libs in OUT_BINDIR 
	for lf in $(SYS_LIBS) stdc++-6 gcc_s_dw2-1 winpthread-1 ; do \
		cp $(SYS_LIBDIR)/../bin/lib$$lf.$(SFX) $(OUT_BINDIR); \
	done 
    
CXX_FLAGS += -MMD
-include $(OBJ_FILES:.o=.d)
