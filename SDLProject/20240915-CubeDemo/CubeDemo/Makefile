PROJECT:=Demo3D

ifeq (${MAKE_FLAG},Debug)
	BUILD_DIR:=build/Debug
	CFLAGS:=-g
	CXXFLAGS:=-g
	LDFLAGS:=-g
else
	BUILD_DIR:=build/Release
	CFLAGS:=-O2
	CXXFLAGS:=-O2
	LDFLAGS:=-O2
endif

LIBS:=-lmingw32 -lSDL2main -lSDL2

PROGRAM:=${BUILD_DIR}/${PROJECT}.exe

PATH:=/mingw64/bin/:${PATH}

CC:=gcc
CXX:=g++

LD:=g++

SOURCES:=\
	main.cpp \
	Vec3.cpp \
	Matrix3.cpp \
	Color.cpp \
	Triangle.cpp \
	Ray.cpp

HEADERS:=\
	Vec3.h \
	Matrix3.h \
	Color.h \
	Triangle.h \
	Ray.h

OBJS:=$(addprefix ${BUILD_DIR}/,${SOURCES})
OBJS:=${OBJS:.cpp=.o}
OBJS:=${OBJS:.c=.o}

DEPS:=${OBJS:.o=.d}

default: ${BUILD_DIR} ${PROGRAM}
	@echo Makefile:Done!

all:
	${MAKE} MAKE_FLAG=Debug
	${MAKE} MAKE_FLAG=Release

${PROGRAM}: ${OBJS}
	${LD} ${LDFLAGS} -o $@ $^ ${LIBS}

${BUILD_DIR}/%.o: %.c
	${CC} ${CFLAGS} -o $@ -c $<

${BUILD_DIR}/%.o: %.cpp
	${CXX} ${CXXFLAGS} -o $@ -c $<

${BUILD_DIR}/%.d: %.c
	${CC} -M ${CFLAGS} $< -o $@
	@sed -r -e 's|($*)\.o[ :]*|${BUILD_DIR}/\1.o $@ : |g' -i $@

${BUILD_DIR}/%.d: %.cpp
	${CXX} -M ${CXXFLAGS} $< -o $@
	@sed -r -e 's|($*)\.o[ :]*|${BUILD_DIR}/\1.o $@ : |g' -i $@

${BUILD_DIR}:
	mkdir -p ${BUILD_DIR}

clean:
	rm ${OBJS}
	rm ${PROGRAM}

clean-all:
	${MAKE} clean MAKE_FLAG=Debug
	${MAKE} clean MAKE_FLAG=Release

run: default
	${PROGRAM}

output:
	@echo ${PROGRAM}

ifneq (${MAKECMDGOALS},clean)
sinclude ${DEPS}
endif