#include <ruby.h>
#include <string.h>
#include <sapi/embed/php_embed.h>

VALUE Karas = Qnil;
char * buffer = NULL;
int errors = 0;

void Init_karas();
VALUE method_eval(VALUE self, VALUE php_code);

void Init_karas() {
	Karas = rb_define_module("Karas");
	rb_define_singleton_method(Karas, "evaluate", method_eval, 1);
}

static int karas_ub_write(const char *str, unsigned int strlen) {
	buffer = malloc(strlen + 1);
	strcpy(buffer, str);
	return strlen;
}

static void karas_log_message(char * message) {
	errors++;
}

VALUE method_eval(VALUE self, VALUE php_code) {
	char *php_c_code;
	int argc = 1;
	char *argv[2] = { "Karas", NULL };
	buffer = NULL;
	errors = 0;

	php_c_code = StringValuePtr(php_code);

	php_embed_module.ub_write = karas_ub_write;
	php_embed_module.log_message = karas_log_message;

	PHP_EMBED_START_BLOCK (argc, argv);

	zend_eval_string(php_c_code, NULL, "Karas");

	PHP_EMBED_END_BLOCK ();

	if(errors > 0) return Qfalse;
	if(buffer != NULL) return rb_str_new2(buffer);
	return Qtrue;
}
