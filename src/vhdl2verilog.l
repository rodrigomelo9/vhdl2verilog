/*
  vhdl2verilog, VHDL (93) to Verilog (2001) translator
  Copyright (C) 2017, Rodrigo A. Melo

  This program is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.
 
  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.
 
  You should have received a copy of the GNU General Public License
  along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

%option noyywrap nodefault yylineno case-insensitive

%{
#include "vhdl2verilog.tab.h"
%}

LETTER            [A-Z]
DIGIT             [0-9]

SPACE_CHAR        " "
SPECIAL_CHAR      [\"#&\'()*+,-./:;<=>\[\]_|]
OTHER_CHAR        [¡$%@?\\^{}~!¿]
SPECIAL           {SPACE_CHAR}|{SPECIAL_CHAR}|{OTHER_CHAR}
UNDERLINE         "_"

CHARACTER         {LETTER}|{DIGIT}|{SPECIAL}
BITVALUE          {LETTER}|{DIGIT}|{UNDERLINE}

INTEGER           {DIGIT}(_?{DIGIT}+)*
EXPONENT          E[+-]?{INTEGER}

EDIGIT            [0-9A-F]
EINTEGER          {EDIGIT}(_?{EDIGIT}+)*

%%

"abs"                         { return RW_ABS;           }
"access"                      { return RW_ACCESS;        }
"after"                       { return RW_AFTER;         }
"alias"                       { return RW_ALIAS;         }
"all"                         { return RW_ALL;           }
"and"                         { return RW_AND;           }
"architecture"                { return RW_ARCHITECTURE;  }
"array"                       { return RW_ARRAY;         }
"assert"                      { return RW_ASSERT;        }
"attribute"                   { return RW_ATTRIBUTE;     }
"begin"                       { return RW_BEGIN;         }
"block"                       { return RW_BLOCK;         }
"body"                        { return RW_BODY;          }
"buffer"                      { return RW_BUFFER;        }
"bus"                         { return RW_BUS;           }
"case"                        { return RW_CASE;          }
"component"                   { return RW_COMPONENT;     }
"configuration"               { return RW_CONFIGURATION; }
"constant"                    { return RW_CONSTANT;      }
"disconnect"                  { return RW_DISCONNECT;    }
"downto"                      { return RW_DOWNTO;        }
"else"                        { return RW_ELSE;          }
"elsif"                       { return RW_ELSIF;         }
"end"                         { return RW_END;           }
"entity"                      { return RW_ENTITY;        }
"exit"                        { return RW_EXIT;          }
"file"                        { return RW_FILE;          }
"for"                         { return RW_FOR;           }
"function"                    { return RW_FUNCTION;      }
"generate"                    { return RW_GENERATE;      }
"generic"                     { return RW_GENERIC;       }
"group"                       { return RW_GROUP;         }
"guarded"                     { return RW_GUARDED;       }
"if"                          { return RW_IF;            }
"impure"                      { return RW_IMPURE;        }
"in"                          { return RW_IN;            }
"inertial"                    { return RW_INERTIAL;      }
"inout"                       { return RW_INOUT;         }
"is"                          { return RW_IS;            }
"label"                       { return RW_LABEL;         }
"library"                     { return RW_LIBRARY;       }
"linkage"                     { return RW_LINKAGE;       }
"literal"                     { return RW_LITERAL;       }
"loop"                        { return RW_LOOP;          }
"map"                         { return RW_MAP;           }
"mod"                         { return RW_MOD;           }
"nand"                        { return RW_NAND;          }
"new"                         { return RW_NEW;           }
"next"                        { return RW_NEXT;          }
"nor"                         { return RW_NOR;           }
"not"                         { return RW_NOT;           }
"null"                        { return RW_NULL;          }
"of"                          { return RW_OF;            }
"on"                          { return RW_ON;            }
"open"                        { return RW_OPEN;          }
"or"                          { return RW_OR;            }
"others"                      { return RW_OTHERS;        }
"out"                         { return RW_OUT;           }
"package"                     { return RW_PACKAGE;       }
"port"                        { return RW_PORT;          }
"postponed"                   { return RW_POSTPONED;     }
"procedure"                   { return RW_PROCEDURE;     }
"process"                     { return RW_PROCESS;       }
"pure"                        { return RW_PURE;          }
"range"                       { return RW_RANGE;         }
"record"                      { return RW_RECORD;        }
"register"                    { return RW_REGISTER;      }
"reject"                      { return RW_REJECT;        }
"rem"                         { return RW_REM;           }
"report"                      { return RW_REPORT;        }
"return"                      { return RW_RETURN;        }
"rol"                         { return RW_ROL;           }
"ror"                         { return RW_ROR;           }
"select"                      { return RW_SELECT;        }
"severity"                    { return RW_SEVERITY;      }
"shared"                      { return RW_SHARED;        }
"signal"                      { return RW_SIGNAL;        }
"sla"                         { return RW_SLA;           }
"sll"                         { return RW_SLL;           }
"sra"                         { return RW_SRA;           }
"srl"                         { return RW_SRL;           }
"subtype"                     { return RW_SUBTYPE;       }
"then"                        { return RW_THEN;          }
"to"                          { return RW_TO;            }
"transport"                   { return RW_TRANSPORT;     }
"type"                        { return RW_TYPE;          }
"unaffected"                  { return RW_UNAFFECTED;    }
"units"                       { return RW_UNITS;         }
"until"                       { return RW_UNTIL;         }
"use"                         { return RW_USE;           }
"variable"                    { return RW_VARIABLE;      }
"wait"                        { return RW_WAIT;          }
"when"                        { return RW_WHEN;          }
"while"                       { return RW_WHILE;         }
"with"                        { return RW_WITH;          }
"xnor"                        { return RW_XNOR;          }
"xor"                         { return RW_XOR;           }

"=>"                          { return ARROW;            }
":="                          { return VASSIGN;          }
"<="                          { return LE;               }
">="                          { return GE;               }
"<>"                          { return BOX;              }
"/="                          { return NE;               }
"**"                          { return POW;              }

{LETTER}                      { return LETTER;           }
{DIGIT}                       { return DIGIT;            }
{UNDERLINE}                   { return UNDERLINE;        }

[BOX]\"{BITVALUE}*\"          { return BITSTRING_LITERAL;}
\"{CHARACTER}*\"              { return STRING_LITERAL;   }
\'{CHARACTER}\'               { return CHARACTER_LITERAL;}
{CHARACTER}                   { return CHARACTER;        }

"--".*\n                      {;}
[\t\n\v\f\r]                  {;}

. { return yytext[0]; }

%%

/*
{LETTER}(_?{LETTER_OR_DIGIT}+)* |
\\{CHARACTER}+\\ {
   return IDENTIFIER;
}

{INTEGER}(\.{INTEGER})?{EXPONENT}? |
{INTEGER}#{EINTEGER}(\.{EINTEGER})?#{EXPONENT}? {
   return NUMBER; // ABSTRACT_LITERAL;
}

[BOX]\"({EDIGIT}(_?{EDIGIT}+)*)?\" {
   return BITSTRING; // BIT_STRING_LITERAL;
}
*/
