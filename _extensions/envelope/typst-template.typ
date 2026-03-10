
// This is an example typst template (based on the default template that ships
// with Quarto). It defines a typst function named 'article' which provides
// various customization options. This function is called from the
// 'typst-show.typ' file (which maps Pandoc metadata function arguments)
//
// If you are creating or packaging a custom typst template you will likely
// want to replace this file and 'typst-show.typ' entirely. You can find
// documentation on creating typst templates and some examples here:
//   - https://typst.app/docs/tutorial/making-a-template/
//   - https://github.com/typst/templates


#let envelope_dimensions(envelope_type) = {
  // Accept "HxW" string in mm, e.g. "125x185", or a predefined format name
  let parts = envelope_type.split("x")
  if parts.len() == 2 {
    (float(parts.at(0)) * 1mm, float(parts.at(1)) * 1mm)
  } else if envelope_type == "C4" {
    (22.9cm, 32.4cm)
  } else if envelope_type == "C5" {
    (16.2cm, 22.9cm)
  } else if envelope_type == "C6" {
    (11.4cm, 16.2cm)
  } else if envelope_type == "DL" {
    (11.0cm, 22.0cm)
  } else if envelope_type == "B4" {
    (25.0cm, 35.3cm)
  } else if envelope_type == "B5" {
    (17.6cm, 25.0cm)
  } else if envelope_type == "#10" { // US #10 Envelope
    (10.5cm, 24.1cm)
  } else if envelope_type == "#9" { // US #9 Envelope
    (9.8cm, 22.5cm)
  } else if envelope_type == "Monarch" { // Monarch Envelope
    (9.8cm, 19.0cm)
  } else if envelope_type == "A2" { // A2 Envelope
    (11.1cm, 14.6cm)
  } else {
    panic("Unknown envelope type:", envelope_type)
  }
}


#let envelope(
  sender: none,
  recipient: none,
  envelope_type: "DL", // set via 'size' YAML key
  font:(),
  sender-fontsize: 11pt,
  recipient-fontsize: 14pt,

  sender-width: 30%,
  recipient-width: 40%,
  recipient-shift-x: -10%,
  recipient-shift-y: 10%
  ) = {

  let (height, width) = envelope_dimensions(envelope_type)

  // Allow numeric font sizes (e.g. 12 → 12pt)
  let sender-fontsize = if type(sender-fontsize) == int or type(sender-fontsize) == float { sender-fontsize * 1pt } else { sender-fontsize }
  let recipient-fontsize = if type(recipient-fontsize) == int or type(recipient-fontsize) == float { recipient-fontsize * 1pt } else { recipient-fontsize }

  set page(
    width: width,
    height: height,
    margin: (x: 0.5cm, y: 0.5cm),
    numbering: none
  )

  set text(font: font)

  place(
    top + left,
    rect(width: sender-width,
         height: 25%,
         fill: white,
         align(
          left,
          text(sender, size: sender-fontsize))
          )
  )

  place(
    horizon + right,
    dx: recipient-shift-x,
    dy: recipient-shift-y,
    rect(width: recipient-width,
        height: 30%,
        fill: white,
        align(
          left,
          text(recipient, size: recipient-fontsize)
          )
        )
  )

}
