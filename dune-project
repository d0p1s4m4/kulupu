(lang dune 3.4)

(name kulupu)

(generate_opam_files true)

(source
 (github d0p1s4m4/kulupu))

(authors "d0p1")

(maintainers "d0p1")

(license "AGPL-3.0-or-later")

(documentation https://url/to/documentation)

(package
 (name kulupu)
 (synopsis "a tiny a fediverse server")
 (description "a tiny a fediverse server")
 (depends ocaml dune dream yojson uri ppx_yojson_conv)
 (tags
  (topics "to describe" your project)))

; See the complete stanza docs at https://dune.readthedocs.io/en/stable/dune-files.html#dune-project
