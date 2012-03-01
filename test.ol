(require (fs "fs")
         (compiler "./compiler")
         (util "util")
         (js "./backends/js")
         (trace "./trace"))

(if (< process.argv.length 3)
    (throw "must pass a filename"))

(let ((src (fs.readFileSync (str "tests/"
                                 (vector-ref process.argv 2))
                            "utf-8"))
      (gen (js)))

  ;; new runtime
  ;;(gen.write-runtime "js")
  (compiler.set-macro-generator gen)

  (let ((f (compiler.expand (read src))))
    ;;(pp f)
    (compiler.parse f gen)
    ((%raw "eval") (gen.get-code))
    ;;(display (gen.get-code))
    ))