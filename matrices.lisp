;; 20220209_1843

;; woo wee. it feels like the night is getting away from me. only 6:43 though.
;; let's go stretch the legs and come back and get to work on some problems.

;; whatever interests us tonight we will go for.

;; 20220209_1921

;; we have learned several new functions that have incredible use.
;;
;; some of this stuff is straight up ripped off notes from freely available articles.
;; other bits are from recollection. either way, it is all organized in order to organize my own thoughts.
;; in this way, perhaps it is actually a useful flow of information.

;; `car' or `first' returns the first `atom' out of a `list'

;; `cdr' or `rest' returns the `list' containing all atoms after the first

;; `nthcdr' takes an integer argument and a list and returns the nth `cdr' function on that list

;; `nth' takes an integer argument and a list and returns the car of the nth cdr. in other words,
;; `nth' returns the car of the nth entry starting from n=0


;; `subseq' takes a list as an arguments and then two positive integer values representing the
;; entries in the list. for example, (subseq '(1 2 3 4) 0 2) will return (1 2). the 0 and 2
;; in the function represent a half-closed interval [0,2).

;; lisp lists start with entry number one representing n=0. therefore the interval for entries
;; [0,2) returns the 0th, and 1st entries, in this case (1 2).


;; all of these functions put together creating a powerful framework to work within. i am
;; almost dizzy about it at this point. we need to stay grounded and go back to fundamentals.


;; a scalar can be represented by itself

13 ; will evaluate to itself

;; a scalar is a real number and is a type of atom in lisp (indivisible stored symbol).

;; atoms can be grouped together into lists using the `list' function.

(list 13) ; is a list containing one scalar atom. it evaluates to (13)

;; lists can also be used to represent atoms made up of non-numeric characters

(list 'hello 'goodbye) ; is a list containing 2 word atoms and evaluates to (HELLO GOODBYE)

;; the apostrophe tells the interpreter that you are not trying to call on some declared variable
;; with some defined value. instead, the apostrophe is telling the interpreter that you intend
;; to really put the symbolic atom `hello' in that location.

(list 13 31) ; is a list containing two scalar atoms. it evaluates to (13 31).

;; the list (13 31) can be looked at as a 1x2 row vector. because the data is represented
;; horizontally, we will get used to transposing between row vectors and column vectors.
;; if we learn how to universally see row vectors and column vectors as lists, then we will
;; have better conceptual grasp on what we are doing. we will also gain consistency.


;; you can define a 2x2 vector by creating a list of lists (in this case, 1 list containing 2 inner lists) where each list has 2 entries (n0, n1).

;; because we are often concerned with linear systems, we will consider the entries scalars that may or may not represent the values of coefficients.
;; we will denote the scalars with the naming scheme a_ij where i is the row number and j is the column number.

(defun 2x2 (a1-1 a1-2
            a2-1 a2-2)
  (list
   (list a1-1 a1-2)
   (list a2-1 a2-2)))

;; you can imagine the car and cdr values to be paired input values.

;; car is the main input value of a cons cell (constructed cell) which point to a cdr cell that follows it. 
;; that following cell is either nil or it is another cons cell which points to either nil or some
;; other cons cell. most chains of cons cells eventually terminate in a nil value.

;; the value that car points to is called the cdr. the cdr, from its own perspect is its own car which points to
;; its own unique cdr (which can also contain a car pointed to another cdr). this occurs until a nil endpoint is reached.

;; in this way lists are chains of cars which contain memory of their related cdrs which allows the list to be
;; connected in the first place. in this way, the values can be chained together for more abstract manipulations, but
;; the individual atoms can still be accessed. this organization allows for a large number of possible manipulations.

;; as can be seen, lisp even understands these cars in terms of n numbers of entries, where
;; the first entry in the list is n=0.


;; the key to understanding lists is to understand that they're largely an illusion built on top of objects that are instances of a more
;; primitive data type. those objects are the pairs of values we have been talking about (known as `cons_cells').

;; cons takes two arguments and returns a new cons cell containing the two values. these values can be references to any kind of object. unless the
;; second value is nil or another cons cell, a cons is printed as the two values in parentheses separated by a dot, a so-called dotted. pair.

(cons 1 2)

;; to reiterate. the two values in a cons cell are called the `car' and the `cdr' after the names of the functions used to access them.

;; in the beginning, these names were mnemonic, at least to the folks implementing the first Lisp on an IBM 704. but even then they were just lifed
;; from the assembly mnemonics used to implement the operations. however, it's not all bad that these names are somewhat meaningless--when
;; considering individual cons cells, it's best to think of them as an arbitrary pair of values without any particular semantics. thus:

(car (cons 1 2)) ; returns 1
(cdr (cons 1 2)) ; returns 2


;; both car and cdr are also `setf-able' spaces. given an existing cons cell, it's possible to assign a new value to either of its values.

(defparameter *cons* (cons 1 2))
*cons*
(setf (car *cons*) 10)
*cons*
(setf (cdr *cons*) 20)
*cons*

;; because the values in a cons cell can be references to any kind of object, you can build larger structures out of cons cells by linking them
;; together. lists are built by linking together cons cells in a chain. the elements of the list are held in the cars of the cons cells while the
;; links to subsequent cons cells are held in the cdrs. the last cell in the chain has a cdr of nil, which represents the empty list as well as
;; the boolean value `false'.

;; this arrangement is called a `singly_linked_list' and is found in other languages. lisp provides exceptional support for this simple data type.

;; when someone says that a particular value is a `list' what is really meant is that the value is either nil or a reference to a cons cell.
;; the car of the cons cell is the first item of the list, and the cdr is a reference to another list, that is, another cons cell or nil,
;; containing the remaining elements. the lisp printer understands this convention and prints such chains of cons cells as parenthesized lists
;; rather than as dotted pairs.


;; the following function will sum together the entries of two 2x2 matrices of the form:

;;            matrix1 = ((a1-1 a1-2) (a2-1 a2-2))
;;            matrix2 = ((b1-1 b1-2) (b2-1 b2-2))

;;            matrix1 + matrix2 = (([a1-1 + b1-1] [a1-2 + b1-2]) ([a2-1 + b2-1] [a2-2 + b2-2]))

(defun add-2x2 (matrix1 matrix2)
  (list
   (list
    (+
     (car (car matrix1))
     (car (car matrix2)))
    (+
     (car (cdr (car matrix1)))
     (car (cdr (car matrix2)))))
   (list
    (+
     (car (car (cdr matrix1)))
     (car (car (cdr matrix2))))
    (+
     (car (cdr (car (cdr matrix1))))
     (car (cdr (car (cdr matrix2))))))))
       
