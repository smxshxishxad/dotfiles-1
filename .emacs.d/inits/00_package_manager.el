;; ------------------------------------------------------------------------
;; Name     : el-get.el
;; Function : eLisp管理
;; Install  : cd public_repos 
;;            git clone git@github.com:dimitri/el-get.git
;; ------------------------------------------------------------------------
;; ダウンロードしていないときはダウンロード
;; TODO どうもうまく動作していないようだ。調査する。
(unless (require 'el-get nil t)
  (url-retrieve
   "https://raw.github.com/dimitri/el-get/master/el-get-install.el"
   (lambda (s)
     (goto-char (point-max))
     (eval-print-last-sexp))))

;; ダウンロードしたelisp置き場
(setq el-get-dir "~/.emacs.d/el-get/repo")

;; レシピ置き場
;;(setq el-get-recipe-path (list "~/.emacs.d/el-get/recipes/emacswiki"
;;			       "~/.emacs.d/el-get/recipes"))
;; 追加のレシピ置き場
(add-to-list 'el-get-recipe-path "~/.emacs.d/el-get/user-recipes")
;;(add-to-list 'el-get-recipe-path '("~/.emacs.d/el-get/user-recipes/myemacswiki"))
;;(add-to-list 'el-get-recipe-path '("~/.emacs.d/el-get/user-recipes"))

(setq el-get-user-package-directory "~/.emacs.d/el-get/init-files")

;; auto install el-get.el
(defvar my/el-get-packages
  '(
    helm
    yasnippet
    vbasense
    visual-basic-mode
    ruby-block
    robe-mode
    ruby-electric
    rspec-mode
    ruby-refactor
    rcodetools
    anything-rdefs
    inf-ruby
    auto-complete
    auto-complete-ruby
    yaml-mode
    popwin
    flycheck
    flycheck-color-mode-line
    anzu
    auto-highlight-symbol
    highlight-symbol
    multiple-cursors
    color-theme
    ;; smart-compile 独自改造したものをelispにおいた
    helm-descbinds
    anything
    gist
    flymake
    helm-gist
    helm-c-yasnippet
    markdown-mode
    expand-region
    powerline 
    molokai-theme
    cool-mode
    plantuml-mode
    metaweblog
    xml-rpc-el
    tempbuf
    org2blog
    org-mode
    org-pomodoro
    rainbow-mode
    wanderlust
    esup
    helm-github-issues
    helm-open-github
;;    setup
    exec-path-from-shell
    migemo
    org-gcal
    calfw
    org-pandoc
    howm
    magit
    pdf-tools
    direx
    stripe-buffer
;;    helm-shell-history
    ;; elscreen
    multi-term
    ;; この2つは特別なので一番最後におく
;;    init-loader
;;    el-get
    )
  "A list of packages to install from el-get at launch.")

;; syncを外してみる。
;; proxy配下で起動が遅くなるので。
;; (el-get 'sync my/el-get-packages)
