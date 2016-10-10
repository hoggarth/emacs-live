(defun get-todo-list ()
  "Grab my todo list from help.concur.com"
  (interactive)
  (insert (shell-command-to-string "curl -s -u scotth:AxilaPt2 https://help.concur.com/sr/export.csv:searchrequest-csv-current-fields/13293/SearchRequest-13293.csv | tail -n +2 | awk -F ',' '{print \"** TODO [[https://help.concur.com/browse/\" $2 \"][\" $3 \"]]\"}' | sed -e 's/\"//g'")))

(global-set-key (kbd "C-c t") 'get-todo-list)

(defun omniQuickEntry (beg end)
  (interactive "r")
  (do-applescript (concat
                   "tell front document of application \"OmniFocus\"
      tell quick entry
          make new inbox task with properties {name:\""
                   (buffer-substring beg end) "\"}
          activate
          select {inbox task 1}
      end tell
        end tell")))

(global-set-key "\C-cq" 'omniQuickEntry)