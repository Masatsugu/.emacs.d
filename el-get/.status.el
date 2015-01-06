((cl-lib status "installed" recipe
         (:name cl-lib :builtin "24.3" :type elpa :description "Properly prefixed CL functions and macros" :url "http://elpa.gnu.org/packages/cl-lib.html"))
 (el-get status "installed" recipe
         (:name el-get :website "https://github.com/dimitri/el-get#readme" :description "Manage the external elisp bits and pieces you depend upon." :type github :branch "master" :pkgname "dimitri/el-get" :info "." :compile
                ("el-get.*\\.el$" "methods/")
                :load "el-get.el" :post-init
                (when
                    (memq 'el-get
                          (bound-and-true-p package-activated-list))
                  (message "Deleting melpa bootstrap el-get")
                  (unless package--initialized
                    (package-initialize t))
                  (when
                      (package-installed-p 'el-get)
                    (let
                        ((feats
                          (delete-dups
                           (el-get-package-features
                            (el-get-elpa-package-directory 'el-get)))))
                      (el-get-elpa-delete-package 'el-get)
                      (dolist
                          (feat feats)
                        (unload-feature feat t))))
                  (require 'el-get))))
 (git-modes status "installed" recipe
            (:name git-modes :description "GNU Emacs modes for various Git-related files" :type github :pkgname "magit/git-modes"))
 (magit status "installed" recipe
        (:name magit :website "https://github.com/magit/magit#readme" :description "It's Magit! An Emacs mode for Git." :type github :pkgname "magit/magit" :depends
               (cl-lib git-modes)
               :info "." :compile "magit.*.el\\'" :build
               `(("make" "docs"))
               :build/berkeley-unix
               (("gmake" "docs"))
               :build/windows-nt
               (progn nil)))
 (master status "installed" recipe
         (:name master :auto-generated t :type emacswiki :description "make a buffer the master over another buffer" :website "https://raw.github.com/emacsmirror/emacswiki.org/master/master.el"))
 (plsql status "installed" recipe
        (:name plsql :auto-generated t :type emacswiki :description "Programming support for PL/SQL code" :website "https://raw.github.com/emacsmirror/emacswiki.org/master/plsql.el"))
 (sql-complete status "installed" recipe
               (:name sql-complete :auto-generated t :type emacswiki :description "provide completion for tables and columns" :website "https://raw.github.com/emacsmirror/emacswiki.org/master/sql-complete.el"))
 (sql-indent status "installed" recipe
             (:name sql-indent :auto-generated t :type emacswiki :description "indentation of SQL statements" :website "https://raw.github.com/emacsmirror/emacswiki.org/master/sql-indent.el"))
 (sql-transform status "installed" recipe
                (:name sql-transform :auto-generated t :type emacswiki :description "transform SQL statements" :website "https://raw.github.com/emacsmirror/emacswiki.org/master/sql-transform.el"))
 (sqled-mode status "installed" recipe
             (:name sqled-mode :auto-generated t :type emacswiki :description "Major Mode for editing sql, sqlplus and pl/sql code" :website "https://raw.github.com/emacsmirror/emacswiki.org/master/sqled-mode.el")))
