(lang dune 3.1)
(using menhir 2.0)

(name hdub)

(generate_opam_files true)

(source
 (github watersofoblivion/hdub))

(authors "Jonathan Bryant")

(maintainers "Jonathan Bryant")

(license MIT)

(documentation https://github.com/watersofoblivion/hdub)

(package
 (name sourcery)
 (synopsis "Hardware Playground")
 (description "A place for me to play around with my FPGAs")
 (depends
   ocaml
   dune
   menhir
   odoc
   cmdliner
   ounit2
   ANSITerminal
   bisect_ppx
   landmarks-ppx
   uutf
   uunf
   sedlex))
