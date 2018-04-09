#cython: embedsignature=True

#***************************************************#
# This file is part of PFNET.                       #
#                                                   #
# Copyright (c) 2015, Tomas Tinoco De Rubira.       #
#                                                   #
# PFNET is released under the BSD 2-clause license. #
#***************************************************#

cimport cheur

class HeuristicError(Exception):
    """
    Heuristic error exception.
    """

    pass

cdef class HeuristicBase:
    """
    Base heuristic class.
    """
    
    cdef cheur.Heur* _c_heur
    cdef bint _alloc
    cdef Network _net

    def __init__(self):
        """
        Base heuristic class.
        """

        pass

    def __cinit__(self):

        self._c_heur = NULL
        self._alloc = False
        self._net = None

    def __dealloc__(self):
        """
        Frees heuristic C data structure.
        """

        if self._alloc:
            cheur.HEUR_del(self._c_heur)
            self._c_heur = NULL
            self._alloc = False
            self._net = None

    def apply(self, constraints, values):
        """
        Applies heuristic.

        Parameters
        ----------
        constraints : 
        values :
        """

        cdef np.ndarray[double,mode='c'] x = values

        ## TODO

    def clear_error(self):
        """
        Clears error flag and string.
        """

        cheur.HEUR_clear_error(self._c_heur)

    property name:
        """ Heuristic name (string). """
        def __get__(self): return cheur.HEUR_get_name(self._c_heur).decode('UTF-8')
        def __set__(self,name): 
            name = name.encode('UTF-8')
            cheur.HEUR_set_name(self._c_heur,name)

    property network:
        """ Network associated with heuristic (|Network|). """
        def __get__(self): return new_Network(cheur.HEUR_get_network(self._c_heur))

cdef new_Heuristic(cheur.Heur* h):
    if h is not NULL:
        heur = HeuristicBase()
        heur._c_heur = h
        return heur
    else:
        raise HeuristicError('invalid heuristic data')
