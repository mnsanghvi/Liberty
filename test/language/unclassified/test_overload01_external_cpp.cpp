#ifdef __cplusplus
extern "C" {
#endif
/*
ANSI C code generated by SmartEiffel The GNU Eiffel Compiler, Eiffel tools and libraries
Release 2.4 (??? June ??th 2008) [????]
Copyright (C), 1994-2002 - INRIA - LORIA - ESIAL UHP Nancy 1 - FRANCE
Copyright (C), 2003-2005 - INRIA - LORIA - IUT Charlemagne Nancy 2 - FRANCE
D.COLNET, P.RIBET, C.ADRIAN, V.CROIZIER F.MERIZEN - SmartEiffel@loria.fr
http://SmartEiffel.loria.fr
C Compiler options used: -pipe -Os
*/

#ifdef __cplusplus
}
#endif
#include "test_overload01_external_cpp.h"
#ifdef __cplusplus
extern "C" {
#endif

/* Extra external prototype for line 37 of /home/cyril/SmartEiffel/se/trunk/test_suite/language/unclassified/test_overload01.e:*/
T2 cpp25cpp_value(T8 a1){
return ((T2)((Overload*)a1)->value());
}/*--*/

/* Extra external prototype for line 51 of /home/cyril/SmartEiffel/se/trunk/test_suite/language/unclassified/test_overload01.e:*/
T8 cpp25cpp_new(void){
return ((T8)new Overload());
}/*--*/

/* Extra external prototype for line 44 of /home/cyril/SmartEiffel/se/trunk/test_suite/language/unclassified/test_overload01.e:*/
void cpp25cpp_set_value(T8 a1,T2 a2){
((Overload*)a1)->value((int)a2);
}/*--*/

#ifdef __cplusplus
}
#endif
