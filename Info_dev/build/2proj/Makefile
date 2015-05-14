TARGET:=parse
INCLUDEDIRS:= /mingw32/include/
LIBDIRS:=/mingw32/lib/
LIBRARIES:= boost_filesystem-mt boost_system-mt

# Fix for local needs
CXX := g++
CXX_FLAGS := -g -Wall
LD_FLAGS := -g -Wall

# Uncomment to build all when make file changes
SPECDEP=makefile

SRCDIR := src
OBJDIR := obj

#--------------------------

CPP_FILES := $(wildcard $(SRCDIR)/*.cpp)
OBJ_FILES := $(addprefix $(OBJDIR)/,$(notdir $(CPP_FILES:.cpp=.o)))
DEP_FILES := $(addprefix $(OBJDIR)/,$(notdir $(CPP_FILES:.cpp=.d)))

INCLUDEPATH := $(foreach includedir,$(INCLUDEDIRS),-I$(includedir))
LIBPATH := $(foreach libdir,$(LIBDIRS),-L$(libdir)) 
LIBS := $(foreach library,$(LIBRARIES),-l$(library))


.PHONY: all clean

all: $(TARGET)

$(TARGET): $(OBJ_FILES)
	$(CXX) $(LIBPATH) $(LD_FLAGS) -o $@ $^ $(LIBS)

$(OBJDIR):
	mkdir $(OBJDIR)

$(OBJDIR)/%.o:  $(SRCDIR)/%.cpp | $(OBJDIR) 
	$(CXX) $(INCLUDEPATH) $(CXX_FLAGS) -c -o $@ $<

clean:
	-rm -rf $(OBJDIR)
	-rm -f $(TARGET)

clean_deps:
	-rm $(DEP_FILES)
    
CXX_FLAGS += -MMD
-include $(OBJ_FILES:.o=.d)
