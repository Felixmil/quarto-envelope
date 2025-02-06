
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
  if envelope_type == [C4] {
    (22.9cm, 32.4cm)
  } else if envelope_type == [C5] {
    (16.2cm, 22.9cm)
  } else if envelope_type == [C6] {
    (11.4cm, 16.2cm)
  } else if envelope_type == [DL] {
    (11.0cm, 22.0cm)
  } else if envelope_type == [B4] {
    (25.0cm, 35.3cm)
  } else if envelope_type == [B5] {
    (17.6cm, 25.0cm)
  } else if envelope_type == [#10] { // US #10 Envelope
    (10.5cm, 24.1cm)
  } else if envelope_type == [#9] { // US #9 Envelope
    (9.8cm, 22.5cm)
  } else if envelope_type == [Monarch] { // Monarch Envelope
    (9.8cm, 19.0cm)
  } else if envelope_type == [A2] { // A2 Envelope
    (11.1cm, 14.6cm)
  } else {
    panic("Unknown envelope type:", envelope_type)
  }
}


#let envelope(
  sender: none,
  recipient: none,
  envelope_type: "DL",
  font:(),
  sender-fontsize: 11pt,
  recipient-fontsize: 14pt,
  recipient-shift-x: -10%,
  recipient-shift-y: 10%
  ) = { 
  
  let (height, width) = envelope_dimensions(envelope_type)
  
  set page(
    width: width,
    height: height,
    margin: (x: 0.5cm, y: 0.5cm)
  )
  
  set text(font: font)
           
  place(
    top + left,
    rect(width: 30%,
         height: 25%,
         fill: gray,
         align(
          left,
          text(sender, size: sender-fontsize))
          )
  )
  
  place(
    horizon + right,
    dx: recipient-shift-x,
    dy: recipient-shift-y,
    rect(width: 35%,
        height: 30%,
        fill: gray,
        align(
          left,
          text(recipient, size: recipient-fontsize)
          )
        )
  )

}