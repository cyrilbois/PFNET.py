#***************************************************#
# This file is part of PFNET.                       #
#                                                   #
# Copyright (c) 2015, Tomas Tinoco De Rubira.       #
#                                                   #
# PFNET is released under the BSD 2-clause license. #
#***************************************************#

cdef extern from "pfnet/pfnet.h":

    ctypedef struct Heur
    ctypedef struct Net
    ctypedef struct Vec
    ctypedef struct Constr

    void HEUR_del(Heur* h)
    char* HEUR_get_name(Heur* h)
    Net* HEUR_get_network(Heur* h)
    Heur* HEUR_get_next(Heur* h)

    Heur* HEUR_new(Net* net);

    void HEUR_apply(Heur* h, Constr** cptrs, int cnum, Vec* var_values)

    void HEUR_clear_error(Heur * h);
    bint HEUR_has_error(Heur* h);
    char* HEUR_get_error_string(Heur* h);
    void HEUR_set_error(Heur* h, char* error_string);

    void HEUR_set_name(Heur* h, char* name)

    Heur* HEUR_PVPQ_new(Net* net)
