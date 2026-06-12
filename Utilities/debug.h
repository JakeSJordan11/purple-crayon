#include <stdarg.h>
#include <stdio.h>

#define BLACK "30"
#define RED "31"
#define GREEN "32"
#define YELLOW "33"
#define BLUE "34"
#define MAGENTA "35"
#define CYAN "36"
#define WHITE "37"
#define BRIGHT_BLACK "90" // gray
#define BRIGHT_RED "91"
#define BRIGHT_GREEN "92"
#define BRIGHT_YELLOW "93"
#define BRIGHT_BLUE "94"
#define BRIGHT_MAGENTA "95" // closest to purple
#define BRIGHT_CYAN "96"
#define BRIGHT_WHITE "97"

// #define PRINTCOLOR(color, ...) printf("\033[" color "m " __VA_ARGS__
// "\033[0m\n")

static inline void print_color(const char *color, const char *fmt, ...)
    __attribute__((format(printf, 2, 3)));

static inline void print_color(const char *color, const char *fmt, ...) {
  va_list args;
  va_start(args, fmt);
  printf("\033[%sm ", color);
  vprintf(fmt, args);
  printf("\033[0m\n");
  va_end(args);
}