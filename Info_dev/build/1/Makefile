TARGET = Tut02 

SOURCES = tut02.cpp 
LIBS = -lboost_filesystem-mt -lboost_system-mt 

#SOURCES = $(wildcard *.cpp)

HEADERS = $(wildcard *.h*)
OBJECTS = $(SOURCES:.cpp=.o)

INCLUDEPATH= -I/mingw32/include/
LIBPATH= -L/mingw32/lib/

# Fix for local needs
CXX      = g++
CXXFLAGS = -g -Wall -c 
LDFLAGS = -g -Wall

# Uncomment to build all when make file changes
SPECDEP=makefile


all: $(TARGET)

%.o: %.cpp $(HEADERS)
	g++ $(INCLUDEPATH) $(CXXFLAGS) $< -o $@


$(TARGET): $(OBJECTS)
	g++ $(LIBPATH) $(OBJECTS) $(LIBS) $(LDFLAGS) -o $(TARGET)


clean:
	rm -f $(TARGET) $(OBJECTS)
