#{
  import "/lib/std.typ"
  show: doc => std.setup(
    [
      *Hello, World!*
    ],
    doc,
  )

  include "content.typ"
}
