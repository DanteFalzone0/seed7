# Makefile for bcc32 and Borland make under windows. Commands executed by: cmd.exe
# To compile use a windows console and call:
#   make -f mk_bcc32.mak depend
#   make -f mk_bcc32.mak
# If you use MinGW you should use mk_mingw.mak, mk_nmake.mak or mk_msys.mak instead.
# If you use msvc you should use mk_msvc.mak instead.

# CFLAGS =
# CFLAGS = -Wall -Wstrict-prototypes -Winline -Wconversion -Wshadow -Wpointer-arith
# CFLAGS = -O2 -fomit-frame-pointer -Wall -Wstrict-prototypes -Winline -Wconversion -Wshadow -Wpointer-arith
# CFLAGS = -O2
CFLAGS = -O2 -y -v $(INCLUDE_OPTIONS)
# CFLAGS = -O2 -v -w-
# CFLAGS = -O2 -g -pg -Wall -Wstrict-prototypes -Winline -Wconversion -Wshadow -Wpointer-arith
# CFLAGS = -O2 -fomit-frame-pointer -funroll-loops -Wall
# CFLAGS = -O2 -funroll-loops -Wall -pg
LDFLAGS = -lS:0x800000
# LDFLAGS = -pg
SYSTEM_LIBS = user32.lib ws2_32.lib
# SYSTEM_LIBS = user32.lib ws2_32.lib gmp.lib
SYSTEM_DRAW_LIBS = gdi32.lib
SYSTEM_CONSOLE_LIBS =
# SYSTEM_DATABASE_LIBS is defined in the file "macros". The program chkccomp.c writes it to "macros" when doing "make depend".
SEED7_LIB = seed7_05.lib
DRAW_LIB = s7_draw.lib
CONSOLE_LIB = s7_con.lib
DATABASE_LIB = s7_db.lib
COMP_DATA_LIB = s7_data.lib
COMPILER_LIB = s7_comp.lib
ALL_S7_LIBS = ..\bin\$(COMPILER_LIB) ..\bin\$(COMP_DATA_LIB) ..\bin\$(DRAW_LIB) ..\bin\$(CONSOLE_LIB) ..\bin\$(DATABASE_LIB) ..\bin\$(SEED7_LIB)
CC = bcc32

MOBJ = s7.obj
POBJ = runerr.obj option.obj primitiv.obj
LOBJ = actlib.obj arrlib.obj biglib.obj binlib.obj blnlib.obj bstlib.obj chrlib.obj cmdlib.obj conlib.obj dcllib.obj \
       drwlib.obj enulib.obj fillib.obj fltlib.obj hshlib.obj intlib.obj itflib.obj kbdlib.obj lstlib.obj pcslib.obj \
       pollib.obj prclib.obj prglib.obj reflib.obj rfllib.obj sctlib.obj setlib.obj soclib.obj sqllib.obj strlib.obj \
       timlib.obj typlib.obj ut8lib.obj
EOBJ = exec.obj doany.obj objutl.obj
AOBJ = act_comp.obj prg_comp.obj analyze.obj syntax.obj token.obj parser.obj name.obj type.obj \
       expr.obj atom.obj object.obj scanner.obj literal.obj numlit.obj findid.obj \
       error.obj infile.obj libpath.obj symbol.obj info.obj stat.obj fatal.obj match.obj
GOBJ = syvarutl.obj traceutl.obj actutl.obj executl.obj blockutl.obj \
       entutl.obj identutl.obj chclsutl.obj arrutl.obj
ROBJ = arr_rtl.obj bln_rtl.obj bst_rtl.obj chr_rtl.obj cmd_rtl.obj con_rtl.obj dir_rtl.obj drw_rtl.obj fil_rtl.obj \
       flt_rtl.obj hsh_rtl.obj int_rtl.obj itf_rtl.obj pcs_rtl.obj set_rtl.obj soc_rtl.obj sql_rtl.obj str_rtl.obj \
       tim_rtl.obj ut8_rtl.obj heaputl.obj numutl.obj sigutl.obj striutl.obj
DOBJ = big_rtl.obj big_gmp.obj cmd_win.obj dir_win.obj dll_win.obj fil_win.obj pcs_win.obj pol_sel.obj soc_none.obj \
       stat_win.obj tim_win.obj
OBJ = $(MOBJ)
SEED7_LIB_OBJ = $(ROBJ) $(DOBJ)
DRAW_LIB_OBJ = gkb_rtl.obj drw_win.obj gkb_win.obj
CONSOLE_LIB_OBJ = kbd_rtl.obj con_win.obj
DATABASE_LIB_OBJ_STD_INCL = sql_base.obj sql_fire.obj sql_lite.obj sql_my.obj sql_oci.obj sql_odbc.obj \
                            sql_post.obj sql_tds.obj
DATABASE_LIB_OBJ = $(DATABASE_LIB_OBJ_STD_INCL) sql_db2.obj sql_srv.obj
COMP_DATA_LIB_OBJ = typ_data.obj rfl_data.obj ref_data.obj listutl.obj flistutl.obj typeutl.obj datautl.obj
COMPILER_LIB_OBJ = $(POBJ) $(LOBJ) $(EOBJ) $(AOBJ) $(GOBJ)

MSRC = s7.c
PSRC = runerr.c option.c primitiv.c
LSRC = actlib.c arrlib.c biglib.c binlib.c blnlib.c bstlib.c chrlib.c cmdlib.c conlib.c dcllib.c \
       drwlib.c enulib.c fillib.c fltlib.c hshlib.c intlib.c itflib.c kbdlib.c lstlib.c pcslib.c \
       pollib.c prclib.c prglib.c reflib.c rfllib.c sctlib.c setlib.c soclib.c sqllib.c strlib.c \
       timlib.c typlib.c ut8lib.c
ESRC = exec.c doany.c objutl.c
ASRC = act_comp.c prg_comp.c analyze.c syntax.c token.c parser.c name.c type.c \
       expr.c atom.c object.c scanner.c literal.c numlit.c findid.c \
       error.c infile.c libpath.c symbol.c info.c stat.c fatal.c match.c
GSRC = syvarutl.c traceutl.c actutl.c executl.c blockutl.c \
       entutl.c identutl.c chclsutl.c arrutl.c
RSRC = arr_rtl.c bln_rtl.c bst_rtl.c chr_rtl.c cmd_rtl.c con_rtl.c dir_rtl.c drw_rtl.c fil_rtl.c \
       flt_rtl.c hsh_rtl.c int_rtl.c itf_rtl.c pcs_rtl.c set_rtl.c soc_rtl.c sql_rtl.c str_rtl.c \
       tim_rtl.c ut8_rtl.c heaputl.c numutl.c sigutl.c striutl.c
DSRC = big_rtl.c big_gmp.c cmd_win.c dir_win.c dll_win.c fil_win.c pcs_win.c pol_sel.c soc_none.c \
       stat_win.c tim_win.c
SRC = $(MSRC)
SEED7_LIB_SRC = $(RSRC) $(DSRC)
DRAW_LIB_SRC = gkb_rtl.c drw_win.c gkb_win.c
CONSOLE_LIB_SRC = kbd_rtl.c con_win.c
DATABASE_LIB_SRC_STD_INCL = sql_base.c sql_fire.c sql_lite.c sql_my.c sql_oci.c sql_odbc.c \
                            sql_post.c sql_tds.c
DATABASE_LIB_SRC = $(DATABASE_LIB_SRC_STD_INCL) sql_db2.c sql_srv.c
COMP_DATA_LIB_SRC = typ_data.c rfl_data.c ref_data.c listutl.c flistutl.c typeutl.c datautl.c
COMPILER_LIB_SRC = $(PSRC) $(LSRC) $(ESRC) $(ASRC) $(GSRC)

s7: ..\bin\s7.exe ..\prg\s7.exe
	..\bin\s7 -l ..\lib level
	@echo.
	@echo Use 'make s7c' (with your make command) to create the compiler.
	@echo.

s7c: ..\bin\s7c.exe ..\prg\s7c.exe
	@echo.
	@echo Use 'make test' (with your make command) to check Seed7.
	@echo.

..\bin\s7.exe: $(OBJ) $(ALL_S7_LIBS)
	$(CC) $(LDFLAGS) -o ..\bin\s7.exe $(OBJ) $(ALL_S7_LIBS) $(SYSTEM_DRAW_LIBS) $(SYSTEM_CONSOLE_LIBS) $(SYSTEM_DATABASE_LIBS) $(SYSTEM_LIBS) $(ADDITIONAL_SYSTEM_LIBS)

..\prg\s7.exe: ..\bin\s7.exe
	copy ..\bin\s7.exe ..\prg /Y

..\bin\s7c.exe: ..\prg\s7c.exe
	copy ..\prg\s7c.exe ..\bin /Y

..\prg\s7c.exe: ..\prg\s7c.sd7 $(ALL_S7_LIBS)
	..\bin\s7 -l ..\lib ..\prg\s7c -l ..\lib -b ..\bin -O2 ..\prg\s7c

sql_db2.o: sql_db2.c
	$(CC) -c $(CPPFLAGS) $(DB2_INCLUDE_OPTION) $(CFLAGS) $<

sql_srv.o: sql_srv.c
	$(CC) -c $(CPPFLAGS) $(SQL_SERVER_INCLUDE_OPTION) $(CFLAGS) $<

all: depend
	$(MAKE) -f mk_bcc32.mak s7 s7c

clear: clean

clean:
	del *.obj
	del ..\bin\*.lib
	del ..\bin\s7.exe
	del ..\bin\s7c.exe
	del ..\prg\s7.exe
	del ..\prg\s7c.exe
	del depend
	del macros
	del chkccomp.h
	del base.h
	del settings.h
	del version.h
	del bcc32.bat
	del calltlib.exe
	del setwpath.exe
	del wrdepend.exe
	del sudo.exe
	del *.tds
	del *.d
	@echo.
	@echo Use 'make depend' (with your make command) to create the dependencies.
	@echo.

distclean: clean
	copy level_bk.h level.h /Y
	del vers_bcc32.h

test:
	..\bin\s7 -l ..\lib ..\prg\chk_all build
	@echo.
	@echo Use 'sudo make install' (with your make command) to install Seed7.
	@echo Or open a console as administrator, go to the directory seed7/src
	@echo and use 'make install' (with your make command) to install Seed7.
	@echo.

install: setwpath.exe
	.\setwpath.exe add ..\bin

uninstall: setwpath.exe
	.\setwpath.exe remove ..\bin

dep: depend

bcc32.bat:
	echo bcc32.exe %* > bcc32.bat

chkccomp.h:
	echo ^#define LIST_DIRECTORY_CONTENTS "dir" > chkccomp.h

base.h:
	echo ^#define PATH_DELIMITER '\\' > base.h
	echo ^#define OS_STRI_WCHAR >> base.h
	echo ^#define QUOTE_WHOLE_SHELL_COMMAND >> base.h
	echo ^#define OBJECT_FILE_EXTENSION ".obj" >> base.h
	echo ^#define EXECUTABLE_FILE_EXTENSION ".exe" >> base.h
	echo ^#define C_COMPILER "$(CC)" >> base.h
	echo ^#define CC_OPT_VERSION_INFO "-h" >> base.h
	echo ^#define CC_FLAGS "" >> base.h
	echo ^#define CC_ERROR_FILEDES 1 >> base.h
	echo ^#define CC_VERSION_INFO_FILEDES 1 >> base.h
	echo ^#define CC_NO_OPT_OUTPUT_FILE >> base.h
	echo ^#define LINKER_OPT_OUTPUT_FILE "-o " >> base.h
	echo ^#define TURN_OFF_FP_EXCEPTIONS >> base.h
	echo ^#define DO_SIGFPE_WITH_DIV_BY_ZERO 1 >> base.h
	echo ^#define USE_ALTERNATE_LOCALTIME_R >> base.h
	echo ^#define SYSTEM_LIBS "$(SYSTEM_LIBS)" >> base.h

settings.h:
	echo ^#define SEARCH_PATH_DELIMITER ';' > settings.h
	echo ^#define UTIME_ORIG_BUGGY_FOR_FAT_FILES >> settings.h
	echo ^#define DEFINE__MATHERR_FUNCTION >> settings.h
	echo ^#define CONSOLE_WCHAR >> settings.h
	echo ^#define os_getch getch >> settings.h
	echo ^#define OS_GETCH_READS_BYTES >> settings.h
	echo ^#define LIBRARY_FILE_EXTENSION ".lib" >> settings.h
	echo ^#define CC_OPT_DEBUG_INFO "-y -v" >> settings.h
	echo ^#define CC_OPT_NO_WARNINGS "-w-" >> settings.h
	echo ^#define LINKER_OPT_DEBUG_INFO "-v" >> settings.h
	echo ^#define LINKER_FLAGS "$(LDFLAGS)" >> settings.h
	echo ^#define SYSTEM_DRAW_LIBS "$(SYSTEM_DRAW_LIBS)" >> settings.h
	echo ^#define SYSTEM_CONSOLE_LIBS "$(SYSTEM_CONSOLE_LIBS)" >> settings.h
	echo ^#define SEED7_LIB "$(SEED7_LIB)" >> settings.h
	echo ^#define DRAW_LIB "$(DRAW_LIB)" >> settings.h
	echo ^#define CONSOLE_LIB "$(CONSOLE_LIB)" >> settings.h
	echo ^#define DATABASE_LIB "$(DATABASE_LIB)" >> settings.h
	echo ^#define COMP_DATA_LIB "$(COMP_DATA_LIB)" >> settings.h
	echo ^#define COMPILER_LIB "$(COMPILER_LIB)" >> settings.h

version.h: chkccomp.h base.h settings.h
	$(CC) chkccomp.c
	chkccomp.exe version.h
	del chkccomp.obj
	del chkccomp.tds
	del chkccomp.exe
	$(CC) setpaths.c
	setpaths.exe "S7_LIB_DIR=$(S7_LIB_DIR)" "SEED7_LIBRARY=$(SEED7_LIBRARY)" >> version.h
	del setpaths.obj
	del setpaths.tds
	del setpaths.exe
	echo ^#include "stdio.h" > calltlib.c
	echo ^#include "string.h" >> calltlib.c
	echo int main (int argc, char **argv) >> calltlib.c
	echo { >> calltlib.c
	echo char buffer[4096]; >> calltlib.c
	echo int number; >> calltlib.c
	echo strcpy(buffer, "tlib /C "); >> calltlib.c
	echo strcat(buffer, argv[1]); >> calltlib.c
	echo strcat(buffer, " "); >> calltlib.c
	"echo for (number = 2; number ^< argc; number++) {" >> calltlib.c
	echo   strcat(buffer, "-+"); >> calltlib.c
	echo   strcat(buffer, argv[number]); >> calltlib.c
	echo } >> calltlib.c
	echo puts(buffer); >> calltlib.c
	echo system(buffer); >> calltlib.c
	echo return 0; >> calltlib.c
	echo } >> calltlib.c
	$(CC) calltlib.c
	del calltlib.c
	del calltlib.obj
	del calltlib.tds
	$(CC) setwpath.c
	$(CC) wrdepend.c
	$(CC) sudo.c
	copy version.h vers_bcc32.h /Y

.c.obj:
	$(CC) $(CFLAGS) -c $<

depend: version.h
	wrdepend.exe OPTION=INCLUDE_OPTIONS $(CFLAGS) -c -w- -m -md $(SRC)
	copy *.d depend
	del *.d
	del $(OBJ)
	wrdepend.exe OPTION=INCLUDE_OPTIONS $(CFLAGS) -c -w- -m -md $(SEED7_LIB_SRC)
	copy *.d a_depend
	del *.d
	del $(SEED7_LIB_OBJ)
	type a_depend >> depend
	wrdepend.exe OPTION=INCLUDE_OPTIONS $(CFLAGS) -c -w- -m -md $(DRAW_LIB_SRC)
	copy *.d a_depend
	del *.d
	del $(DRAW_LIB_OBJ)
	type a_depend >> depend
	wrdepend.exe OPTION=INCLUDE_OPTIONS $(CFLAGS) -c -w- -m -md $(CONSOLE_LIB_SRC)
	copy *.d a_depend
	del *.d
	del $(CONSOLE_LIB_OBJ)
	type a_depend >> depend
	wrdepend.exe OPTION=INCLUDE_OPTIONS $(CFLAGS) -c -w- -m -md $(DATABASE_LIB_SRC_STD_INCL)
	copy *.d a_depend
	del *.d
	del $(DATABASE_LIB_OBJ_STD_INCL)
	type a_depend >> depend
	wrdepend.exe OPTION=DB2_INCLUDE_OPTION $(CFLAGS) -c -w- -m -md sql_db2.c
	copy *.d a_depend
	del *.d
	del sql_db2.obj
	type a_depend >> depend
	wrdepend.exe OPTION=SQL_SERVER_INCLUDE_OPTION $(CFLAGS) -c -w- -m -md sql_srv.c
	copy *.d a_depend
	del *.d
	del sql_srv.obj
	type a_depend >> depend
	wrdepend.exe OPTION=INCLUDE_OPTIONS $(CFLAGS) -c -w- -m -md $(COMP_DATA_LIB_SRC)
	copy *.d a_depend
	del *.d
	del $(COMP_DATA_LIB_OBJ)
	type a_depend >> depend
	wrdepend.exe OPTION=INCLUDE_OPTIONS $(CFLAGS) -c -w- -m -md $(COMPILER_LIB_SRC)
	copy *.d d_depend
	del *.d
	del $(COMPILER_LIB_OBJ)
	type a_depend >> depend
	del a_depend
	@echo.
	@echo Use 'make' (with your make command) to create the interpreter.
	@echo.

level.h:
	..\bin\s7 -l ..\lib level

..\bin\$(SEED7_LIB): $(SEED7_LIB_OBJ)
	calltlib ..\bin\$(SEED7_LIB) $(SEED7_LIB_OBJ)

..\bin\$(DRAW_LIB): $(DRAW_LIB_OBJ)
	calltlib ..\bin\$(DRAW_LIB) $(DRAW_LIB_OBJ)

..\bin\$(CONSOLE_LIB): $(CONSOLE_LIB_OBJ)
	calltlib ..\bin\$(CONSOLE_LIB) $(CONSOLE_LIB_OBJ)

..\bin\$(DATABASE_LIB): $(DATABASE_LIB_OBJ)
	calltlib ..\bin\$(DATABASE_LIB) $(DATABASE_LIB_OBJ)

..\bin\$(COMP_DATA_LIB): $(COMP_DATA_LIB_OBJ)
	calltlib ..\bin\$(COMP_DATA_LIB) $(COMP_DATA_LIB_OBJ)

..\bin\$(COMPILER_LIB): $(COMPILER_LIB_OBJ)
	calltlib ..\bin\$(COMPILER_LIB) $(COMPILER_LIB_OBJ)

..\bin\bas7.exe: ..\prg\bas7.sd7 ..\bin\s7c.exe
	..\bin\s7c.exe -l ..\lib -b ..\bin -O2 ..\prg\bas7
	copy ..\prg\bas7.exe ..\bin /Y
	del ..\prg\bas7.exe

..\bin\bigfiles.exe: ..\prg\bigfiles.sd7 ..\bin\s7c.exe
	..\bin\s7c.exe -l ..\lib -b ..\bin -O2 ..\prg\bigfiles
	copy ..\prg\bigfiles.exe ..\bin /Y
	del ..\prg\bigfiles.exe

..\bin\calc7.exe: ..\prg\calc7.sd7 ..\bin\s7c.exe
	..\bin\s7c.exe -l ..\lib -b ..\bin -O2 ..\prg\calc7
	copy ..\prg\calc7.exe ..\bin /Y
	del ..\prg\calc7.exe

..\bin\cat.exe: ..\prg\cat.sd7 ..\bin\s7c.exe
	..\bin\s7c.exe -l ..\lib -b ..\bin -O2 ..\prg\cat
	copy ..\prg\cat.exe ..\bin /Y
	del ..\prg\cat.exe

..\bin\comanche.exe: ..\prg\comanche.sd7 ..\bin\s7c.exe
	..\bin\s7c.exe -l ..\lib -b ..\bin -O2 ..\prg\comanche
	copy ..\prg\comanche.exe ..\bin /Y
	del ..\prg\comanche.exe

..\bin\db7.exe: ..\prg\db7.sd7 ..\bin\s7c.exe
	..\bin\s7c.exe -l ..\lib -b ..\bin -O2 ..\prg\db7
	copy ..\prg\db7.exe ..\bin /Y
	del ..\prg\db7.exe

..\bin\diff7.exe: ..\prg\diff7.sd7 ..\bin\s7c.exe
	..\bin\s7c.exe -l ..\lib -b ..\bin -O2 ..\prg\diff7
	copy ..\prg\diff7.exe ..\bin /Y
	del ..\prg\diff7.exe

..\bin\find7.exe: ..\prg\find7.sd7 ..\bin\s7c.exe
	..\bin\s7c.exe -l ..\lib -b ..\bin -O2 ..\prg\find7
	copy ..\prg\find7.exe ..\bin /Y
	del ..\prg\find7.exe

..\bin\findchar.exe: ..\prg\findchar.sd7 ..\bin\s7c.exe
	..\bin\s7c.exe -l ..\lib -b ..\bin -O2 ..\prg\findchar
	copy ..\prg\findchar.exe ..\bin /Y
	del ..\prg\findchar.exe

..\bin\ftp7.exe: ..\prg\ftp7.sd7 ..\bin\s7c.exe
	..\bin\s7c.exe -l ..\lib -b ..\bin -O2 ..\prg\ftp7
	copy ..\prg\ftp7.exe ..\bin /Y
	del ..\prg\ftp7.exe

..\bin\ftpserv.exe: ..\prg\ftpserv.sd7 ..\bin\s7c.exe
	..\bin\s7c.exe -l ..\lib -b ..\bin -O2 ..\prg\ftpserv
	copy ..\prg\ftpserv.exe ..\bin /Y
	del ..\prg\ftpserv.exe

..\bin\hd.exe: ..\prg\hd.sd7 ..\bin\s7c.exe
	..\bin\s7c.exe -l ..\lib -b ..\bin -O2 ..\prg\hd
	copy ..\prg\hd.exe ..\bin /Y
	del ..\prg\hd.exe

..\bin\make7.exe: ..\prg\make7.sd7 ..\bin\s7c.exe
	..\bin\s7c.exe -l ..\lib -b ..\bin -O2 ..\prg\make7
	copy ..\prg\make7.exe ..\bin /Y
	del ..\prg\make7.exe

..\bin\sql7.exe: ..\prg\sql7.sd7 ..\bin\s7c.exe
	..\bin\s7c.exe -l ..\lib -b ..\bin -O2 ..\prg\sql7
	copy ..\prg\sql7.exe ..\bin /Y
	del ..\prg\sql7.exe

..\bin\sydir7.exe: ..\prg\sydir7.sd7 ..\bin\s7c.exe
	..\bin\s7c.exe -l ..\lib -b ..\bin -O2 ..\prg\sydir7
	copy ..\prg\sydir7.exe ..\bin /Y
	del ..\prg\sydir7.exe

..\bin\tar7.exe: ..\prg\tar7.sd7 ..\bin\s7c.exe
	..\bin\s7c.exe -l ..\lib -b ..\bin -O2 ..\prg\tar7
	copy ..\prg\tar7.exe ..\bin /Y
	del ..\prg\tar7.exe

..\bin\toutf8.exe: ..\prg\toutf8.sd7 ..\bin\s7c.exe
	..\bin\s7c.exe -l ..\lib -b ..\bin -O2 ..\prg\toutf8
	copy ..\prg\toutf8.exe ..\bin /Y
	del ..\prg\toutf8.exe

..\bin\which.exe: ..\prg\which.sd7 ..\bin\s7c.exe
	..\bin\s7c.exe -l ..\lib -b ..\bin -O2 ..\prg\which
	copy ..\prg\which.exe ..\bin /Y
	del ..\prg\which.exe

bas7: ..\bin\bas7.exe
bigfiles: ..\bin\bigfiles.exe
calc7: ..\bin\calc7.exe
cat: ..\bin\cat.exe
comanche: ..\bin\comanche.exe
db7: ..\bin\db7.exe
diff7: ..\bin\diff7.exe
find7: ..\bin\find7.exe
findchar: ..\bin\findchar.exe
ftp7: ..\bin\ftp7.exe
ftpserv: ..\bin\ftpserv.exe
hd: ..\bin\hd.exe
make7: ..\bin\make7.exe
sql7: ..\bin\sql7.exe
sydir7: ..\bin\sydir7.exe
tar7: ..\bin\tar7.exe
toutf8: ..\bin\toutf8.exe
which: ..\bin\which.exe

utils: ..\bin\bas7.exe ..\bin\bigfiles.exe ..\bin\calc7.exe ..\bin\cat.exe ..\bin\comanche.exe ..\bin\db7.exe \
       ..\bin\diff7.exe ..\bin\find7.exe ..\bin\findchar.exe ..\bin\ftp7.exe ..\bin\ftpserv.exe ..\bin\hd.exe \
       ..\bin\make7.exe ..\bin\sql7.exe ..\bin\sydir7.exe ..\bin\tar7.exe ..\bin\toutf8.exe ..\bin\which.exe

wc: $(SRC)
	@echo SRC:
	wc $(SRC)
	@echo SEED7_LIB_SRC:
	wc $(SEED7_LIB_SRC)
	@echo DRAW_LIB_SRC:
	wc $(DRAW_LIB_SRC)
	@echo CONSOLE_LIB_SRC:
	wc $(CONSOLE_LIB_SRC)
	@echo DATABASE_LIB_SRC:
	wc $(DATABASE_LIB_SRC)
	@echo COMP_DATA_LIB_SRC:
	wc $(COMP_DATA_LIB_SRC)
	@echo COMPILER_LIB_SRC:
	wc $(COMPILER_LIB_SRC)

lint: $(SRC)
	lint -p $(SRC) $(SYSTEM_DRAW_LIBS) $(SYSTEM_CONSOLE_LIBS) $(SYSTEM_DATABASE_LIBS) $(SYSTEM_LIBS) $(ADDITIONAL_SYSTEM_LIBS)

lint2: $(SRC)
	lint -Zn2048 $(SRC) $(SYSTEM_DRAW_LIBS) $(SYSTEM_CONSOLE_LIBS) $(SYSTEM_DATABASE_LIBS) $(SYSTEM_LIBS) $(ADDITIONAL_SYSTEM_LIBS)

!if "exist depend"
!include depend
!endif

!if "exist macros"
!include macros
!endif
