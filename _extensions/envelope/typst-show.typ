// Typst custom formats typically consist of a 'typst-template.typ' (which is
// the source code for a typst template) and a 'typst-show.typ' which calls the
// template's function (forwarding Pandoc metadata values as required)
//
// This is an example 'typst-show.typ' file (based on the default template  
// that ships with Quarto). It calls the typst function named 'article' which 
// is defined in the 'typst-template.typ' file. 
//
// If you are creating or packaging a custom typst template you will likely
// want to replace this file and 'typst-template.typ' entirely. You can find
// documentation on creating typst templates here and some examples here:
//   - https://typst.app/docs/tutorial/making-a-template/
//   - https://github.com/typst/templates

#show: doc => envelope(

$if(recipient)$
$if(recipient/allbutlast)$
  recipient: [$for(recipient)$$recipient$$sep$\ $endfor$],
$else$
  recipient: [$recipient$],
$endif$
$endif$

$if(envelope_type)$
  envelope_type: [$envelope_type$],
$endif$

$if(sender)$
$if(sender/allbutlast)$
  sender: [$for(sender)$$sender$$sep$\ $endfor$],
$else$
  sender: [$sender$],
$endif$
$endif$

$if(sender-fontsize)$
  sender-fontsize: [$sender-fontsize$],
$endif$

$if(recipient-fontsize)$
  recipient-fontsize: [$recipient-fontsize$],
$endif$


$if(recipient-shift-x)$
  recipient-shift-x: [$recipient-shift-x$],
$endif$

$if(recipient-shift-y)$
  recipient-shift-y: [$recipient-shift-y$],
$endif$
  
  )