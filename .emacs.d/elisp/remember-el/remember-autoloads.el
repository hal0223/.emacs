﻿;;; remember-autoloads.el --- autoloads for Remember
;;
;;; Code:

;;;### (autoloads (remember-diary-extract-entries remember-clipboard
;;;;;;  remember-other-frame remember) "remember" "remember.el" (19531
;;;;;;  53864))
;;; Generated autoloads from remember.el

(autoload (quote remember) "remember" "\
Remember an arbitrary piece of data.
INITIAL is the text to initially place in the *Remember* buffer,
or nil to bring up a blank *Remember* buffer.

With a prefix or a visible region, use the region as INITIAL.

\(fn &optional INITIAL)" t nil)

(autoload (quote remember-other-frame) "remember" "\
Call `remember' in another frame.

\(fn &optional INITIAL)" t nil)

(autoload (quote remember-clipboard) "remember" "\
Remember the contents of the current clipboard.
Most useful for remembering things from Netscape or other X Windows
application.

\(fn)" t nil)

(autoload (quote remember-diary-extract-entries) "remember" "\
Extract diary entries from the region.

\(fn)" nil nil)

;;;***

;;;### (autoloads (remember-location remember-url) "remember-bibl"
;;;;;;  "remember-bibl.el" (19531 53864))
;;; Generated autoloads from remember-bibl.el

(autoload (quote remember-url) "remember-bibl" "\
Remember a URL in `bibl-mode' that is being visited with w3.

\(fn)" t nil)

(autoload (quote remember-location) "remember-bibl" "\
Remember a bookmark location in `bibl-mode'.

\(fn)" t nil)

;;;***

;;;### (autoloads (remember-blosxom) "remember-blosxom" "remember-blosxom.el"
;;;;;;  (19531 53864))
;;; Generated autoloads from remember-blosxom.el

(autoload (quote remember-blosxom) "remember-blosxom" "\
Remember this text to a blosxom story.
This function can be added to `remember-handler-functions'.

\(fn)" nil nil)

;;;***

;;;### (autoloads (remember-emacs-wiki-journal-add-entry-maybe remember-emacs-wiki-journal-add-entry-auto
;;;;;;  remember-emacs-wiki-journal-add-entry) "remember-emacs-wiki-journal"
;;;;;;  "remember-emacs-wiki-journal.el" (19531 53864))
;;; Generated autoloads from remember-emacs-wiki-journal.el

(autoload (quote remember-emacs-wiki-journal-add-entry) "remember-emacs-wiki-journal" "\
Prompt for category and heading and add entry.

\(fn)" nil nil)

(autoload (quote remember-emacs-wiki-journal-add-entry-auto) "remember-emacs-wiki-journal" "\
Add entry where the category is the first word and the heading the
rest of the words on the first line.

\(fn)" nil nil)

(autoload (quote remember-emacs-wiki-journal-add-entry-maybe) "remember-emacs-wiki-journal" "\
Like `remember-emacs-wiki-journal-add-entry-auto' but only adds
entry if the first line matches `emacs-wiki-journal-category-regexp'.

\(fn)" nil nil)

;;;***

;;;### (autoloads (remember-planner-append) "remember-planner" "remember-planner.el"
;;;;;;  (19531 53864))
;;; Generated autoloads from remember-planner.el

(autoload (quote remember-planner-append) "remember-planner" "\
Remember this text to PAGE or today's page.
This function can be added to `remember-handler-functions'.

\(fn &optional PAGE)" nil nil)

;;;***

;;;### (autoloads nil nil ("read-file-name.el" "remember-experimental.el")
;;;;;;  (19531 54053 328000))

;;;***

;;;### (autoloads (remember-bbdb-store-in-mailbox) "remember-bbdb"
;;;;;;  "remember-bbdb.el" (19531 53864))
;;; Generated autoloads from remember-bbdb.el

(autoload (quote remember-bbdb-store-in-mailbox) "remember-bbdb" "\
Store remember data as if it were incoming mail.
In which case `remember-mailbox' should be the name of the mailbox.
Each piece of psuedo-mail created will have an `X-Todo-Priority'
field, for the purpose of appropriate splitting.

\(fn)" nil nil)

;;;***

(provide 'remember-autoloads)
;;; remember-autoloads.el ends here
;;
;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:

