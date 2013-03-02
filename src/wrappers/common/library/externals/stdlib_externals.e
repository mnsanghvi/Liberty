-- This file have been created by wrapper-generator.
-- Any change will be lost by the next execution of the tool.

deferred class STDLIB_EXTERNALS


insert ANY undefine is_equal, copy end

		-- TODO: insert typedefs class
feature {} -- External calls

	a64l (a_s: POINTER): INTEGER_64 is
 		-- a64l
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "a64l"
		}"
		end

	abort is
 		-- abort
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "abort()"
		}"
		end

	abs (a_x: INTEGER_32): INTEGER_32 is
 		-- abs
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "abs"
		}"
		end

	at_quick_exit (a_func: POINTER): INTEGER_32 is
 		-- at_quick_exit
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "at_quick_exit"
		}"
		end

	atexit (a_func: POINTER): INTEGER_32 is
 		-- atexit
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "atexit"
		}"
		end

	atof (a_nptr: POINTER): REAL_64 is
 		-- atof
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "atof"
		}"
		end

	atoi (a_nptr: POINTER): INTEGER_32 is
 		-- atoi
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "atoi"
		}"
		end

	atol (a_nptr: POINTER): INTEGER_64 is
 		-- atol
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "atol"
		}"
		end

	atoll (a_nptr: POINTER): INTEGER_64 is
 		-- atoll
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "atoll"
		}"
		end

	bsearch (a_key: POINTER; a_base: POINTER; a_nmemb: NATURAL_64; a_size: NATURAL_64; a_compar: POINTER): POINTER is
 		-- bsearch
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "bsearch"
		}"
		end

	calloc (a_nmemb: NATURAL_64; a_size: NATURAL_64): POINTER is
 		-- calloc
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "calloc"
		}"
		end

	canonicalize_file_name (a_name: POINTER): POINTER is
 		-- canonicalize_file_name
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "canonicalize_file_name"
		}"
		end

	cfree (a_ptr: POINTER) is
 		-- cfree
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "cfree"
		}"
		end

	clearenv: INTEGER_32 is
 		-- clearenv
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "clearenv()"
		}"
		end

	-- `hidden' function __ctype_get_mb_cur_max skipped.
	-- function div (at line 786 in file /usr/include/stdlib.h is not wrappable
	drand48: REAL_64 is
 		-- drand48
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "drand48()"
		}"
		end

	drand48_r (a_buffer: POINTER; a_result: POINTER): INTEGER_32 is
 		-- drand48_r
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "drand48_r"
		}"
		end

	ecvt (a_value: REAL_64; a_ndigit: INTEGER_32; a_decpt: POINTER; a_sign: POINTER): POINTER is
 		-- ecvt
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "ecvt"
		}"
		end

	ecvt_r (a_value: REAL_64; a_ndigit: INTEGER_32; a_decpt: POINTER; a_sign: POINTER; a_buf: POINTER; a_len: NATURAL_64): INTEGER_32 is
 		-- ecvt_r
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "ecvt_r"
		}"
		end

	erand48 (a_xsubi: POINTER): REAL_64 is
 		-- erand48
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "erand48"
		}"
		end

	erand48_r (a_xsubi: POINTER; a_buffer: POINTER; a_result: POINTER): INTEGER_32 is
 		-- erand48_r
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "erand48_r"
		}"
		end

	-- `hidden' function _Exit skipped.
	exit (a_status: INTEGER_32) is
 		-- exit
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "exit"
		}"
		end

	fcvt (a_value: REAL_64; a_ndigit: INTEGER_32; a_decpt: POINTER; a_sign: POINTER): POINTER is
 		-- fcvt
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "fcvt"
		}"
		end

	fcvt_r (a_value: REAL_64; a_ndigit: INTEGER_32; a_decpt: POINTER; a_sign: POINTER; a_buf: POINTER; a_len: NATURAL_64): INTEGER_32 is
 		-- fcvt_r
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "fcvt_r"
		}"
		end

	free (a_ptr: POINTER) is
 		-- free
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "free"
		}"
		end

	gcvt (a_value: REAL_64; a_ndigit: INTEGER_32; a_buf: POINTER): POINTER is
 		-- gcvt
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "gcvt"
		}"
		end

	getenv (a_name: POINTER): POINTER is
 		-- getenv
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "getenv"
		}"
		end

	getloadavg (a_loadavg: POINTER; a_nelem: INTEGER_32): INTEGER_32 is
 		-- getloadavg
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "getloadavg"
		}"
		end

	getpt: INTEGER_32 is
 		-- getpt
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "getpt()"
		}"
		end

	getsubopt (an_optionp: POINTER; a_tokens: POINTER; a_valuep: POINTER): INTEGER_32 is
 		-- getsubopt
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "getsubopt"
		}"
		end

	grantpt (a_fd: INTEGER_32): INTEGER_32 is
 		-- grantpt
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "grantpt"
		}"
		end

	initstate (a_seed: NATURAL_32; a_statebuf: POINTER; a_statelen: NATURAL_64): POINTER is
 		-- initstate
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "initstate"
		}"
		end

	initstate_r (a_seed: NATURAL_32; a_statebuf: POINTER; a_statelen: NATURAL_64; a_buf: POINTER): INTEGER_32 is
 		-- initstate_r
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "initstate_r"
		}"
		end

	jrand48 (a_xsubi: POINTER): INTEGER_64 is
 		-- jrand48
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "jrand48"
		}"
		end

	jrand48_r (a_xsubi: POINTER; a_buffer: POINTER; a_result: POINTER): INTEGER_32 is
 		-- jrand48_r
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "jrand48_r"
		}"
		end

	l64a (a_n: INTEGER_64): POINTER is
 		-- l64a
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "l64a"
		}"
		end

	labs (a_x: INTEGER_64): INTEGER_64 is
 		-- labs
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "labs"
		}"
		end

	lcong48 (a_param: POINTER) is
 		-- lcong48
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "lcong48"
		}"
		end

	lcong48_r (a_param: POINTER; a_buffer: POINTER): INTEGER_32 is
 		-- lcong48_r
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "lcong48_r"
		}"
		end

	-- function ldiv (at line 788 in file /usr/include/stdlib.h is not wrappable
	llabs (a_x: INTEGER_64): INTEGER_64 is
 		-- llabs
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "llabs"
		}"
		end

	-- function lldiv (at line 795 in file /usr/include/stdlib.h is not wrappable
	lrand48: INTEGER_64 is
 		-- lrand48
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "lrand48()"
		}"
		end

	lrand48_r (a_buffer: POINTER; a_result: POINTER): INTEGER_32 is
 		-- lrand48_r
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "lrand48_r"
		}"
		end

	malloc (a_size: NATURAL_64): POINTER is
 		-- malloc
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "malloc"
		}"
		end

	mblen (a_s: POINTER; a_n: NATURAL_64): INTEGER_32 is
 		-- mblen
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "mblen"
		}"
		end

	mbtowc (a_pwc: POINTER; a_s: POINTER; a_n: NATURAL_64): INTEGER_32 is
 		-- mbtowc
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "mbtowc"
		}"
		end

	memcpy (a_dest: POINTER; a_src: POINTER; a_len: NATURAL_64): POINTER is
 		-- memcpy
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "memcpy"
		}"
		end

	mkdtemp (a_template: POINTER): POINTER is
 		-- mkdtemp
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "mkdtemp"
		}"
		end

	mkostemp (a_template: POINTER; a_flags: INTEGER_32): INTEGER_32 is
 		-- mkostemp
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "mkostemp"
		}"
		end

	mkostemp64 (a_template: POINTER; a_flags: INTEGER_32): INTEGER_32 is
 		-- mkostemp64
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "mkostemp64"
		}"
		end

	mkostemps (a_template: POINTER; a_suffixlen: INTEGER_32; a_flags: INTEGER_32): INTEGER_32 is
 		-- mkostemps
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "mkostemps"
		}"
		end

	mkostemps64 (a_template: POINTER; a_suffixlen: INTEGER_32; a_flags: INTEGER_32): INTEGER_32 is
 		-- mkostemps64
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "mkostemps64"
		}"
		end

	mkstemp (a_template: POINTER): INTEGER_32 is
 		-- mkstemp
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "mkstemp"
		}"
		end

	mkstemp64 (a_template: POINTER): INTEGER_32 is
 		-- mkstemp64
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "mkstemp64"
		}"
		end

	mkstemps (a_template: POINTER; a_suffixlen: INTEGER_32): INTEGER_32 is
 		-- mkstemps
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "mkstemps"
		}"
		end

	mkstemps64 (a_template: POINTER; a_suffixlen: INTEGER_32): INTEGER_32 is
 		-- mkstemps64
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "mkstemps64"
		}"
		end

	mktemp (a_template: POINTER): POINTER is
 		-- mktemp
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "mktemp"
		}"
		end

	mrand48: INTEGER_64 is
 		-- mrand48
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "mrand48()"
		}"
		end

	mrand48_r (a_buffer: POINTER; a_result: POINTER): INTEGER_32 is
 		-- mrand48_r
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "mrand48_r"
		}"
		end

	nrand48 (a_xsubi: POINTER): INTEGER_64 is
 		-- nrand48
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "nrand48"
		}"
		end

	nrand48_r (a_xsubi: POINTER; a_buffer: POINTER; a_result: POINTER): INTEGER_32 is
 		-- nrand48_r
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "nrand48_r"
		}"
		end

	on_exit (a_func: POINTER; an_arg: POINTER): INTEGER_32 is
 		-- on_exit
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "on_exit"
		}"
		end

	posix_memalign (a_memptr: POINTER; an_alignment: NATURAL_64; a_size: NATURAL_64): INTEGER_32 is
 		-- posix_memalign
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "posix_memalign"
		}"
		end

	posix_openpt (an_oflag: INTEGER_32): INTEGER_32 is
 		-- posix_openpt
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "posix_openpt"
		}"
		end

	ptsname (a_fd: INTEGER_32): POINTER is
 		-- ptsname
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "ptsname"
		}"
		end

	putenv (a_string: POINTER): INTEGER_32 is
 		-- putenv
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "putenv"
		}"
		end

	qecvt (a_value: REAL_128; a_ndigit: INTEGER_32; a_decpt: POINTER; a_sign: POINTER): POINTER is
 		-- qecvt
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "qecvt"
		}"
		end

	qecvt_r (a_value: REAL_128; a_ndigit: INTEGER_32; a_decpt: POINTER; a_sign: POINTER; a_buf: POINTER; a_len: NATURAL_64): INTEGER_32 is
 		-- qecvt_r
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "qecvt_r"
		}"
		end

	qfcvt (a_value: REAL_128; a_ndigit: INTEGER_32; a_decpt: POINTER; a_sign: POINTER): POINTER is
 		-- qfcvt
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "qfcvt"
		}"
		end

	qfcvt_r (a_value: REAL_128; a_ndigit: INTEGER_32; a_decpt: POINTER; a_sign: POINTER; a_buf: POINTER; a_len: NATURAL_64): INTEGER_32 is
 		-- qfcvt_r
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "qfcvt_r"
		}"
		end

	qgcvt (a_value: REAL_128; a_ndigit: INTEGER_32; a_buf: POINTER): POINTER is
 		-- qgcvt
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "qgcvt"
		}"
		end

	qsort (a_base: POINTER; a_nmemb: NATURAL_64; a_size: NATURAL_64; a_compar: POINTER) is
 		-- qsort
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "qsort"
		}"
		end

	qsort_r (a_base: POINTER; a_nmemb: NATURAL_64; a_size: NATURAL_64; a_compar: POINTER; an_arg: POINTER) is
 		-- qsort_r
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "qsort_r"
		}"
		end

	quick_exit (a_status: INTEGER_32) is
 		-- quick_exit
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "quick_exit"
		}"
		end

	rand: INTEGER_32 is
 		-- rand
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "rand()"
		}"
		end

	rand_r (a_seed: POINTER): INTEGER_32 is
 		-- rand_r
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "rand_r"
		}"
		end

	random: INTEGER_64 is
 		-- random
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "random()"
		}"
		end

	random_r (a_buf: POINTER; a_result: POINTER): INTEGER_32 is
 		-- random_r
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "random_r"
		}"
		end

	realloc (a_ptr: POINTER; a_size: NATURAL_64): POINTER is
 		-- realloc
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "realloc"
		}"
		end

	rpmatch (a_response: POINTER): INTEGER_32 is
 		-- rpmatch
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "rpmatch"
		}"
		end

	-- `hidden' function __secure_getenv skipped.
	seed48 (a_seed16v: POINTER): POINTER is
 		-- seed48
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "seed48"
		}"
		end

	seed48_r (a_seed16v: POINTER; a_buffer: POINTER): INTEGER_32 is
 		-- seed48_r
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "seed48_r"
		}"
		end

	setenv (a_name: POINTER; a_value: POINTER; a_replace: INTEGER_32): INTEGER_32 is
 		-- setenv
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "setenv"
		}"
		end

	setkey (a_key: POINTER) is
 		-- setkey
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "setkey"
		}"
		end

	setstate (a_statebuf: POINTER): POINTER is
 		-- setstate
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "setstate"
		}"
		end

	setstate_r (a_statebuf: POINTER; a_buf: POINTER): INTEGER_32 is
 		-- setstate_r
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "setstate_r"
		}"
		end

	srand (a_seed: NATURAL_32) is
 		-- srand
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "srand"
		}"
		end

	srand48 (a_seedval: INTEGER_64) is
 		-- srand48
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "srand48"
		}"
		end

	srand48_r (a_seedval: INTEGER_64; a_buffer: POINTER): INTEGER_32 is
 		-- srand48_r
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "srand48_r"
		}"
		end

	srandom (a_seed: NATURAL_32) is
 		-- srandom
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "srandom"
		}"
		end

	srandom_r (a_seed: NATURAL_32; a_buf: POINTER): INTEGER_32 is
 		-- srandom_r
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "srandom_r"
		}"
		end

	strtod (a_nptr: POINTER; an_endptr: POINTER): REAL_64 is
 		-- strtod
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "strtod"
		}"
		end

	strtod_l (a_nptr: POINTER; an_endptr: POINTER; a_loc: POINTER): REAL_64 is
 		-- strtod_l
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "strtod_l"
		}"
		end

	strtof (a_nptr: POINTER; an_endptr: POINTER): REAL_32 is
 		-- strtof
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "strtof"
		}"
		end

	strtof_l (a_nptr: POINTER; an_endptr: POINTER; a_loc: POINTER): REAL_32 is
 		-- strtof_l
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "strtof_l"
		}"
		end

	strtol (a_nptr: POINTER; an_endptr: POINTER; a_base: INTEGER_32): INTEGER_64 is
 		-- strtol
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "strtol"
		}"
		end

	strtol_l (a_nptr: POINTER; an_endptr: POINTER; a_base: INTEGER_32; a_loc: POINTER): INTEGER_64 is
 		-- strtol_l
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "strtol_l"
		}"
		end

	strtold (a_nptr: POINTER; an_endptr: POINTER): REAL_128 is
 		-- strtold
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "strtold"
		}"
		end

	strtold_l (a_nptr: POINTER; an_endptr: POINTER; a_loc: POINTER): REAL_128 is
 		-- strtold_l
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "strtold_l"
		}"
		end

	strtoll (a_nptr: POINTER; an_endptr: POINTER; a_base: INTEGER_32): INTEGER_64 is
 		-- strtoll
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "strtoll"
		}"
		end

	strtoll_l (a_nptr: POINTER; an_endptr: POINTER; a_base: INTEGER_32; a_loc: POINTER): INTEGER_64 is
 		-- strtoll_l
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "strtoll_l"
		}"
		end

	strtoq (a_nptr: POINTER; an_endptr: POINTER; a_base: INTEGER_32): INTEGER_64 is
 		-- strtoq
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "strtoq"
		}"
		end

	strtoul (a_nptr: POINTER; an_endptr: POINTER; a_base: INTEGER_32): NATURAL_64 is
 		-- strtoul
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "strtoul"
		}"
		end

	strtoul_l (a_nptr: POINTER; an_endptr: POINTER; a_base: INTEGER_32; a_loc: POINTER): NATURAL_64 is
 		-- strtoul_l
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "strtoul_l"
		}"
		end

	strtoull (a_nptr: POINTER; an_endptr: POINTER; a_base: INTEGER_32): NATURAL_64 is
 		-- strtoull
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "strtoull"
		}"
		end

	strtoull_l (a_nptr: POINTER; an_endptr: POINTER; a_base: INTEGER_32; a_loc: POINTER): NATURAL_64 is
 		-- strtoull_l
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "strtoull_l"
		}"
		end

	strtouq (a_nptr: POINTER; an_endptr: POINTER; a_base: INTEGER_32): NATURAL_64 is
 		-- strtouq
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "strtouq"
		}"
		end

	system (a_command: POINTER): INTEGER_32 is
 		-- system
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "system"
		}"
		end

	unlockpt (a_fd: INTEGER_32): INTEGER_32 is
 		-- unlockpt
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "unlockpt"
		}"
		end

	unsetenv (a_name: POINTER): INTEGER_32 is
 		-- unsetenv
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "unsetenv"
		}"
		end

	valloc (a_size: NATURAL_64): POINTER is
 		-- valloc
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "valloc"
		}"
		end


end -- class STDLIB_EXTERNALS
