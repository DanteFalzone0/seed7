/********************************************************************/
/*                                                                  */
/*  s7   Seed7 interpreter                                          */
/*  Copyright (C) 1990 - 2008  Thomas Mertes                        */
/*                                                                  */
/*  This program is free software; you can redistribute it and/or   */
/*  modify it under the terms of the GNU General Public License as  */
/*  published by the Free Software Foundation; either version 2 of  */
/*  the License, or (at your option) any later version.             */
/*                                                                  */
/*  This program is distributed in the hope that it will be useful, */
/*  but WITHOUT ANY WARRANTY; without even the implied warranty of  */
/*  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the   */
/*  GNU General Public License for more details.                    */
/*                                                                  */
/*  You should have received a copy of the GNU General Public       */
/*  License along with this program; if not, write to the           */
/*  Free Software Foundation, Inc., 51 Franklin Street,             */
/*  Fifth Floor, Boston, MA  02110-1301, USA.                       */
/*                                                                  */
/*  Module: Compiler data reflection                                */
/*  File: seed7/src/rfl_data.c                                      */
/*  Changes: 1991-1995, 2007, 2008  Thomas Mertes                   */
/*  Content: Primitive actions for the ref_list type.               */
/*                                                                  */
/********************************************************************/

#define LOG_FUNCTIONS 0
#define VERBOSE_EXCEPTIONS 0

#include "version.h"

#include "stdlib.h"
#include "stdio.h"

#include "common.h"
#include "data.h"
#include "data_rtl.h"
#include "heaputl.h"
#include "flistutl.h"
#include "listutl.h"
#include "rtl_err.h"

#undef EXTERN
#define EXTERN
#include "rfl_data.h"



/**
 *  Append the ref_list 'extension' to 'dest'.
 *  The 'extension' must be a temporary (that would be deleted
 *  afterwards). If the actual 'extension' is not a temporary
 *  a copy of it must be provided to rflAppend.
 */
void rflAppend (listType *const dest, const listType extension)

  {
    listType list1_end;

  /* rflAppend */
    if (*dest != NULL) {
      list1_end = *dest;
      while (list1_end->next != NULL) {
        list1_end = list1_end->next;
      } /* while */
      list1_end->next = extension;
    } else {
      *dest = extension;
    } /* if */
  } /* rflAppend */



/**
 *  Concatenate two ref_lists ('list1' and 'list2').
 *  The parameters 'list1' and 'list2' must be a temporaries
 *  (that would be deleted afterwards). If they are not temporaries
 *  a copy of the parameter must be provided to rflAppend.
 *  @return the result of the concatenation.
 */
listType rflCat (listType list1, const listType list2)

  {
    listType result;

  /* rflCat */
    if (list1 != NULL) {
      result = list1;
      while (list1->next != NULL) {
        list1 = list1->next;
      } /* while */
      list1->next = list2;
    } else {
      result = list2;
    } /* if */
    return result;
  } /* rflCat */



/**
 *  Compare two listType values.
 *  @return -1, 0 or 1 if the first argument is considered to be
 *          respectively less than, equal to, or greater than the
 *          second.
 */
inline intType rflCmp (const_listType list1, const_listType list2)

  {
    intType signumValue;

  /* rflCmp */
    while (list1 != NULL && list2 != NULL &&
        list1->obj == list2->obj) {
      list1 = list1->next;
      list2 = list2->next;
    } /* while */
    if (list1 == NULL) {
      if (list2 == NULL) {
        signumValue = 0;
      } else {
        signumValue = -1;
      } /* if */
    } else if (list2 == NULL) {
      signumValue = 1;
    } else if ((memSizeType) (list1->obj) < (memSizeType) (list2->obj)) {
      signumValue = -1;
    } else {
      signumValue = (memSizeType) (list1->obj) > (memSizeType) (list2->obj);
    } /* if */
    return signumValue;
  } /* rflCmp */



/**
 *  Reinterpret the generic parameters as listType and call rflCmp.
 *  Function pointers in C programs generated by the Seed7 compiler
 *  may point to this function. This assures correct behaviour even
 *  if sizeof(genericType) != sizeof(listType).
 *  @return -1, 0 or 1 if the first argument is considered to be
 *          respectively less than, equal to, or greater than the
 *          second.
 */
intType rflCmpGeneric (const genericType value1, const genericType value2)

  { /* rflCmpGeneric */
    return rflCmp((const_listType) ((const_rtlObjectType *) &value1)->value.listValue,
                  (const_listType) ((const_rtlObjectType *) &value2)->value.listValue);
  } /* rflCmpGeneric */



/**
 *  Assign source to *dest.
 *  A copy function assumes that *dest contains a legal value.
 *  @exception MEMORY_ERROR Not enough memory to create dest.
 */
void rflCpy (listType *const dest, const const_listType source)

  {
    listType help_list;
    errInfoType err_info = OKAY_NO_ERROR;

  /* rflCpy */
    if (source != *dest) {
      help_list = copy_list(source, &err_info);
      if (unlikely(err_info != OKAY_NO_ERROR)) {
        raise_error(MEMORY_ERROR);
      } else {
        free_list(*dest);
        *dest = help_list;
      } /* if */
    } /* if */
  } /* rflCpy */



/**
 *  Reinterpret the generic parameters as listType and call rflCpy.
 *  Function pointers in C programs generated by the Seed7 compiler
 *  may point to this function. This assures correct behaviour even
 *  if sizeof(genericType) != sizeof(listType).
 */
void rflCpyGeneric (genericType *const dest, const genericType source)

  { /* rflCpyGeneric */
    rflCpy((listType *) &((rtlObjectType *) dest)->value.listValue,
           (const_listType) ((const_rtlObjectType *) &source)->value.listValue);
  } /* rflCpyGeneric */



/**
 *  Return a copy of source, that can be assigned to a new destination.
 *  It is assumed that the destination of the assignment is undefined.
 *  Create functions can be used to initialize Seed7 constants.
 *  @return a copy of source.
 *  @exception MEMORY_ERROR Not enough memory to represent the result.
 */
listType rflCreate (const const_listType source)

  {
    errInfoType err_info = OKAY_NO_ERROR;
    listType result;

  /* rflCreate */
    result = copy_list(source, &err_info);
    if (unlikely(err_info != OKAY_NO_ERROR)) {
      raise_error(MEMORY_ERROR);
      result = NULL;
    } /* if */
    return result;
  } /* rflCreate */



/**
 *  Generic Create function to be used via function pointers.
 *  Function pointers in C programs generated by the Seed7 compiler
 *  may point to this function. This assures correct behaviour even
 *  if sizeof(genericType) != sizeof(listType).
 */
genericType rflCreateGeneric (const genericType from_value)

  {
    rtlObjectType result;

  /* rflCreateGeneric */
    INIT_GENERIC_PTR(result.value.genericValue);
    result.value.listValue =
        (rtlListType) rflCreate((const_listType) ((const_rtlObjectType *) &from_value)->value.listValue);
    return result.value.genericValue;
  } /* rflCreateGeneric */



/**
 *  Free the memory referred by 'old_list'.
 *  After rflDestr is left 'old_list' refers to not existing memory.
 *  The memory where 'old_list' is stored can be freed afterwards.
 */
void rflDestr (const listType old_list)

  { /* rflDestr */
    free_list(old_list);
  } /* rflDestr */



/**
 *  Generic Destr function to be used via function pointers.
 *  Function pointers in C programs generated by the Seed7 compiler
 *  may point to this function. This assures correct behaviour even
 *  if sizeof(genericType) != sizeof(listType).
 */
void rflDestrGeneric (const genericType old_value)

  { /* rflDestrGeneric */
    rflDestr((listType) ((const_rtlObjectType *) &old_value)->value.listValue);
  } /* rflDestrGeneric */



boolType rflElem (const const_objectType searched_object, const_listType list_element)

  { /* rflElem */
    logFunction(printf("rflElem(" FMT_U_MEM ", " FMT_U_MEM ")\n",
                       (memSizeType) searched_object,
                       (memSizeType) list_element););
    while (list_element != NULL && list_element->obj != searched_object) {
      list_element = list_element->next;
    } /* while */
    if (list_element != NULL) {
      return TRUE;
    } else {
      return FALSE;
    } /* if */
  } /* rflElem */



/**
 *  Assign reference 'source' to the 'position' of the 'dest'.
 *   A @:= [B] C;
 *  is equivalent to
 *   A := A[..pred(B)] & make_list(C) & A[succ(B)..];
 *  @exception INDEX_ERROR If 'position' is negative or zero, or
 *             an element beyond 'dest' would be overwritten
 *             ('position' > length('dest') holds).
 */
void rflElemcpy (listType dest, intType position, objectType elem)

  { /* rflElemcpy */
    logFunction(printf("rflElemcpy(" FMT_U_MEM ", " FMT_D ", " FMT_U_MEM")\n",
                       (memSizeType) dest, position, (memSizeType) elem););
    if (unlikely(position <= 0)) {
      logError(printf("rflElemcpy(" FMT_U_MEM ", " FMT_D ", " FMT_U_MEM"): "
                      "Index <= 0.\n",
                      (memSizeType) dest, position, (memSizeType) elem););
      raise_error(INDEX_ERROR);
    } else {
      position--;
      while (position != 0 && dest != NULL) {
        position--;
        dest = dest->next;
      } /* while */
      if (unlikely(dest == NULL)) {
        logError(printf("rflElemcpy(" FMT_U_MEM ", " FMT_D ", " FMT_U_MEM"): "
                        "Index > length(dest).\n",
                        (memSizeType) dest, position, (memSizeType) elem););
        raise_error(INDEX_ERROR);
      } else {
        dest->obj = elem;
      } /* if */
    } /* if */
  } /* rflElemcpy */



/**
 *  Check if two ref_lists are equal.
 *  @return TRUE if both ref_lists are equal,
 *          FALSE otherwise.
 */
boolType rflEq (const_listType list1, const_listType list2)

  {
    boolType isEqual;

  /* rflEq */
    while (list1 != NULL && list2 != NULL &&
        list1->obj == list2->obj) {
      list1 = list1->next;
      list2 = list2->next;
    } /* while */
    if (list1 == NULL && list2 == NULL) {
      isEqual = TRUE;
    } else {
      isEqual = FALSE;
    } /* if */
    return isEqual;
  } /* rflEq */



/**
 *  Get a sublist from 'list' ending at the 'stop' position.
 *  The first element in a 'ref_list' has the position 1.
 *  @return the substring ending at the 'stop' position.
 *  @exception MEMORY_ERROR Not enough memory to represent the result.
 */
listType rflHead (const listType list, intType stop)

  {
    intType number;
    listType stop_element;
    listType saved_list_rest;
    errInfoType err_info = OKAY_NO_ERROR;
    listType result;

  /* rflHead */
    logFunction(printf("rflHead(" FMT_U_MEM ", " FMT_D ")\n",
                       (memSizeType) list, stop););
    if (stop >= 1) {
      number = 1;
      stop_element = list;
      while (number < stop && stop_element != NULL) {
        number++;
        stop_element = stop_element->next;
      } /* while */
      if (stop_element != NULL) {
        saved_list_rest = stop_element->next;
        stop_element->next = NULL;
        result = copy_list(list, &err_info);
        stop_element->next = saved_list_rest;
      } else {
        result = copy_list(list, &err_info);
      } /* if */
      if (unlikely(err_info != OKAY_NO_ERROR)) {
        raise_error(MEMORY_ERROR);
        result = NULL;
      } /* if */
    } else {
      result = NULL;
    } /* if */
    return result;
  } /* rflHead */



/**
 *  Access one element from the 'ref_list' 'list'.
 *  @return the element with the specified 'position' from 'list'.
 *  @exception INDEX_ERROR If the index is less than 1 or
 *             greater than the length of the 'ref_list'.
 */
objectType rflIdx (const_listType list, intType position)

  {
    objectType result;

  /* rflIdx */
    logFunction(printf("rflIdx(" FMT_U_MEM ", " FMT_D ")\n",
                       (memSizeType) list, position););
    if (unlikely(position <= 0)) {
      logError(printf("rflIdx(" FMT_U_MEM ", " FMT_D "): Index <= 0.\n",
                      (memSizeType) list, position););
      raise_error(INDEX_ERROR);
      result = NULL;
    } else {
      position--;
      while (position != 0 && list != NULL) {
        position--;
        list = list->next;
      } /* while */
      if (unlikely(list == NULL)) {
        logError(printf("rflIdx(" FMT_U_MEM ", " FMT_D "): "
                        "Index > length(list).\n",
                        (memSizeType) list, position););
        raise_error(INDEX_ERROR);
        result = NULL;
      } else {
        result = list->obj;
      } /* if */
    } /* if */
    return result;
  } /* rflIdx */



void rflIncl (listType *list, objectType elem)

  {
    errInfoType err_info = OKAY_NO_ERROR;

  /* rflIncl */
    incl_list(list, elem, &err_info);
    if (unlikely(err_info != OKAY_NO_ERROR)) {
      raise_error(MEMORY_ERROR);
    } /* if */
  } /* rflIncl */



/**
 *  Determine the length of a 'ref_list'.
 *  @return the length of the 'ref_list'.
 */
intType rflLng (const_listType list)

  {
    intType length = 0;

  /* rflLng */
    while (list != NULL) {
      list = list->next;
      length++;
    } /* while */
    return length;
  } /* rflLng */



listType rflMklist (objectType elem)

  {
    listType result;

  /* rflMklist */
    if (unlikely(!ALLOC_L_ELEM(result))) {
      raise_error(MEMORY_ERROR);
      result = NULL;
    } else {
      result->next = NULL;
      result->obj = elem;
    } /* if */
    return result;
  } /* rflMklist */



intType rflPos (const_listType list_element, const const_objectType searched_object)

  {
    intType result;

  /* rflPos */
    result = 1;
    while (list_element != NULL &&
        list_element->obj != searched_object) {
      list_element = list_element->next;
      result++;
    } /* while */
    if (list_element == NULL) {
      result = 0;
    } /* if */
    return result;
  } /* rflPos */



intType rflIpos (listType list_element, objectType searched_object,
    const intType from_index)

  {
    intType result;

  /* rflIpos */
    result = 1;
    while (list_element != NULL && result < from_index) {
      list_element = list_element->next;
      result++;
    } /* while */
    while (list_element != NULL &&
        list_element->obj != searched_object) {
      list_element = list_element->next;
      result++;
    } /* while */
    if (list_element == NULL) {
      result = 0;
    } /* if */
    return result;
  } /* rflIpos */



/**
 *  Get a sublist from a 'start' position to a 'stop' position.
 *  The first element in a 'ref_list' has the position 1.
 *  @return the substring from position start to stop.
 *  @exception MEMORY_ERROR Not enough memory to represent the result.
 */
listType rflRange (const listType list, intType start, intType stop)

  {
    intType number;
    listType start_element;
    listType stop_element;
    listType saved_list_rest;
    errInfoType err_info = OKAY_NO_ERROR;
    listType result;

  /* rflRange */
    logFunction(printf("rflRange(" FMT_U_MEM ", " FMT_D ", " FMT_D ")\n",
                       (memSizeType) list, start, stop););
    number = 1;
    start_element = list;
    while (number < start && start_element != NULL) {
      number++;
      start_element = start_element->next;
    } /* while */
    if (start_element != NULL && stop >= start) {
      stop_element = start_element;
      while (number < stop && stop_element != NULL) {
        number++;
        stop_element = stop_element->next;
      } /* while */
      if (stop_element != NULL) {
        saved_list_rest = stop_element->next;
        stop_element->next = NULL;
        result = copy_list(start_element, &err_info);
        stop_element->next = saved_list_rest;
      } else {
        result = copy_list(start_element, &err_info);
      } /* if */
    } else {
      result = NULL;
    } /* if */
    if (unlikely(err_info != OKAY_NO_ERROR)) {
      raise_error(MEMORY_ERROR);
      result = NULL;
    } /* if */
    return result;
  } /* rflRange */



/**
 *  Get a sublist from 'list' beginning at a 'start' position.
 *  The first element in a 'ref_list' has the position 1.
 *  @return the sublist beginning at the 'start' position.
 *  @exception MEMORY_ERROR Not enough memory to represent the result.
 */
listType rflTail (const_listType list, intType start)

  {
    errInfoType err_info = OKAY_NO_ERROR;
    listType tail;

  /* rflTail */
    logFunction(printf("rflTail(" FMT_U_MEM ", " FMT_D ")\n",
                       (memSizeType) list, start););
    if (start >= 2 && list != NULL) {
      start -= 2;
      list = list->next;
      while (start != 0 && list != NULL) {
        start--;
        list = list->next;
      } /* while */
    } /* if */
    tail = copy_list(list, &err_info);
    if (unlikely(err_info != OKAY_NO_ERROR)) {
      raise_error(MEMORY_ERROR);
    } /* if */
    return tail;
  } /* rflTail */
