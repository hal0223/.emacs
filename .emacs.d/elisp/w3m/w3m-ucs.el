﻿;;; w3m-ucs.el --- CCL programs to process Unicode.

;; Copyright (C) 2001, 2005, 2007 TSUCHIYA Masatoshi <tsuchiya@namazu.org>

;; Authors: TSUCHIYA Masatoshi <tsuchiya@namazu.org>,
;;          ARISAWA Akihiro <ari@mbf.sphere.ne.jp>
;; Keywords: w3m, WWW, hypermedia

;; This file is a part of emacs-w3m.

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

;;; Commentary:

;; This file contains CCL codes to handle UCS characters in emacs-w3m.
;; For more detail about emacs-w3m, see:
;;
;;    http://emacs-w3m.namazu.org/

;; This module requires `Mule-UCS' package.  It can be downloaded from:
;;
;;    ftp://ftp.m17n.org/pub/mule/Mule-UCS/

;;; Code:

;; Enable XEmacs 21.5-Mule to compile this module anyway.
(eval-when-compile
  (if (featurep 'xemacs)
      (let ((mucs-ignore-version-incompatibilities t))
	(defvar font-ccl-encoder-alist nil)
	(require 'un-define))))

(require 'un-define)
(require 'w3m-ccl)

(eval-and-compile
  (autoload 'w3m-make-ccl-coding-system "w3m"))

(defun w3m-ucs-to-char (codepoint)
  (condition-case nil
      (or (ucs-to-char codepoint) ?~)
    (error ?~)))

(eval-and-compile
  (defconst w3m-ccl-get-ucs-codepoint-with-mule-ucs
    '(;; (1) Convert a set of r1 (charset-id) and r0 (codepoint) to a
      ;; character in Emacs internal representation.
      (if (r0 > 255)
	  ((r4 = (r0 & 127))
	   (r0 = (((r0 >> 7) * 96) + r4))
	   (r0 |= (r1 << 16)))
	((r0 |= (r1 << 16))))
      ;; (2) Convert a character in Emacs to a UCS codepoint.
      (call emacs-char-to-ucs-codepoint-conversion)
      (if (r0 <= 0)
	  (write-repeat ?~)))		; unknown character.
    "CCL program to convert multibyte char to ucs with Mule-UCS."))

(define-ccl-program w3m-euc-japan-mule-ucs-encoder
  `(4
    (loop
     ,@w3m-ccl-write-euc-japan-character
     ,@w3m-ccl-get-ucs-codepoint-with-mule-ucs
     ,@w3m-ccl-generate-ncr)))

(w3m-make-ccl-coding-system
 'w3m-euc-japan-mule-ucs ?E
 "ISO 2022 based EUC encoding for Japanese with w3m internal characters.
A character that can not be encoded with `euc-japan' is converted to a
UCS codepoint with Mule-UCS, and the codepoint is represented as a
string which represents the character in Numeric Character
References (NCR).
  (generated by `w3m')"
 'w3m-euc-japan-decoder
 'w3m-euc-japan-mule-ucs-encoder)

(define-ccl-program w3m-iso-latin-1-mule-ucs-encoder
  `(4
    (loop
     ,@w3m-ccl-write-iso-latin-1-character
     ,@w3m-ccl-get-ucs-codepoint-with-mule-ucs
     ,@w3m-ccl-generate-ncr)))

(w3m-make-ccl-coding-system
 'w3m-iso-latin-1-mule-ucs ?1
 "ISO 2022 based 8-bit encoding for Latin-1 with w3m internal characters.
A character that can not be encoded with `iso-latin-1' is converted to
a UCS codepoint with Mule-UCS, and the codepoint is represented as a
string which represents the character in Numeric Character
References (NCR).
  (generated by `w3m')"
 'w3m-iso-latin-1-decoder
 'w3m-iso-latin-1-mule-ucs-encoder)

(provide 'w3m-ucs)
;;; w3m-ucs.el ends here.
